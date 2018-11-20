import 'package:flutter/material.dart';
import './AppThemes.dart';
import 'package:camera/camera.dart';

 navigateToScreen({BuildContext context, Widget decorator, List<CameraDescription>cameras, Function backAction, Widget body}){
  return MaterialApp(
      title: 'The Shire',
      theme: AppThemes.mainTheme,
      home: Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text(
            'The Shire',
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.black,
              fontFamily: 'Viking',
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.green,
          leading: IconButton(
            icon: decorator==null ?  Icon(Icons.arrow_back):decorator,
            onPressed: () {
              backAction == null ? Navigator.pop(context):backAction();
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: Image.asset('assets/images/bag_end_alternate_1.png'),
              onPressed: () {},
            ),
          ],
        ),
        body: body
      ));
}
