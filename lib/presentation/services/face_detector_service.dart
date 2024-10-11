// import 'dart:developer';
// import 'dart:io';

// import 'package:attandence_system/injection.dart';
// import 'package:attandence_system/presentation/services/camera.service.dart';
// import 'package:camera/camera.dart';
// import 'package:flutter/services.dart';
// import 'package:google_ml_kit/google_ml_kit.dart';
// import 'package:flutter/material.dart';

// class FaceDetectorService {
//   late FaceDetector _faceDetector;
//   FaceDetector get faceDetector => _faceDetector;
//   final _orientations = {
//     DeviceOrientation.portraitUp: 0,
//     DeviceOrientation.landscapeLeft: 90,
//     DeviceOrientation.portraitDown: 180,
//     DeviceOrientation.landscapeRight: 270,
//   };

//   List<Face> _faces = [];
//   List<Face> get faces => _faces;
//   bool get faceDetected => _faces.isNotEmpty;

//   void initialize() {
//     _faceDetector = GoogleMlKit.vision.faceDetector(
//       FaceDetectorOptions(
//         performanceMode: FaceDetectorMode.accurate,
//       ),
//     );

//     // _faceDetector = FaceDetector(
//     //     options: FaceDetectorOptions(
//     //         performanceMode: FaceDetectorMode.fast,
//     //         enableContours: true,
//     //         enableClassification: true));
//   }

//   Future<void> detectFacesFromImage(
//     CameraImage image,
//     CameraController? cameraController,
//   ) async {
//     if (cameraController == null) return;

//     // get image rotation
//     // it is used in android to convert the InputImage from Dart to Java: https://github.com/flutter-ml/google_ml_kit_flutter/blob/master/packages/google_mlkit_commons/android/src/main/java/com/google_mlkit_commons/InputImageConverter.java
//     // `rotation` is not used in iOS to convert the InputImage from Dart to Obj-C: https://github.com/flutter-ml/google_ml_kit_flutter/blob/master/packages/google_mlkit_commons/ios/Classes/MLKVisionImage%2BFlutterPlugin.m
//     // in both platforms `rotation` and `camera.lensDirection` can be used to compensate `x` and `y` coordinates on a canvas: https://github.com/flutter-ml/google_ml_kit_flutter/blob/master/packages/example/lib/vision_detector_views/painters/coordinates_translator.dart
//     final camera = getIt<CameraService>().cameraDescription;
//     final sensorOrientation = camera!.sensorOrientation;
//     // print(
//     //     'lensDirection: ${camera.lensDirection}, sensorOrientation: $sensorOrientation, ${_controller?.value.deviceOrientation} ${_controller?.value.lockedCaptureOrientation} ${_controller?.value.isCaptureOrientationLocked}');
//     InputImageRotation? rotation;
//     if (Platform.isIOS) {
//       rotation = InputImageRotationValue.fromRawValue(sensorOrientation);
//     } else if (Platform.isAndroid) {
//       var rotationCompensation =
//           _orientations[cameraController.value.deviceOrientation];
//       if (rotationCompensation == null) return;
//       if (camera.lensDirection == CameraLensDirection.front) {
//         // front-facing
//         rotationCompensation = (sensorOrientation + rotationCompensation) % 360;
//       } else {
//         // back-facing
//         rotationCompensation =
//             (sensorOrientation - rotationCompensation + 360) % 360;
//       }
//       rotation = InputImageRotationValue.fromRawValue(rotationCompensation);
//       // print('rotationCompensation: $rotationCompensation');
//     }
//     if (rotation == null) return;
//     // print('final rotation: $rotation');
//     //log('image.format.raw : ${image.format.group}');
//     // get image format
//     final format = InputImageFormatValue.fromRawValue(image.format.raw);
//     // validate format depending on platform
//     // only supported formats:
//     // * nv21 for Android
//     // * bgra8888 for iOS
//     log('format : $format');
//     if (format == null ||
//         (Platform.isAndroid && format != InputImageFormat.nv21) ||
//         (Platform.isIOS && format != InputImageFormat.bgra8888)) {
//       return;
//     }

