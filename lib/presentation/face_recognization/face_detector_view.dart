import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:attandence_system/domain/account/account.dart';
import 'package:attandence_system/domain/core/math_utils.dart';
import 'package:attandence_system/presentation/common/utils/flushbar_creator.dart';
import 'package:attandence_system/presentation/common/utils/get_current_user.dart';
import 'package:attandence_system/presentation/core/app_router.gr.dart';
import 'package:attandence_system/presentation/face_recognization/detector_painters.dart';
import 'package:attandence_system/presentation/face_recognization/utils.dart';
import 'package:attandence_system/presentation/face_recognization/widgets/generate_pdf_widget.dart';
import 'package:attandence_system/presentation/face_recognization/widgets/punch_in_out.dart';
import 'package:auto_route/auto_route.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:camera/camera.dart';

import 'package:flutter/material.dart';
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
  bool isFullEmployeeFaceDetected = false;
  // FaceDetector? faceDetector;
  CustomPainter? painter;
  final CameraLensDirection _direction = CameraLensDirection.front;
  dynamic data = {};
  double threshold = 1.0;
  Directory? tempDir;
  List<double>? e1; // Specify that this list will hold doubles
  var userId = '';
  bool isDownloadTapped = false;
  bool isYourFaceInCeter = false;
  bool canPunchIn = false;
  bool detectingCurrentLocation = false;

  @override
  void initState() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    if (widget.forDownloadData || widget.isUserRegistring) {
      _initializeCamera();
    } else {
      _startLocationMonitoring();
    }

    super.initState();
  }

  Future<void> _startLocationMonitoring() async {
    setState(() {
      detectingCurrentLocation = true;
    });
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    // Check and request location permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      openAppSettings();
      return Future.error(
          'Location permissions are permanently denied, please enable them in settings.');
    }

    // Monitor location updates
    final locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100, // Minimum distance to trigger updates
    );

    Geolocator.getCurrentPosition(locationSettings: locationSettings)
        .then((Position? position) {
      if (position != null) {
        _checkProximity(position);
      }
    });
  }

  void _checkProximity(Position position) {
    // Netsol IT Solutions Pvt. Ltd. coordinates
    const double targetLatitude = 21.160159491776806;
    const double targetLongitude = 72.8118574165545;
    const double radiusInMeters = 500;

    double distance = Geolocator.distanceBetween(
      targetLatitude,
      targetLongitude,
      position.latitude,
      position.longitude,
    );

    log('Distance: $distance meters');

    if (distance <= radiusInMeters) {
      log('User is within radius');
      setState(() {
        canPunchIn = true;
      });
    } else {
      log('User is outside the radius');
      setState(() {
        canPunchIn = false;
      });
    }

    setState(() {
      detectingCurrentLocation = false;
    });
    _initializeCamera();
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

  // Define a threshold for how far the face can be from the center (in pixels)
  final double centerThreshold = 50.0;

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
// Define a threshold for how far the face can be from the center (in pixels)
          const double centerThreshold = 50.0;
          _camera?.startImageStream((CameraImage image) {
            if (_isDetecting) return;
            _isDetecting = true;
            dynamic finalResult = Multimap<String, Face>();

            var isUserAdmin = false;
            var detectedUserId = '';

            var isUserFullCenterFaceDetected = false;
            var account = Account();
            detect(image, _getDetectionMethod(), rotation).then(
              (dynamic result) async {
                for (Face face in result) {
                  double x = (face.boundingBox.left);
                  double y = (face.boundingBox.top);
                  double width = face.boundingBox.width;
                  double height = face.boundingBox.height;

                  // Calculate the center of the bounding box
                  double faceCenterX = x + (width / 2);
                  double faceCenterY = y + (height / 2);

                  // Get the center of the camera preview
                  Size imageSize = Size(
                    _camera!.value.previewSize!.width,
                    _camera!.value.previewSize!.height,
                  );
                  double previewCenterX = imageSize.width / 2;
                  double previewCenterY = imageSize.height / 2;

                  // Check if the face is centered
                  if (faceCenterX < (previewCenterX - centerThreshold) ||
                      faceCenterX > (previewCenterX + centerThreshold) ||
                      faceCenterY < (previewCenterY - centerThreshold) ||
                      faceCenterY > (previewCenterY + centerThreshold)) {
                    isUserFullCenterFaceDetected = false;
                    finalResult.add('Please place your face in center.', face);
                  } else if (_isFaceFullyDetected(face) == null) {
                    double x, y, w, h;
                    x = (face.boundingBox.left - 10);
                    y = (face.boundingBox.top - 10);
                    w = (face.boundingBox.width + 10);
                    h = (face.boundingBox.height + 10);
                    imglib.Image convertedImage =
                        _convertCameraImage(image, _direction);
                    imglib.Image croppedImage = imglib.copyCrop(convertedImage,
                        x.round(), y.round(), w.round(), h.round());
                    croppedImage =
                        imglib.copyResizeCropSquare(croppedImage, 112);
                    var res = _recog(croppedImage);
                    isUserFullCenterFaceDetected = true;
                    finalResult.add('${res.firstName} ${res.lastName}', face);
                    // setState(() {
                    isUserAdmin = res.isAdmin ?? false;
                    detectedUserId = res.enrollmentID ?? "";
                    account = res;

                    // });
                  } else {
                    isUserFullCenterFaceDetected = false;
                    // setState(() {
                    //   isFullEmployeeFaceDetected = false;
                    finalResult.add(_isFaceFullyDetected(face), face);
                    // });
                  }
                }

                setState(() {
                  _scanResults = finalResult;
                  isDownloadTapped = isUserAdmin;
                  userId = detectedUserId;
                  isFullEmployeeFaceDetected = isUserFullCenterFaceDetected;
                  _isDetecting = false;
                  // canPunchIn = account.isPunchInFromEverywhere ?? false;
                });
                if (userId.isNotEmpty &&
                    _scanResults != null &&
                    (!widget.isUserRegistring) &&
                    (!widget.forDownloadData)) {
                  setState(() {
                    _camera?.stopImageStream();
                  });
                  _handlePunchInOut(account, userId);
                } else if (widget.isUserRegistring) {
                  setState(() {
                    _camera?.stopImageStream();
                  });
                  _addLabel();
                }
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

  HandleDetection _getDetectionMethod() {
    var faceDetector = FaceDetector(
      options: FaceDetectorOptions(
        enableLandmarks: true,
        enableContours: true,
        enableClassification: true,
        performanceMode: FaceDetectorMode.accurate,
      ),
    );

    return faceDetector.processImage;
  }

  Future<void> _handlePunchInOut(Account detectedAccount, String userId) async {
    if (canPunchIn || detectedAccount.isPunchInFromEverywhere == true) {
      // Cancel any existing timer before starting a new one
      // _debounceTimer?.cancel();

      // Start a new timer for debouncing

      // Check if the user is already punched in or not, and update accordingly
      if (detectedAccount.isPunchIn == true) {
        await PunchINOutWidget().updatePunchInOutTime(
          userId,
          context,
          isPunchIn: false, // Punching out
        );
      } else {
        await PunchINOutWidget().updatePunchInOutTime(
          userId,
          context,
          isPunchIn: true, // Punching in
        );
      }
    } else {
      showError(
              message:
                  'You are not allowed to punch in from this location.You can only punch in from Netsol IT Solutions Pvt. Ltd. office.')
          .show(context)
          .then(
            (value) => context.router.popUntil(
              (route) => route.isFirst,
            ),
          );
      // setState(() {
      //   _camera = null;
      //   faceDetector.close();
      //   _camera?.dispose();
      // });
    }
  }

  String? _isFaceFullyDetected(Face face) {
    if (face.landmarks[FaceLandmarkType.leftEye] == null ||
        face.leftEyeOpenProbability == null ||
        face.leftEyeOpenProbability! < 0.5) {
      return 'Your right eye is not detected properly.';
    } else if (face.landmarks[FaceLandmarkType.rightEye] == null ||
        face.rightEyeOpenProbability == null ||
        face.rightEyeOpenProbability! < 0.5) {
      return 'Your left eye is not detected properly.';
    } else if (face.contours[FaceContourType.face] == null) {
      return 'Your face contours is not detected properly.';
    }
    return null;
    // Check for eyes, smile, and face contours
    // return face.landmarks[FaceLandmarkType.leftEye] != null &&
    //     face.landmarks[FaceLandmarkType.rightEye] != null &&
    //     face.leftEyeOpenProbability != null &&
    //     face.leftEyeOpenProbability! > 0.5 && // Check if the left eye is open
    //     face.rightEyeOpenProbability != null &&
    //     face.rightEyeOpenProbability! > 0.5 && // Check if the right eye is open
    //     face.contours[FaceContourType.face] != null;
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
    if (detectingCurrentLocation) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
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
          ],
        ),
      );
    }
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
                if (_scanResults == null) {
                  showError(message: 'Face is not recognized properly')
                      .show(context);
                  return;
                } else if (isDownloadTapped) {
                  PdfGenerateView().generateUserPunchInOutReport(context);
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
                        (value) => context.router.popUntil(
                          (route) => route.isFirst,
                        ),
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
          // Visibility(
          //   visible: widget.isUserRegistring,
          //   child: FloatingActionButton(
          //     backgroundColor: (_faceFound) ? null : Colors.grey,
          //     onPressed: () {
          //       if (!isFullEmployeeFaceDetected) {
          //         showError(
          //                 message:
          //                     'Please place your face properly and it should be in center of screen')
          //             .show(context);
          //         return;
          //       } else {
          //         _addLabel();
          //       }
          //     },
          //     heroTag: null,
          //     child: Icon(Icons.add),
          //   ),
          // ),
          SizedBox(
            height: getSize(10),
          ),
          // FloatingActionButton(
          //   onPressed: _toggleCameraDirection,
          //   heroTag: null,
          //   child: _direction == CameraLensDirection.back
          //       ? const Icon(Icons.camera_front)
          //       : const Icon(Icons.camera_rear),
          // ),
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
    Account label = Account(
        firstName: widget.isUserRegistring ? "Click on + to add " : 'Not',
        lastName: widget.isUserRegistring ? "your face" : ' Recognized');
    for (var key in getCurrentUser()) {
      List<double>? e2 = key.predictedData;
      double d = euclideanDistance(e1!, e2 ?? []);
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
        // var res = await context.router.push(
        //   PageRouteInfo(
        //     FaceVerificationTaskScreen.name,
        //     // args: SuccessScreenArgs(
        //     //     message:
        //     //         'Only admin can download report. Please contact your admin',
        //     //     showWarning: true),
        //   ),
        // );
        // if (res != null && res == true) {
        await context.router.maybePop(e1);
        // }
      }
    }
  }

  @override
  void dispose() {
    _camera?.dispose();
    //faceDetector?.close();
    super.dispose();
  }
}

enum Choice { view, delete }
