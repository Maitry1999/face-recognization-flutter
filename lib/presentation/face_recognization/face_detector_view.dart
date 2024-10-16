import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:io';
import 'package:attandence_system/domain/account/account.dart';
import 'package:attandence_system/domain/core/math_utils.dart';
import 'package:attandence_system/infrastructure/account/account_entity.dart';
import 'package:attandence_system/infrastructure/core/network/hive_box_names.dart';
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
import 'package:path_provider/path_provider.dart';
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
  double threshold = 0.8;
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
          options: tfl.GpuDelegateOptionsV2(
              // false,
              // tfl.TfLiteGpuInferenceUsage.fastSingleAnswer,
              // tfl.TfLiteGpuInferencePriority.minLatency,
              // tfl.TfLiteGpuInferencePriority.auto,
              // tfl.TfLiteGpuInferencePriority.auto,
              ));

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
          await Future.delayed(Duration(milliseconds: 500));
          tempDir = await getApplicationDocumentsDirectory();
          String embPath = '${tempDir!.path}/emb.json';
          jsonFile = File(embPath);
          if (jsonFile.existsSync()) {
            data = json.decode(jsonFile.readAsStringSync());
          }

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
                  finalResult.add(res.firstName, face);

                  userId = res.userId ?? "";
                  setState(() {});
                  isUserAdmin = res.isAdmin ?? false;
                }

                setState(() {
                  _scanResults = finalResult;
                  isDownloadTapped = isUserAdmin;
                });

                // if (userId.isNotEmpty && !widget.forDownloadData) {
                //   // await Future.delayed(
                //   //   Duration(seconds: 4),
                //   //   () async {
                //   //     await updatePunchInOutTime(
                //   //       userId,
                //   //     );
                //   //   },
                //   // );
                // }
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

      context.router
          .push(PageRouteInfo(SuccessScreen.name,
              args: SuccessScreenArgs(
                  message:
                      'Updated Punch In/Out Time for Employee ${existingUser.firstName} ${existingUser.lastName}')))
          .then(
        (value) async {
          context.router.popUntil(
            (route) => route.isFirst,
          );
        },
      );
    } else {
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
                visible: userId.isNotEmpty && !widget.forDownloadData,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: CommonButton(
                    backgroundColor:
                        (userId.isNotEmpty && !widget.forDownloadData)
                            ? null
                            : Colors.grey,
                    onPressed: userId.isNotEmpty && !widget.forDownloadData
                        ? () {
                            updatePunchInOutTime(userId);
                          }
                        : () {},
                    //heroTag: null,
                    buttonText: 'In/Out',
                    // child: BaseText(text: 'In/Out'),
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
    Account label = Account(firstName: 'Not Recognized');
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
      await context.router.maybePop(e1);
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

    PermissionStatus status;
    if (Platform.isAndroid &&
        await DeviceInfoPlugin()
            .androidInfo
            .then((value) => value.version.sdkInt >= 30)) {
      status = await Permission.manageExternalStorage.request();
      setState(() {});
    } else {
      status = await Permission.storage.request();
      setState(() {});
    }

    if (status.isGranted) {
      var path = await ExternalPath.getExternalStoragePublicDirectory(
          ExternalPath.DIRECTORY_DOWNLOADS);

      final sanitizedFileName = DateTime.now().toString().replaceAll(':', '-');
      final filePath = "$path/punch_in_out_report_$sanitizedFileName.pdf";
      final file = File(filePath);

      try {
        await file.writeAsBytes(await pdf.save());
        print("PDF saved to: $filePath");

        await context.router
            .push(PageRouteInfo(SuccessScreen.name,
                args:
                    SuccessScreenArgs(message: 'Pdf downloaded successfully.')))
            .then(
          (value) {
            context.router.popUntil((route) => route.isFirst);
          },
        );
      } catch (e) {
        print("Error saving PDF: $e");
        // setState(() {
        //   isDownloadTapped = false;
        // });
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