//     // since format is constraint to nv21 or bgra8888, both only have one plane
//     if (image.planes.length != 1) return;
//     final plane = image.planes.first;

//     // compose InputImage using bytes
//     InputImage firebaseVisionImage = InputImage.fromBytes(
//       bytes: plane.bytes,
//       metadata: InputImageMetadata(
//         size: Size(image.width.toDouble(), image.height.toDouble()),
//         rotation: rotation, // used only in Android
//         format: format, // used only in iOS
//         bytesPerRow: plane.bytesPerRow, // used only in iOS
//       ),
//     );

//     _faces = await _faceDetector.processImage(firebaseVisionImage);
//   }

//   dispose() {
//     _faceDetector.close();
//   }
// }

// //Future<List<Face>> detect(CameraImage image, InputImageRotation rotation) {
// //   final faceDetector = GoogleMlKit.vision.faceDetector(
// //     FaceDetectorOptions(
// //       performanceMode: FaceDetectorMode.accurate,
// //       enableLandmarks: true,
// //     ),
// //   );
// //   final WriteBuffer allBytes = WriteBuffer();
// //   for (final Plane plane in image.planes) {
// //     allBytes.putUint8List(plane.bytes);
// //   }
// //   final bytes = allBytes.done().buffer.asUint8List();

// //   final Size imageSize = Size(image.width.toDouble(), image.height.toDouble());
// //   final inputImageFormat =
// //       InputImageFormatValue.fromRawValue(image.format.raw) ??
// //           InputImageFormat.yuv_420_888;

// //   final planeData = image.planes.map(
// //     (Plane plane) {
// //       return InputImagePlaneMetadata(
// //         bytesPerRow: plane.bytesPerRow,
// //         height: plane.height,
// //         width: plane.width,
// //       );
// //     },
// //   ).toList();

// //   final inputImageData = InputImageData(
// //     size: imageSize,
// //     imageRotation: rotation,
// //     inputImageFormat: inputImageFormat,
// //     planeData: planeData,
// //   );

// //   return faceDetector.processImage(
// //     InputImage.fromBytes(bytes: bytes, inputImageData: inputImageData),
// //   );
// // }

// ///for new version
// // Future<void> detectFacesFromImage(CameraImage image) async {
// //   // InputImageData _firebaseImageMetadata = InputImageData(
// //   //   imageRotation: _cameraService.cameraRotation ?? InputImageRotation.rotation0deg,
// //   //   inputImageFormat: InputImageFormatMethods ?? InputImageFormat.nv21,
// //   //   size: Size(image.width.toDouble(), image.height.toDouble()),
// //   //   planeData: image.planes.map(
// //   //     (Plane plane) {
// //   //       return InputImagePlaneMetadata(
// //   //         bytesPerRow: plane.bytesPerRow,
// //   //         height: plane.height,
// //   //         width: plane.width,
// //   //       );
// //   //     },
// //   //   ).toList(),
// //   // );
// //
// //   final WriteBuffer allBytes = WriteBuffer();
// //   for (Plane plane in image.planes) {
// //     allBytes.putUint8List(plane.bytes);
// //   }
// //   final bytes = allBytes.done().buffer.asUint8List();
// //
// //   final Size imageSize = Size(image.width.toDouble(), image.height.toDouble());
// //
// //   InputImageRotation imageRotation = _cameraService.cameraRotation ?? InputImageRotation.rotation0deg;
// //
// //   final inputImageData = InputImageData(
// //     size: imageSize,
// //     imageRotation: imageRotation,
// //     inputImageFormat: InputImageFormat.yuv420,
// //     planeData: image.planes.map(
// //           (Plane plane) {
// //         return InputImagePlaneMetadata(
// //           bytesPerRow: plane.bytesPerRow,
// //           height: plane.height,
// //           width: plane.width,
// //         );
// //       },
// //     ).toList(),
// //   );
// //
// //   InputImage _firebaseVisionImage = InputImage.fromBytes(
// //     bytes: bytes,
// //     inputImageData: inputImageData,
// //   );
// //
// //   _faces = await _faceDetector.processImage(_firebaseVisionImage);
// // }

