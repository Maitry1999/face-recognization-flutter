import 'dart:developer' as dev;
import 'dart:io';
import 'dart:math';

import 'package:attandence_system/domain/account/account.dart';
import 'package:attandence_system/infrastructure/account/account_entity.dart';
import 'package:attandence_system/infrastructure/core/network/hive_box_names.dart';
import 'package:attandence_system/injection.dart';
import 'package:attandence_system/presentation/common/utils/flushbar_creator.dart';
import 'package:attandence_system/presentation/common/utils/get_current_user.dart';
import 'package:attandence_system/presentation/face_recognization/face_detector_painter.dart';
import 'package:attandence_system/presentation/services/ml_service.dart';
import 'package:auto_route/auto_route.dart';
import 'package:camera/camera.dart';
import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:hive/hive.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';
import 'detector_view.dart';

@RoutePage(name: 'FaceDetectorView')
class FaceDetectorView extends StatefulWidget {
  final bool isUserRegistring;
  final bool forDownloadData;
  const FaceDetectorView(
      {super.key, this.isUserRegistring = false, this.forDownloadData = false});

  @override
  State<FaceDetectorView> createState() => _FaceDetectorViewState();
}

class _FaceDetectorViewState extends State<FaceDetectorView> {
  final FaceDetector _faceDetector = FaceDetector(
    options: FaceDetectorOptions(
      enableContours: true,
      enableLandmarks: true,
      enableTracking: true,
      enableClassification: true,
      minFaceSize: 1,
    ),
  );
  bool _canProcess = true;
  bool _isBusy = false;
  CustomPaint? _customPaint;
  String? _text;
  var _cameraLensDirection = CameraLensDirection.front;

  @override
  void dispose() {
    _canProcess = false;
    _faceDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DetectorView(
      title: 'Face Detector',
      customPaint: _customPaint,
      text: _text,
      onImage: _processImage,
      initialCameraLensDirection: _cameraLensDirection,
      onCameraLensDirectionChanged: (value) => _cameraLensDirection = value,
    );
  }

  Future<void> _processImage(Map<CameraImage, InputImage> inputImage) async {
    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;
    setState(() {
      _text = '';
    });
    print(inputImage);
    final faces =
        await _faceDetector.processImage(inputImage.entries.first.value);

    if (inputImage.entries.first.value.metadata?.size != null &&
        inputImage.entries.first.value.metadata?.rotation != null) {
      final painter = FaceDetectorPainter(
        faces,
        inputImage.entries.first.value.metadata!.size,
        inputImage.entries.first.value.metadata!.rotation,
        _cameraLensDirection,
      );
      _customPaint = CustomPaint(painter: painter);
    } else {
      String text = 'Faces found: ${faces.length}\n\n';
      for (final face in faces) {
        text += 'face: ${face.boundingBox}\n\n';
      }
      _text = text;

      _customPaint = null;
    }
    _isBusy = false;

    if (doesCurrentUserExist() && faces.isNotEmpty) {
      getIt<MLService>()
          .setCurrentPrediction(inputImage.entries.first.key, faces.first);
      if (isFullFaceRecognized(faces.first, 1)) {
        Account? user = await getIt<MLService>().predict();
        if (widget.forDownloadData) {
          if (user != null) {
            setState(() {
              _canProcess = false;
              _faceDetector.close();
            });
            if (user.isAdmin == true) {
              generateUserPunchInOutReport();
            } else {
              showError(message: 'Only Admin can download this report')
                  .show(context)
                  .then(
                (value) async {
                  // await updatePunchInOutTime(user.userId ?? '');
                  context.router.maybePop();
                },
              );
            }
          }
        }
        if (user != null &&
            !widget.isUserRegistring &&
            !widget.forDownloadData) {
          setState(() {
            _canProcess = false;
            _faceDetector.close();
          });
          showSuccess(
                  message:
                      '${user.firstName} ${user.lastName} is detected successfully')
              .show(context)
              .then(
            (value) async {
              await updatePunchInOutTime(user.userId ?? '');
              context.router.maybePop();
            },
          );
        }
        dev.log('Same User Found : ${user?.firstName}');
      }

      // Call the update method after detecting the user
    }

    if (faces.isNotEmpty) {
      Face boundingBoxes = faces.first;

      if (isFullFaceRecognized(boundingBoxes, 1) && widget.isUserRegistring) {
        await Future.delayed(
          Duration(seconds: 4),
          () async {
            setState(() {
              _canProcess = false;
              _faceDetector.close();
            });
            await context.router
                .maybePop([inputImage.entries.first.key, boundingBoxes]);
          },
        );
      }
    }
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> updatePunchInOutTime(String userId) async {
    // Open the Hive box
    var box = Hive.box<AccountEntity>(BoxNames.currentUser);

    // Find the index of the user
    int userIndex =
        box.values.toList().indexWhere((account) => account.userId == userId);

    // Check if the user exists
    if (userIndex != -1) {
      // Get the existing AccountEntity
      AccountEntity existingUser = box.getAt(userIndex)!;

      // Update the punchInOutTime
      List<DateTime> updatedPunchInOutTime = [
        ...(existingUser.punchInOutTime ?? []), // Keep existing times
        DateTime.now(), // Add current time
      ];

      // Create a new instance of AccountEntity with updated punchInOutTime
      AccountEntity updatedUser = AccountEntity(
        existingUser.userId,
        existingUser.firstName,
        existingUser.lastName,
        existingUser.email,
        existingUser.countryCode,
        existingUser.phone,
        existingUser.designation,
        existingUser.profileImage,
        updatedPunchInOutTime, // Update this field
        existingUser.faceData,
        existingUser.boundingBoxes,
        existingUser.predictedData,
        existingUser.isAdmin,
      );

      // Save the updated user back to the Hive box
      await box.putAt(userIndex, updatedUser);
      dev.log(
          'Updated Punch In/Out Time for User ${existingUser.firstName} ${existingUser.lastName}: $updatedPunchInOutTime');
    } else {
      dev.log('User with userId: $userId not found in Hive.');
    }
  }

  Future<void> generateUserPunchInOutReport() async {
    // Fetch user data
    // Assuming getCurrentUser and other methods are already defined

    List<AccountEntity> users =
        getCurrentUser().map((e) => AccountEntity.fromDomain(e)).toList();

// Create a PDF document
    final pdf = pw.Document();

// Group the data together for all users without generating new pages for each user
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Text('Punch In/Out Times Report',
                  style: pw.TextStyle(fontSize: 24)),
              pw.SizedBox(height: 20),
              // Iterate through each user and display their punch-in/out times in the same table
              ...users.map((user) {
                if (user.punchInOutTime != null &&
                    user.punchInOutTime!.isNotEmpty) {
                  // Group by date
                  Map<DateTime, List<DateTime>> punchTimesByDate = {};
                  for (var punchTime in user.punchInOutTime!) {
                    DateTime dateOnly = DateTime(
                        punchTime.year, punchTime.month, punchTime.day);
                    punchTimesByDate
                        .putIfAbsent(dateOnly, () => [])
                        .add(punchTime);
                  }

                  return pw.Column(
                    children: [
                      pw.Text(
                        'Punch In/Out Times for ${user.firstName} ${user.lastName}',
                        style: pw.TextStyle(
                            fontSize: 20, fontWeight: pw.FontWeight.bold),
                      ),
                      pw.SizedBox(height: 10),
                      pw.Table.fromTextArray(
                        context: context,
                        data: <List<String>>[
                          <String>['Date', 'Punch Times'],
                          ...punchTimesByDate.entries.map((entry) {
                            String date =
                                '${entry.key.day}/${entry.key.month}/${entry.key.year}';
                            String punchTimes = entry.value
                                .map((time) => '${time.hour}:${time.minute}')
                                .join(', ');
                            return [date, punchTimes];
                          }),
                        ],
                      ),
                      pw.SizedBox(height: 20), // Space between users
                    ],
                  );
                } else {
                  return pw
                      .SizedBox(); // Empty if no punch times exist for user
                }
              }),
            ],
          );
        },
      ),
    );

