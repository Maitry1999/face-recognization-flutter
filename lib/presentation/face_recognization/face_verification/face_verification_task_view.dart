import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:attandence_system/presentation/common/utils/flushbar_creator.dart';
import 'package:attandence_system/presentation/face_recognization/utils.dart';
import 'package:auto_route/auto_route.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart'; // For face detection

@RoutePage(name: 'FaceVerificationTaskScreen')
class FaceVerificationTaskScreen extends StatefulWidget {
  const FaceVerificationTaskScreen({
    super.key,
  });

  @override
  _FaceVerificationTaskScreenState createState() =>
      _FaceVerificationTaskScreenState();
}

class _FaceVerificationTaskScreenState
    extends State<FaceVerificationTaskScreen> {
  bool isTaskCompleted = false;
  bool isDetectionInProgress = false;
  CameraController? controller;
  late FaceDetector faceDetector;
  String randomTask = '';
  final Random _random = Random();
  Timer? _timer; // Timer to control the 5-second window
  int taskTimeLimit = 12; // Task should complete in 5 seconds
  int remainingTime = 12; // Remaining time for the task

  @override
  void initState() {
    super.initState();
    initializeCamera();
    initializeFaceDetector();
    randomTask =
        generateRandomTask(); // Generate a random task for spoof detection
  }

  Future<void> initializeCamera() async {
    CameraDescription description = await getCamera(CameraLensDirection.front);

    controller = CameraController(
      description,
      ResolutionPreset.low,
      enableAudio: false,
      imageFormatGroup: Platform.isAndroid
          ? ImageFormatGroup.nv21
          : ImageFormatGroup.bgra8888,
    );

    if (controller != null) {
      controller?.initialize().then((_) {
        setState(() {});
        if (!mounted) return;
        startFaceDetection(); // Start detecting faces for the task
        startTaskTimer(); // Start the 5-second timer
      }).catchError((e) {
        print(e);
      });
    }
  }

  initializeFaceDetector() {
    faceDetector = FaceDetector(
      options: FaceDetectorOptions(
        enableContours: true,
        enableClassification: true, // To detect mouth opening, eyebrows, etc.
      ),
    );
  }

  // Generate a random task (e.g., open your mouth, raise eyebrows, etc.)
  String generateRandomTask() {
    List<String> tasks = [
      'look up and down',
      'turn your head left',
      'turn your head right',
      'blink rapidly'
    ];
    return tasks[_random.nextInt(tasks.length)];
  }

  startFaceDetection() async {
    if (controller == null || !controller!.value.isInitialized) return;

    controller?.startImageStream((CameraImage image) async {
      if (isTaskCompleted || isDetectionInProgress) {
        return; // Skip detection if task is completed or in progress
      }

      isDetectionInProgress = true; // Mark detection as in progress

      final WriteBuffer allBytes = WriteBuffer();
      for (var plane in image.planes) {
        allBytes.putUint8List(plane.bytes);
      }
      final bytes = allBytes.done().buffer.asUint8List();

      final Size imageSize =
          Size(image.width.toDouble(), image.height.toDouble());
      final camera = await getCamera(CameraLensDirection.front);
      final imageRotation =
          InputImageRotationValue.fromRawValue(camera.sensorOrientation) ??
              InputImageRotation.rotation0deg;

      final inputImage = InputImage.fromBytes(
        bytes: bytes,
        metadata: InputImageMetadata(
          size: imageSize,
          rotation: imageRotation,
          format: InputImageFormatValue.fromRawValue(image.format.raw) ??
              InputImageFormat.nv21,
          bytesPerRow: image.planes.first.bytesPerRow,
        ),
      );

      // Detect faces
      final List<Face> faces = await faceDetector.processImage(inputImage);

      if (faces.isNotEmpty) {
        final face = faces.first;
        // Check if face meets the random task conditions
        if (performTaskBasedOnFace(face)) {
          completeTask();
        }
      }

      isDetectionInProgress = false; // Reset detection progress flag
    });
  }

  // Check if the face performs the random task correctly
  bool performTaskBasedOnFace(Face face) {
    switch (randomTask) {
      case 'look up and down':
        return face.headEulerAngleX != null &&
            (face.headEulerAngleX! < -18 || face.headEulerAngleX! > 18);
      case 'turn your head left':
        return face.headEulerAngleY != null &&
            face.headEulerAngleY! < 18; // Check head turning left
      case 'turn your head right':
        return face.headEulerAngleY != null &&
            face.headEulerAngleY! > -18; // Check head turning right
      case 'blink rapidly':
        return face.leftEyeOpenProbability != null &&
            face.rightEyeOpenProbability != null &&
            face.leftEyeOpenProbability! < 0.5 &&
            face.rightEyeOpenProbability! < 0.5; // Rapid blink detection

      default:
        return false;
    }
  }

  // Start a 5-second timer
  void startTaskTimer() {
    remainingTime = taskTimeLimit; // Reset remaining time
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (remainingTime > 0) {
          remainingTime--;
        } else {
          timer.cancel(); // Stop the timer when it reaches zero
          if (!isTaskCompleted) {
            print("Time is up. Task failed.");

            showError(message: 'Task failed, try again!').show(context).then(
                  (value) => context.router.popUntil(
                    (route) => route.isFirst,
                  ),
                );

            return;
            //context.router.maybePop(false); // Go back with failure
          }
        }
      });
    });
  }

  // Mark task as complete and move to next steps
  void completeTask() {
    if (_timer != null) {
      _timer?.cancel(); // Cancel the timer if task is completed within time
    }

    setState(() {
      isTaskCompleted = true;
    });

    print('Task Completed');
    showSuccess(message: 'Task Completed').show(context).then(
          (value) => context.router.maybePop(true),
        );

    return;
  }

  @override
  void dispose() {
    controller?.dispose();
    faceDetector.close();
    _timer?.cancel(); // Cancel the timer on dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Complete the Task'),
        centerTitle: true,
      ),
      body: Center(
        child: controller == null || !(controller!.value.isInitialized)
            ? CircularProgressIndicator()
            : Column(
                children: [
                  SizedBox(height: 20),
                  // Stylized task instruction
                  Column(
                    children: [
                      Text(
                        'Please $randomTask', // Display the random task
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      // Countdown timer
                      Text(
                        '$remainingTime seconds left',
                        style: TextStyle(fontSize: 20, color: Colors.red),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  isTaskCompleted
                      ? Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            'Task Completed!',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        )
                      : CircularProgressIndicator(), // Show progress until task is done
                  SizedBox(height: 20),
                  Expanded(
                    child: CameraPreview(controller!),
                  ),
                  SizedBox(height: 20),
                ],
              ),
      ),
    );
  }
}
