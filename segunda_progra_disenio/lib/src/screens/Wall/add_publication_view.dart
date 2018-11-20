import 'package:flutter/material.dart';
import 'package:segunda_progra_disenio/shared/NavigateToScreen.dart';
import '../../models/profile_model.dart';
import 'dart:io';
import '../../models/publication_model.dart';
import 'package:camera/camera.dart';
import '../../../shared/CameraScreen.dart';
import './publication_form.dart';

class AddPublication extends StatefulWidget{
  List<CameraDescription> cameras;
  ProfileModel currentUser;

  AddPublication(this.publication,this.currentUser,this.cameras);
  PublicationModel publication;

  @override
    State<StatefulWidget> createState() {
      // TODO: implement createState
      return AddPublicationState();
    }
}

class AddPublicationState extends State<AddPublication>{

  Widget hasPicture(){
    return widget.publication.mediaLink == '' ? 
    IconButton(
      icon: Icon(Icons.photo_camera),
      onPressed: (){
        Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => navigateToScreen(context: context,
                                body: CameraScreen(widget.cameras,widget.publication,widget.currentUser)),
                                ),
                              );
      },
    )
    : Image.file(File(widget.publication.mediaLink));
  }



  @override
    Widget build(BuildContext context) {
      print(widget.publication.mediaLink);
      return ListView(
        children: <Widget>[
          hasPicture(),
          PublicationForm(widget.publication,widget.currentUser,widget.cameras)
        ],
      );

    }
}

//arturo.pol@gmail.com

//Margarita15