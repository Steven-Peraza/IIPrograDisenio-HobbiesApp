
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import '../../models/publication_model.dart';
import './publication_list.dart';
import 'package:http/http.dart' show post,get;
import 'dart:convert';
import '../../CONSTANTS.dart';
import '../../../shared/CommonTabBar.dart';
import '../../models/profile_model.dart';
import '../../../shared/AppThemes.dart';
class Wall extends StatefulWidget {
  final ProfileModel currentUser;
  List<CameraDescription> cameras;

  Wall({Key key,this.currentUser, this.cameras}) : super(key:key);
  

  @override
    State<StatefulWidget> createState() {
      // TODO: implement createState
      
      return WallState();
    }
}

class WallState extends State<Wall>{
List<PublicationModel> publicationsList = [];

WallState(){
  getPublications();
}

getPublications() async{
  final response = await get('https://'+CONSTANTS.BASE_URL+'/publications/getByHobby/Futbol');
  final parsedJson = json.decode(response.body) as List;
  setState(() {
      publicationsList = parsedJson.map((e)=> new PublicationModel.fromJason(e)).toList();
    });
}


@override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            new SliverAppBar(
              pinned: true,
              centerTitle: true,
              flexibleSpace: new DefaultTabController(
                initialIndex: 2,
                length: 3,
                child: Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.amber[100],
                    bottom: CommonNavigationTabBar.get(context: context, currentUser: widget.currentUser, cameras: widget.cameras),
                  ),
                ),
              ),
              backgroundColor: Colors.amber[100],
            ),
          ];
        },
      body: new PublicationList(this.publicationsList),
    );
  }
}
