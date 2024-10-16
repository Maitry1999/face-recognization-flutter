import 'dart:io';
import 'dart:math';
import 'dart:developer' as dev;
import 'dart:typed_data';
import 'package:attandence_system/domain/account/account.dart';
import 'package:attandence_system/presentation/common/utils/get_current_user.dart';
import 'package:attandence_system/presentation/services/image_converter.dart';
import 'package:camera/camera.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as imglib;

class MLService {
  Interpreter? _interpreter;
  double threshold = 1; // Adjusted threshold for better matching

  List<double> _predictedData = [];
  List<double> get predictedData => _predictedData;

  Future initialize() async {
    late Delegate delegate;
    try {
      if (Platform.isAndroid) {
        delegate = GpuDelegateV2(
          options: GpuDelegateOptionsV2(
            isPrecisionLossAllowed: false,
          ),
        );
      } else if (Platform.isIOS) {
        delegate = GpuDelegate(
          options: GpuDelegateOptions(
            allowPrecisionLoss: true,
          ),
        );
      }
      var interpreterOptions = InterpreterOptions()..addDelegate(delegate);
      _interpreter = await Interpreter.fromAsset(
          'assets/mobile_face_net.tflite',
          options: interpreterOptions);
    } catch (e) {
      print('Failed to load model: $e');
    }
  }

  void setCurrentPrediction(CameraImage cameraImage, Face? face) {
    if (_interpreter == null) throw Exception('Interpreter is null');
    if (face == null) throw Exception('Face is null');
    List input = _preProcess(cameraImage, face);

    input = input.reshape([1, 112, 112, 3]);
    List output = List.generate(1, (index) => List.filled(192, 0));

    _interpreter?.run(input, output);
    output = output.reshape([192]);

    _predictedData = List<double>.from(output);
  }

  Future<Account?> predict() async {
    return _searchResult(_predictedData);
  }

  List _preProcess(CameraImage image, Face faceDetected) {
    imglib.Image croppedImage = _cropFace(image, faceDetected);
    imglib.Image img = imglib.copyResizeCropSquare(croppedImage, 112);

    Float32List imageAsList = imageToByteListFloat32(img);
    return imageAsList;
  }

  imglib.Image _cropFace(CameraImage image, Face faceDetected) {
    imglib.Image convertedImage = _convertCameraImage(image);
    double x = faceDetected.boundingBox.left - 10.0;
    double y = faceDetected.boundingBox.top - 10.0;
    double w = faceDetected.boundingBox.width + 10.0;
    double h = faceDetected.boundingBox.height + 10.0;
    return imglib.copyCrop(
        convertedImage, x.round(), y.round(), w.round(), h.round());
  }

  imglib.Image _convertCameraImage(CameraImage image) {
    var img = convertToImage(image);
    var img1 = imglib.copyRotate(img, -90);
    return img1;
  }

  Float32List imageToByteListFloat32(imglib.Image image) {
    var convertedBytes = Float32List(1 * 112 * 112 * 3);
    var buffer = Float32List.view(convertedBytes.buffer);
    int pixelIndex = 0;

    for (var i = 0; i < 112; i++) {
      for (var j = 0; j < 112; j++) {
        var pixel = image.getPixel(j, i);
        buffer[pixelIndex++] = (imglib.getRed(pixel) - 128) / 128;
        buffer[pixelIndex++] = (imglib.getGreen(pixel) - 128) / 128;
        buffer[pixelIndex++] = (imglib.getBlue(pixel) - 128) / 128;
      }
    }
    return convertedBytes.buffer.asFloat32List();
  }

  Future<Account?> _searchResult(List<double> predictedData) async {
    double minDist = double.maxFinite; // Initialize to max value
    double currDist = 0.0;
    Account? predictedResult;

    // Get all users from Hive box
    List<Account> users = getCurrentUser();

    for (Account u in users) {
      currDist =
          _euclideanDistance(u.predictedData as List<double>, predictedData);
      dev.log('currDist : $currDist');
      dev.log('threshold : $threshold');
      dev.log('minDist : $minDist');

      if (currDist <= threshold && currDist < minDist) {
        minDist = currDist;
        predictedResult = u; // Store the best matching user
      }
    }

    return predictedResult; // Return the predicted user or null
  }

  double _euclideanDistance(List<double> e1, List<double> e2) {
    if (e1.length != e2.length) throw Exception("Mismatched dimensions");
    double sum = 0.0;
    for (int i = 0; i < e1.length; i++) {
      sum += pow((e1[i] - e2[i]), 2);
    }
    return sqrt(sum);
  }

  void setPredictedData(value) {
    _predictedData = value;
  }

  void dispose() {
    _interpreter?.close();
  }
}
