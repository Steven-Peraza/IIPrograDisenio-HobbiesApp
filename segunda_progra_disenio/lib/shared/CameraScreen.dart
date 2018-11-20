import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'package:segunda_progra_disenio/shared/NavigateToScreen.dart';
import 'package:segunda_progra_disenio/src/models/profile_model.dart';
import 'package:segunda_progra_disenio/src/models/publication_model.dart';
import 'package:segunda_progra_disenio/src/screens/Wall/add_publication_view.dart';

class CameraScreen extends StatefulWidget {
  List<CameraDescription> cameras;
  PublicationModel publication;
  ProfileModel currentUser;

  CameraScreen(this.cameras,this.publication,this.currentUser);

  @override
  CameraScreenState createState() {
    return new CameraScreenState();
  }
}

class CameraScreenState extends State<CameraScreen> {
  CameraController controller;

  @override
  void initState() {
    super.initState();
    controller =
        new CameraController(widget.cameras[0], ResolutionPreset.medium);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void showInSnackBar(String message) {
    print(message);
  }

  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  void _showCameraException(CameraException e) {
    showInSnackBar('Error: ${e.code}\n${e.description}');
  }
  

  Future<String> takePicture() async {
    if (!controller.value.isInitialized) {
      showInSnackBar('Error: select a camera first.');
      return null;
    }
    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/Pictures/flutter_test';
    await Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/${timestamp()}.jpg';

    if (controller.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      await controller.takePicture(filePath);
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }
    return filePath;
  }


  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return new Container();
    }
    return new Column(children: <Widget>[
      Center(child: IconButton(
      icon: Icon(Icons.photo_camera),
      onPressed: (){takePicture().then((value){
        setState(() {
              widget.publication.mediaLink = value;
                });
        Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => navigateToScreen(context: context,
                                body: AddPublication(widget.publication,widget.currentUser,widget.cameras)),
                                ),
                              );
        });},),
      ),
      SingleChildScrollView(
        child: AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: new CameraPreview(controller),
    ),)
      
    ],);
  }
}

//arturo.pol@gmail.com  
