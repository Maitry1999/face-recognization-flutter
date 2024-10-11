import 'package:flutter/services.dart';
import 'package:image/image.dart' as imglib;
import 'package:camera/camera.dart';

imglib.Image convertToImage(CameraImage image) {
  try {
    print('image.format.group=>${image.format.group}');
    if (image.format.group == ImageFormatGroup.nv21) {
      return _convertNV21(image);
    } else if (image.format.group == ImageFormatGroup.bgra8888) {
      return _convertBGRA8888(image);
    }
    throw Exception('Image format not supported');
  } catch (e) {
    print("ERROR:$e");
  }
  throw Exception('Image format not supported');
}

imglib.Image _convertBGRA8888(CameraImage image) {
  return imglib.Image.fromBytes(
    image.width,
    image.height,
    image.planes[0].bytes,
    format: imglib.Format.bgra,
  );
}

imglib.Image _convertNV21(CameraImage image) {
  final width = image.width.toInt();
  final height = image.height.toInt();
  Uint8List yuv420sp = image.planes[0].bytes;

  // Initial conversion from NV21 to RGB
  final outImg = imglib.Image(height, width); // Note the swapped dimensions
  final int frameSize = width * height;

  for (int j = 0, yp = 0; j < height; j++) {
    int uvp = frameSize + (j >> 1) * width, u = 0, v = 0;
    for (int i = 0; i < width; i++, yp++) {
      int y = (0xff & yuv420sp[yp]) - 16;
      if (y < 0) y = 0;
      if ((i & 1) == 0) {
        v = (0xff & yuv420sp[uvp++]) - 128;
        u = (0xff & yuv420sp[uvp++]) - 128;
      }
      int y1192 = 1192 * y;
      int r = (y1192 + 1634 * v);
      int g = (y1192 - 833 * v - 400 * u);
      int b = (y1192 + 2066 * u);

      if (r < 0) {
        r = 0;
      } else if (r > 262143) r = 262143;
      if (g < 0) {
        g = 0;
      } else if (g > 262143) g = 262143;
      if (b < 0) {
        b = 0;
      } else if (b > 262143) b = 262143;

      outImg.setPixelRgba(j, width - i - 1, ((r << 6) & 0xff0000) >> 16,
          ((g >> 2) & 0xff00) >> 8, (b >> 10) & 0xff);
    }
  }
  return outImg;
  // Rotate the image by 90 degrees (or 270 degrees if needed)
  // return imglib.copyRotate(outImg, -90); // Use -90 for a 270 degrees rotation
}
