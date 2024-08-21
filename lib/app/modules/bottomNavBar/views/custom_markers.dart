import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;

Future<BitmapDescriptor> customMarker(BuildContext context) async {
  final ByteData data = await rootBundle.load('assets/images/makercoin.png');
  final Uint8List markerImageBytes = data.buffer.asUint8List();

  final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
  final Canvas canvas = Canvas(pictureRecorder);
  final Paint paint = Paint();
  final double radius = 50.0;

  final ui.Image image = await decodeImageFromList(markerImageBytes);
  canvas.drawCircle(Offset(radius, radius), radius, paint);
  canvas.clipPath(Path()..addOval(Rect.fromCircle(center: Offset(radius, radius), radius: radius)));
  canvas.drawImage(image, Offset.zero, paint);

  final ui.Image markerImage = await pictureRecorder.endRecording().toImage((radius * 2).toInt(), (radius * 2).toInt());
  final ByteData? byteData = await markerImage.toByteData(format: ui.ImageByteFormat.png);

  return BitmapDescriptor.fromBytes(byteData!.buffer.asUint8List());
}