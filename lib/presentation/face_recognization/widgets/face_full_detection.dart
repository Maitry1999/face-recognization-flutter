import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

class FaceFullDetection extends StatelessWidget {
  const FaceFullDetection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
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
    bool isPositionedWell = ((angleX?.abs() ?? 0) < 15) &&
        ((angleY?.abs() ?? 0) < 15) &&
        ((angleZ?.abs() ?? 0) < 15);

    return isPositionedWell;
  }
}
