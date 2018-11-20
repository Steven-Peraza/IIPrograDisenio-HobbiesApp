import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'src/app.dart';

Future<Null> main() async {
  List<CameraDescription> cameras = await availableCameras();
  runApp(App(cameras));
}