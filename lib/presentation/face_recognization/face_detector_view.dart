import 'dart:developer' as dev;
import 'dart:io';
import 'package:attandence_system/domain/account/account.dart';
import 'package:attandence_system/domain/core/math_utils.dart';
import 'package:attandence_system/infrastructure/account/account_entity.dart';
import 'package:attandence_system/infrastructure/core/network/hive_box_names.dart';
import 'package:attandence_system/infrastructure/punch_in_out/punch_in_out_entity.dart';
import 'package:attandence_system/presentation/common/utils/flushbar_creator.dart';
import 'package:attandence_system/presentation/common/utils/get_current_user.dart';
import 'package:attandence_system/presentation/core/app_router.gr.dart';
import 'package:attandence_system/presentation/core/buttons/common_button.dart';
import 'package:attandence_system/presentation/face_recognization/detector_painters.dart';
import 'package:attandence_system/presentation/face_recognization/utils.dart';
import 'package:auto_route/auto_route.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:external_path/external_path.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:hive/hive.dart';
import 'package:camera/camera.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:image/image.dart' as imglib;
import 'package:permission_handler/permission_handler.dart';
import 'package:tflite_flutter/tflite_flutter.dart' as tfl;
import 'package:quiver/collection.dart';
import 'package:flutter/services.dart';

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
  late File jsonFile;
  dynamic _scanResults;
  CameraController? _camera;
  tfl.Interpreter? interpreter;
  bool _isDetecting = false;
  bool isCapture = false;
  CustomPainter? painter;
  CameraLensDirection _direction = CameraLensDirection.front;
  dynamic data = {};
  double threshold = 1;
  Directory? tempDir;
  List<double>? e1; // Specify that this list will hold doubles
  bool _faceFound = false;
  var userId = '';
  bool isDownloadTapped = false;
  @override
  void initState() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    _initializeCamera();
    super.initState();
  }

  Future<void> loadModel() async {
    try {
      final gpuDelegateV2 = tfl.GpuDelegateV2(
        options: tfl.GpuDelegateOptionsV2(),
      );

      var interpreterOptions = tfl.InterpreterOptions()
        ..addDelegate(gpuDelegateV2);
      interpreter = await tfl.Interpreter.fromAsset(
          'assets/mobilefacenet.tflite',
          options: interpreterOptions);
    } on Exception {
      print('Failed to load model.');
    }
  }

  Future<void> _initializeCamera() async {
    await loadModel();
    CameraDescription description = await getCamera(_direction);

    InputImageRotation rotation = rotationIntToImageRotation(
      description.sensorOrientation,
    );

    _camera = CameraController(
      description,
      ResolutionPreset.low,
      enableAudio: false,
      imageFormatGroup: Platform.isAndroid
          ? ImageFormatGroup.nv21
          : ImageFormatGroup.bgra8888,
    );

    if (_camera != null) {
      await _camera?.initialize().then(
        (value) async {
          if (!mounted) {
            return;
          }
          // await Future.delayed(Duration(milliseconds: 500));
          // tempDir = await getApplicationDocumentsDirectory();
          // String embPath = '${tempDir!.path}/emb.json';
          // jsonFile = File(embPath);
          // if (jsonFile.existsSync()) {
          //   data = json.decode(jsonFile.readAsStringSync());
          // }

          _camera?.startImageStream((CameraImage image) {
            if (_isDetecting) return;
            _isDetecting = true;
            dynamic finalResult = Multimap<String, Face>();

            var isUserAdmin = false;
            detect(image, _getDetectionMethod(), rotation).then(
              (dynamic result) async {
                _faceFound = result.isNotEmpty;
                for (Face face in result) {
                  double x, y, w, h;
                  x = (face.boundingBox.left - 10);
                  y = (face.boundingBox.top - 10);
                  w = (face.boundingBox.width + 10);
                  h = (face.boundingBox.height + 10);
                  imglib.Image convertedImage =
                      _convertCameraImage(image, _direction);
                  imglib.Image croppedImage = imglib.copyCrop(convertedImage,
                      x.round(), y.round(), w.round(), h.round());
                  croppedImage = imglib.copyResizeCropSquare(croppedImage, 112);
                  var res = _recog(croppedImage);
                  finalResult.add('${res.firstName} ${res.lastName}', face);

                  userId = res.userId ?? "";
                  setState(() {});
                  isUserAdmin = res.isAdmin ?? false;
                }

                setState(() {
                  _scanResults = finalResult;
                  isDownloadTapped = isUserAdmin;
                });

                _isDetecting = false;
              },
            ).catchError(
              (e) {
                print(e);
                _isDetecting = false;
              },
            );
          });
        },
      );
    }
    isCapture = false;
    setState(() {});
  }

  Future<void> updatePunchInOutTime(String userId,
      {required bool isPunchIn}) async {
    // Open the Hive box
    var box = Hive.box<AccountEntity>(BoxNames.currentUser);

    // Find the index of the user
    int userIndex =
        box.values.toList().indexWhere((account) => account.userId == userId);

    // Check if the user exists
    if (userIndex != -1) {
      // Get the existing AccountEntity
      AccountEntity existingUser = box.getAt(userIndex)!;

      // Get the user's existing punch in/out records or initialize an empty list
      List<PunchInOutRecord> punchInOutRecords =
          existingUser.punchInOutTime ?? [];

      DateTime now = DateTime.now();

      if (isPunchIn) {
        // Check for any existing punch-in records without a punch-out
        if (punchInOutRecords.isNotEmpty &&
            punchInOutRecords.last.punchOut == null) {
          // Log or show a message indicating the user forgot to punch out
          dev.log(
              'Warning: User ${existingUser.firstName} ${existingUser.lastName} forgot to punch out for the last session.');
          showError(
                  message:
                      'Note: You have not punched out for your last session.')
              .show(context);
          // Return early to avoid adding a new punch-in record
          return;
        }
        // Punch-In: Add a new entry for punch-in (start a new record)
        punchInOutRecords.add(
            PunchInOutRecord(now, null)); // Set punch-out to null initially
      } else {
        // Punch-Out: Update the latest punch-in record's punch-out time
        if (punchInOutRecords.isNotEmpty) {
          PunchInOutRecord lastRecord = punchInOutRecords.last;

          // Check if the last record's punch-in and punch-out times are the same
          if (lastRecord.punchOut != null) {
            // Handle the case where punch-out is clicked without a matching punch-in
            dev.log('Error: Cannot punch out without a matching punch in.');
            showError(
                    message:
                        'Cannot punch out without a punch in. Please do punch in first.')
                .show(context);
            return;
          }

          // Update the punch-out time to the current time
          punchInOutRecords[punchInOutRecords.length - 1] =
              PunchInOutRecord(lastRecord.punchIn, now);
        } else {
          // No punch-in records exist, can't punch out without punch-in
          dev.log('Error: Cannot punch out without any punch in records.');
          showError(
                  message:
                      'Cannot punch out without a punch in record. Please do punch in first.')
              .show(context);
          return;
        }
      }

      // Create a new AccountEntity with the updated punch in/out records
      AccountEntity updatedUser = AccountEntity(
        existingUser.userId,
        existingUser.firstName,
        existingUser.lastName,
        existingUser.email,
        existingUser.countryCode,
        existingUser.phone,
        existingUser.designation,
        punchInOutRecords, // Updated punch in/out records
        existingUser.predictedData,
        existingUser.isAdmin,
      );

      // Save the updated user back to the Hive box
      await box.putAt(userIndex, updatedUser);

      // Log the update
      dev.log(
          'Updated Punch ${isPunchIn ? 'In' : 'Out'} Time for User ${existingUser.firstName} ${existingUser.lastName}: $punchInOutRecords');

      // Navigate to success screen
      context.router
          .push(PageRouteInfo(SuccessScreen.name,
              args: SuccessScreenArgs(
                  message:
                      'Updated Punch ${isPunchIn ? 'In' : 'Out'} Time for Employee ${existingUser.firstName} ${existingUser.lastName}')))
          .then((value) async {
        context.router.popUntil((route) => route.isFirst);
      });
    } else {
      // Log if the user is not found
      dev.log('User with userId: $userId not found in Hive.');
    }
  }

  HandleDetection _getDetectionMethod() {
    final faceDetector = FaceDetector(
      options: FaceDetectorOptions(
        performanceMode: FaceDetectorMode.accurate,
      ),
    );
    return faceDetector.processImage;
  }

  Widget _buildResults() {
    const Text noResultsText = Text('');
    if (_scanResults == null || !_camera!.value.isInitialized) {
      return noResultsText;
    }

    final Size imageSize = Size(
      _camera!.value.previewSize!.height,
      _camera!.value.previewSize!.width,
    );
    painter = FaceDetectorPainter(imageSize, _scanResults);

    return CustomPaint(
      painter: painter,
    );
  }

  Widget _buildImage() {
    if (_camera == null || !(_camera!.value.isInitialized || isCapture)) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_camera == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Center(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            CameraPreview(_camera!),
            _buildResults(),
            Positioned.fill(
              bottom: getSize(80),
              left: getSize(20),
              right: getSize(20),
              child: Visibility(
                visible: !widget.forDownloadData,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Visibility(
                        visible: !widget.isUserRegistring,
                        child: CommonButton(
                          backgroundColor:
                              (userId.isNotEmpty && !widget.forDownloadData)
                                  ? null
                                  : Colors.grey,
                          onPressed: userId.isNotEmpty &&
                                  !widget.forDownloadData
                              ? () {
                                  updatePunchInOutTime(userId, isPunchIn: true);
                                }
                              : () {},
                          buttonText: 'In',
                        ),
                      ),
                      SizedBox(
                        height: getSize(10),
                      ),
                      Visibility(
                        visible: !widget.isUserRegistring,
                        child: CommonButton(
                          backgroundColor:
                              (userId.isNotEmpty && !widget.forDownloadData)
                                  ? null
                                  : Colors.grey,
                          onPressed:
                              userId.isNotEmpty && !widget.forDownloadData
                                  ? () {
                                      updatePunchInOutTime(userId,
                                          isPunchIn: false);
                                    }
                                  : () {},
                          buttonText: 'Out',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  Future<void> _toggleCameraDirection() async {
    if (_direction == CameraLensDirection.back) {
      _direction = CameraLensDirection.front;
    } else {
      _direction = CameraLensDirection.back;
    }

    setState(() {
      _camera = null;
    });

    _initializeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildImage(),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Visibility(
            visible: widget.forDownloadData,
            child: FloatingActionButton(
              //backgroundColor: (_faceFound) ? null : Colors.blueGrey,
              onPressed: () async {
                if (isDownloadTapped) {
                  generateUserPunchInOutReport();
                } else {
                  await context.router
                      .push(
                    PageRouteInfo(
                      SuccessScreen.name,
                      args: SuccessScreenArgs(
                          message:
                              'Only admin can download report. Please contact your admin',
                          showWarning: true),
                    ),
                  )
                      .then(
                    (value) {
                      context.router.popUntil(
                        (route) => route.isFirst,
                      );
                    },
                  );
                }
              },
              heroTag: null,
              child: Icon(Icons.download),
            ),
          ),
          SizedBox(
            height: getSize(10),
          ),
          Visibility(
            visible: widget.isUserRegistring,
            child: FloatingActionButton(
              backgroundColor: (_faceFound) ? null : Colors.blueGrey,
              onPressed: () {
                if (_faceFound) _addLabel();
              },
              heroTag: null,
              child: Icon(Icons.add),
            ),
          ),
          SizedBox(
            height: getSize(10),
          ),
          FloatingActionButton(
            onPressed: _toggleCameraDirection,
            heroTag: null,
            child: _direction == CameraLensDirection.back
                ? const Icon(Icons.camera_front)
                : const Icon(Icons.camera_rear),
          ),
        ],
      ),
    );
  }

  imglib.Image _convertCameraImage(CameraImage image, CameraLensDirection dir) {
    int width = image.width;
    int height = image.height;
    var img = imglib.Image(width, height); // Create Image buffer
    const int hexFF = 0xFF000000;
    final int uvyButtonStride = image.planes[0].bytesPerRow;
    final int uvPixelStride = image.planes[0].bytesPerPixel!;
    for (int x = 0; x < width; x++) {
      for (int y = 0; y < height; y++) {
        final int uvIndex =
            uvPixelStride * (x / 2).floor() + uvyButtonStride * (y / 2).floor();
        final int index = y * width + x;
        final yp = image.planes[0].bytes[index];
        final up = image.planes[0].bytes[uvIndex];
        final vp = image.planes[0].bytes[uvIndex];
        int r = (yp + vp * 1436 / 1024 - 179).round().clamp(0, 255);
        int g = (yp - up * 46549 / 131072 + 44 - vp * 93604 / 131072 + 91)
            .round()
            .clamp(0, 255);
        int b = (yp + up * 1814 / 1024 - 227).round().clamp(0, 255);
        img.data[index] = hexFF | (b << 16) | (g << 8) | r;
      }
    }
    var img1 = (dir == CameraLensDirection.front)
        ? imglib.copyRotate(img, -90)
        : imglib.copyRotate(img, 90);
    return img1;
  }

  Account _recog(imglib.Image img) {
    List input = imageToByteListFloat32(img, 112, 128, 128);
    input = input.reshape([1, 112, 112, 3]);
    var output = List.filled(192, 0).reshape([1, 192]);
    interpreter?.run(input, output);
    e1 = output[0].cast<double>();
    return _nearestNeighbor();
  }

  Account _nearestNeighbor() {
    double minDist = double.maxFinite;
    Account label = Account(firstName: 'Not', lastName: ' Recognized');
    for (var key in getCurrentUser()) {
      List<double>? e2 = key.predictedData;
      double d = euclideanDistance(e1!, e2!);
      if (d < threshold && d < minDist) {
        minDist = d;
        label = key;
      }
    }
    return label;
  }

  Future<void> _addLabel() async {
    if (widget.isUserRegistring && e1 != null && e1!.isNotEmpty) {
      if (userId.isNotEmpty && _scanResults != null) {
        ListMultimap<String, Face> data =
            _scanResults as ListMultimap<String, Face>;
        await context.router
            .push(
              PageRouteInfo(
                SuccessScreen.name,
                args: SuccessScreenArgs(
                  message:
                      'User is already available with this name : ${data.keys.first}',
                  showWarning: true,
                ),
              ),
            )
            .then(
              (value) => context.router.popUntil(
                (route) => route.isFirst,
              ),
            );

        return;
      } else {
        await context.router.maybePop(e1);
      }
    }
  }

  Future<void> generateUserPunchInOutReport() async {
    // Fetch user data
    List<AccountEntity> users =
        getCurrentUser().map((e) => AccountEntity.fromDomain(e)).toList();

    // Create a PDF document
    final pdf = pw.Document();

    // Create a date format for the time in AM/PM format
    final timeFormat = DateFormat('h:mm:ss a');

    // Add a page to the PDF document
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Text('Punch In/Out Times Report',
                  style: pw.TextStyle(fontSize: 24)),
              pw.SizedBox(height: 20),
              // Iterate through each user and display their punch-in/out times
              ...users.map((user) {
                if (user.punchInOutTime != null &&
                    user.punchInOutTime!.isNotEmpty) {
                  // Group punch-in and punch-out records by date
                  Map<String, List<PunchInOutRecord>> groupedRecords = {};
                  for (var record in user.punchInOutTime!) {
                    String dateKey =
                        '${record.punchIn.day}/${record.punchIn.month}/${record.punchIn.year}';
                    if (!groupedRecords.containsKey(dateKey)) {
                      groupedRecords[dateKey] = [];
                    }
                    groupedRecords[dateKey]!.add(record);
                  }

                  return pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      // Display user details
                      pw.Text(
                        'User ID: ${user.userId}',
                        style: pw.TextStyle(
                            fontSize: 16, fontWeight: pw.FontWeight.bold),
                      ),
                      pw.Text(
                        'Name: ${user.firstName} ${user.lastName}',
                        style: pw.TextStyle(fontSize: 16),
                      ),
                      pw.Text(
                        'Email: ${user.email}',
                        style: pw.TextStyle(fontSize: 16),
                      ),
                      pw.SizedBox(height: 10),

                      // Display punch-in and punch-out times in a table
                      ...groupedRecords.entries.map((entry) {
                        String date = entry.key;
                        List<PunchInOutRecord> records = entry.value;

                        return pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(date,
                                style: pw.TextStyle(
                                    fontSize: 18,
                                    fontWeight: pw.FontWeight.bold)),
                            pw.Table.fromTextArray(
                              context: context,
                              columnWidths: {
                                0: const pw
                                    .FlexColumnWidth(), // Dynamic width for punch-in
                                1: const pw
                                    .FlexColumnWidth(), // Dynamic width for punch-out
                              },
                              data: <List<String>>[
                                <String>['Punch In', 'Punch Out'],
                                ...records.map((record) {
                                  String punchInTime =
                                      timeFormat.format(record.punchIn);
                                  String punchOutTime = record.punchOut != null
                                      ? timeFormat.format(record.punchOut!)
                                      : 'No Punch Out'; // Show 'No Punch Out' if null
                                  return [punchInTime, punchOutTime];
                                }),
                              ],
                            ),
                            pw.SizedBox(height: 20), // Space between dates
                          ],
                        );
                      }),
                      pw.SizedBox(height: 20), // Space between users
                    ],
                  );
                } else {
                  return pw
                      .SizedBox(); // Empty if no punch times exist for the user
                }
              }),
            ],
          );
        },
      ),
    );

    // Request storage permissions
    PermissionStatus status;
    if (Platform.isAndroid &&
        await DeviceInfoPlugin()
            .androidInfo
            .then((value) => value.version.sdkInt >= 30)) {
      status = await Permission.manageExternalStorage.request();
    } else {
      status = await Permission.storage.request();
    }

    // Save the PDF if permission is granted
    if (status.isGranted) {
      var path = await ExternalPath.getExternalStoragePublicDirectory(
          ExternalPath.DIRECTORY_DOWNLOADS);
      final sanitizedFileName = DateTime.now().toString().replaceAll(':', '-');
      final filePath = "$path/punch_in_out_report_$sanitizedFileName.pdf";
      final file = File(filePath);

      try {
        await file.writeAsBytes(await pdf.save());
        print("PDF saved to: $filePath");

        await context.router.push(PageRouteInfo(SuccessScreen.name,
            args: SuccessScreenArgs(message: 'Pdf downloaded successfully.')));
      } catch (e) {
        print("Error saving PDF: $e");
      }
    } else {
      print("Permission denied.");
    }
  }

  @override
  void dispose() {
    _camera?.dispose();
    super.dispose();
  }
}

enum Choice { view, delete }
