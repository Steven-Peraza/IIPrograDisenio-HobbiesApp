import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:segunda_progra_disenio/shared/AppThemes.dart';
import 'package:segunda_progra_disenio/src/CONSTANTS.dart';
import 'package:segunda_progra_disenio/src/screens/Wall/wall.dart';
import 'package:segunda_progra_disenio/src/screens/comunities.dart';
import '../src/models/profile_model.dart';
import '../src/screens/profile.dart';
import './NavigateToScreen.dart';
import '../src/screens/Wall/add_publication_view.dart';
import '../src/models/publication_model.dart';

class CommonNavigationTabBar{
  static get({BuildContext context,ProfileModel currentUser, List<CameraDescription> cameras}){
    return TabBar(
                      indicatorColor: Colors.green,
                      tabs: [
                        Tab(child: new FlatButton(
                          child: new Text("Profile",style: TextStyle(fontSize: 10.0,
                              color: Colors.black,
                              fontFamily: 'Viking',
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => navigateToScreen(context: context,
                                body: Profile(currentUser: currentUser, cameras: cameras))
                                ),
                              );
                            },
                          ),
                        ),
                        Tab(child: new FlatButton(
                          child: new Text("Comus",style: TextStyle(fontSize: 10.0,
                              color: Colors.black,
                              fontFamily: 'Viking',
                              ),
                            ),
                            onPressed: () {
                              getComus(currentUser, context, cameras);
                            },
                          ),
                        ),
                        Tab(child: new FlatButton(
                          child: new Text("Muro",style: TextStyle(fontSize: 10.0,
                              color: Colors.black,
                              fontFamily: 'Viking',
                              ),),
                            onPressed: () {
                               Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => navigateToScreen(context: context,
                                body: Wall(currentUser: currentUser, cameras: cameras,),
                                decorator: IconButton(
                                          icon: Icon(Icons.add),
                                          onPressed: (){Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => 
                                          navigateToScreen(context: context, cameras: cameras,
                                          body: AddPublication(new PublicationModel('','','','','',DateTime.now(),'',''),currentUser,cameras),)));})
                                ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
  }

  static void getComus(ProfileModel currentUser, BuildContext context, List<CameraDescription> cameras ) async {
    Uri uri = new Uri.http(CONSTANTS.BASE_URL, "/comus/getComuUser");
    Map<String,dynamic> jsonUser = {
      'idActual':currentUser.id
    };
    Map<String,String> headers = {
    'Content-type' : 'application/json',
    'Accept': 'application/json',
    };
    var finalResponse = await post(uri, body: json.encode(jsonUser), headers: headers)
      .then((response){
        if (response.statusCode == 201) {
          currentUser.comunidades = json.decode(response.body);

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => navigateToScreen(context: context, 
            body: Comus(currentUser: currentUser, cameras:cameras) ),
            ),
          );
        }
      });
  }

  
}