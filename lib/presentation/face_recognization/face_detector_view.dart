import 'dart:developer' as dev;
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
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:hive/hive.dart';

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
      performanceMode: FaceDetectorMode.accurate,
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
        if (user != null && !widget.isUserRegistring) {
          setState(() {
            _canProcess = false;
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
            // setState(() {
            //   _canProcess = false;
            // });
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
