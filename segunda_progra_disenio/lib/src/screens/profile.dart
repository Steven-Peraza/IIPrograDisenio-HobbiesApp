import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' show post;
import 'package:segunda_progra_disenio/src/models/profile_model.dart';
import 'dart:convert';
import '../CONSTANTS.dart';
import 'editProfile.dart';
import 'Wall/wall.dart';
import 'comunities.dart';
import '../../shared/AppThemes.dart';
import '../../shared/CommonTabBar.dart';


class Profile extends StatelessWidget {

  final ProfileModel currentUser;
  List<CameraDescription> cameras;

  BuildContext contexto;

  Profile({Key key, this.currentUser, this.cameras}) : super(key: key);
  Widget build(BuildContext context) {
    contexto = context;
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            new SliverAppBar(
              pinned: true,
              centerTitle: true,
              flexibleSpace: new DefaultTabController(
                initialIndex: 0,
                length: 3,
                child: Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.amber[100],
                    bottom: CommonNavigationTabBar.get(context: contexto, currentUser: this.currentUser, cameras: cameras),
                  ),
                ),
              ),
              backgroundColor: Colors.amber[100],
            ),
          ];
        },
      body: ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(20.0),
      children: <Widget>[
        Column(
          children: [
            personalStack(),
            Container(margin: EdgeInsets.only(top: 25.0)),
            emailText(),
            Container(margin: EdgeInsets.only(top: 40.0)),
            biolabel(),
            Container(margin: EdgeInsets.only(top: 10.0)),
            bioText(),
            Container(margin: EdgeInsets.only(top: 40.0)),
            hobbitlabel(),
            Container(margin: EdgeInsets.only(top: 10.0)),
            hobbitText(),
            Container(margin: EdgeInsets.only(top: 40.0)),
            editButton(),    
          ],
        ),
      ],
    )
    );
  }

  Widget editButton() {
    return RaisedButton(
      onPressed: () {
        Navigator.push(
              contexto,
              MaterialPageRoute(builder: (context) => MaterialApp(
                  title: 'The Shire',
                  theme: AppThemes.mainTheme,
                  home: Scaffold(
                    resizeToAvoidBottomPadding: false,
                    appBar: AppBar(
                      title: Text('The Shire',style: TextStyle(fontSize: 20.0,
                              color: Colors.black,
                              fontFamily: 'Viking',
                              ),
                      ),
                      centerTitle: true,
                      backgroundColor: Colors.green,
                      actions: <Widget>[
                        IconButton(
                          icon: Image.asset('assets/images/bag_end_alternate_1.png'),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    body: EditProfile(currentUser: this.currentUser),
                )
              ),
            ),
        );
      },
      child: Text(
        'Editar Perfil',
        style: TextStyle(
          fontFamily: 'Viking',
          color: Colors.white,
        // fuente personalizada aqui
        ),
      ),
      color: Colors.green,
    );
  }

  Widget personalStack() {
    // OJO con el get
    // getProfile();
    return Stack(
      alignment: const Alignment(0.0, 1.0),
      children: [
        CircleAvatar(
          backgroundImage: AssetImage('assets/images/essiri.png'),
          radius: 100.0,
        ),
        Container(
          decoration: BoxDecoration(
            //color: Colors.black26,
            color: Colors.transparent,
          ),
          child: 
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                ''+ currentUser.nombre,
                style: TextStyle(
                  fontFamily: 'Morris',
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                ''+currentUser.nick,
                style: TextStyle(
                  fontFamily: 'Morris',
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                ''+ currentUser.ubicacion,
                style: TextStyle(
                  fontFamily: 'Morris',
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
                ],

              ), 
        ),
      ],
    );
  }

  Widget emailText() {
    return  Text(
      ''+currentUser.email,
      style: TextStyle(
        fontFamily: 'Morris',
        fontSize: 20.0,
        // fuente personalizada aqui
        ),
      );
  }

  Widget biolabel() {
    return  Text(
      'Bio:',
      style: TextStyle(
        fontFamily: 'Viking',
        fontSize: 15.0,
        // fuente personalizada aqui
        ),
      );
  }

  Widget bioText() {
    return  Text(
      ''+ currentUser.bio,
      style: TextStyle(
        fontFamily: 'Morris',
        fontSize: 20.0,
        // fuente personalizada aqui
        ),
      );
  }

  Widget hobbitlabel() {
    return  Text(
      'Hobbies Preferidos:',
      style: TextStyle(
        fontFamily: 'Viking',
        fontSize: 15.0,
        // fuente personalizada aqui
        ),
      );
  }

  Widget hobbitText() {
    List hobbitses = currentUser.hobbies;
    String textoFinal = '';
    for (var i = 0; i < hobbitses.length; i++) {
      if (i == 0) {
        textoFinal += hobbitses[i];
      }
      else {
        textoFinal += ', '+ hobbitses[i];
      }
    }
    return  Text(
      '$textoFinal',
      style: TextStyle(
        fontFamily: 'Morris',
        fontSize: 20.0,
        // fuente personalizada aqui
        ),
      );
  }
}