// Request the necessary permissions
    var status = await Permission.storage.request();

    if (status.isGranted) {
      // Get external storage path for downloads directory
      var path = await ExternalPath.getExternalStoragePublicDirectory(
          ExternalPath.DIRECTORY_DOWNLOADS);

      // if (path == null) {
      //   print("Failed to get the external storage path.");
      //   return;
      // }

      // Construct the file path where the PDF will be saved
      final filePath = "$path/punch_in_out_report_${DateTime.now()                                            }.pdf";
      final file = File(filePath);

      // Save the PDF file to the specified path
      try {
        await file.writeAsBytes(await pdf.save());
        print("PDF saved to: $filePath");
      } catch (e) {
        print("Error saving PDF: $e");
      }
    } else {
      print("Permission denied. Cannot save to external storage.");
    }
  }

  bool isFullFaceRecognized(Face face, double minFaceSize) {
    return isFullFaceDetected(face) &&
        isFullFaceContoursDetected(face) &&
        isFaceProperlySized(face, minFaceSize) &&
        isFaceWellPositioned(face);
  }

  bool isFaceProperlySized(Face face, double minFaceSize) {
    // Calculate face size based on bounding box
    double faceWidth = face.boundingBox.width;
    double faceHeight = face.boundingBox.height;
    double imageSize = max(faceWidth, faceHeight); // Use the larger dimension

    // Ensure face size is above a minimum threshold
    return imageSize >= minFaceSize;
  }

  bool isFullFaceDetected(Face face) {
    // Check if all critical landmarks are detected
    bool hasLeftEye = face.landmarks[FaceLandmarkType.leftEye] != null;
    bool hasRightEye = face.landmarks[FaceLandmarkType.rightEye] != null;
    bool hasNose = face.landmarks[FaceLandmarkType.noseBase] != null;
    bool hasMouth = face.landmarks[FaceLandmarkType.bottomMouth] != null;

    // Return true if all key landmarks are present, indicating full face detection
    return hasLeftEye && hasRightEye && hasNose && hasMouth;
  }

  bool isFullFaceContoursDetected(Face face) {
    // Check if major contours are detected
    bool hasFaceContour = face.contours[FaceContourType.face] != null;
    bool hasLeftEyebrow = face.contours[FaceContourType.leftEyebrowTop] != null;
    bool hasRightEyebrow =
        face.contours[FaceContourType.rightEyebrowTop] != null;
    bool hasUpperLip = face.contours[FaceContourType.upperLipTop] != null;
    bool hasLowerLip = face.contours[FaceContourType.lowerLipBottom] != null;

    // Return true if all main contours are detected, indicating a full face
    return hasFaceContour &&
        hasLeftEyebrow &&
        hasRightEyebrow &&
        hasUpperLip &&
        hasLowerLip;
  }

  bool isFaceWellPositioned(Face face) {
    // Check face angles to ensure it's not excessively tilted
    double? angleX = face.headEulerAngleX;
    double? angleY = face.headEulerAngleY;
    double? angleZ = face.headEulerAngleZ;

    // Allow some tolerance for natural tilt, e.g., ±15 degrees
    bool isPositionedWell = (angleX != null && angleX.abs() < 15) &&
        (angleY != null && angleY.abs() < 15) &&
        (angleZ != null && angleZ.abs() < 15);

    return isPositionedWell;
  }
}
