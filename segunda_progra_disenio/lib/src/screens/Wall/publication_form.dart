import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:segunda_progra_disenio/shared/NavigateToScreen.dart';
import 'package:segunda_progra_disenio/src/CONSTANTS.dart';
import 'package:segunda_progra_disenio/src/models/profile_model.dart';
import 'package:segunda_progra_disenio/src/models/publication_model.dart';
import 'package:segunda_progra_disenio/src/screens/Wall/add_publication_view.dart';
import 'package:segunda_progra_disenio/src/screens/Wall/publication_service.dart';
import 'package:segunda_progra_disenio/src/screens/Wall/wall.dart';
import '../../mixins/validation_mixin.dart';
import 'package:dio/dio.dart';

class PublicationForm extends StatefulWidget{

  PublicationModel publication;
  ProfileModel currentUser;
  List<CameraDescription> cameras;
  PublicationForm(this.publication,this.currentUser,this.cameras);
  @override
  PublicationFormState createState() {
    return PublicationFormState();
  }
}

class PublicationFormState extends State<PublicationForm> with ValidationMixin, PublicationService{
  final _formKey = GlobalKey<FormState>();


  Widget createField({String labelText, String hintText, Function onSaved}) {
    return TextFormField(
      style: TextStyle(
                    fontFamily: 'Morris',
                    color: Colors.black,
                    fontSize: 20.0,
                  ),
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
      ),
      validator: validateNull,
      onSaved: onSaved,
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          createField(hintText: "experimento",
          labelText: "Texto",
          onSaved: (value){setState(() {
                      widget.publication.text = value;
                    });}),
          ListView(
                shrinkWrap: true,
                  children: widget.currentUser.hobbies.map((dynamic key) {
                    return new CheckboxListTile(
                      title: new Text(key,style: TextStyle(fontFamily:'Morris',fontSize: 20.0),),
                      value: widget.publication.hobby == key,
                      onChanged: (bool value) {
                        setState(() {
                          widget.publication.hobby = key;
                        });
                      },
                    );
                  }).toList()),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
                onPressed: () async{
                  // Validate will return true if the form is valid, or false if
                  // the form is invalid.
                  if (_formKey.currentState.validate()) {
                    Dio dio = new Dio();
                    dio.options.baseUrl = 'https://'+CONSTANTS.BASE_URL;
                    // If the form is valid, we want to show a Snackbar
                    _formKey.currentState.save();
                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text("Subiendo Imagen")));
                    if(widget.publication.mediaLink != ''){
                      print("aquí se sube la imagen");
                      final image = new File(widget.publication.mediaLink);
                      String imageUrl = await uploadImage(image);
                      widget.publication.mediaLink = imageUrl;
                      widget.publication.mediaType = "image";
                      widget.publication.username = widget.currentUser.nombre;
                      Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text("Subiendo Publicación")));
                      final response = await dio.post("/publications/create",
                      data:widget.publication.toJson());
                      if(response.statusCode == 201){
                        Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => navigateToScreen(context: context,
                                body: Wall(currentUser: widget.currentUser, cameras: widget.cameras),
                                decorator: IconButton(
                                          icon: Icon(Icons.add),
                                          onPressed: (){Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => 
                                          navigateToScreen(context: context, cameras: widget.cameras,
                                          body: AddPublication(new PublicationModel('','','','','',DateTime.now(),'',''),widget.currentUser,widget.cameras),)));})
                                ),
                                ),
                              );
                      }
                      
                    }
                  }
                },
                child: Text(
                  'Publicar',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Viking',
                    // fuente personalizada aqui
                  ),
                ),
                color: Colors.green),
          ),
        ],
      ),
    );
  }
}
