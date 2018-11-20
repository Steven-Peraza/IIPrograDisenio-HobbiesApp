import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' show post;
import 'dart:convert';
import '../models/profile_model.dart';
import 'profile.dart';
import '../../shared/CommonTabBar.dart';



class Comus extends StatelessWidget {
  
  final ProfileModel currentUser;
  List<CameraDescription> cameras;

  BuildContext contexto;

  Comus({Key key, this.currentUser, this.cameras }) : super(key: key);

  Widget build(BuildContext context) {
    contexto = context;
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            new SliverAppBar(
              pinned: true,
              centerTitle: true,
              flexibleSpace: new DefaultTabController(
                initialIndex: 1,
                length: 3,
                child: Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.amber[100],
                    bottom: CommonNavigationTabBar.get(context: context, currentUser: currentUser, cameras: cameras),
                  ),
                ),
              ),
              backgroundColor: Colors.amber[100],
            ),
          ];
        },
      body: comuGrid(),
    );
  }


List<Widget> creaTiles() {
    String comuActual;
    return new List<Widget>.generate(this.currentUser.comunidades.length, (index) {
      comuActual = this.currentUser.comunidades[index];
           return new GridTile( 
              child: Container(child:Image.asset(
                  'assets/images/essiri.png',
                  fit: BoxFit.fill
                  ),
                ),
              footer: GridTileBar(
                backgroundColor: Colors.black45,
                title: FittedBox(
                  fit: BoxFit.fitHeight,
                  alignment: Alignment.topLeft,
                  child: Text('$comuActual'),
                ),
                subtitle: Text('Hobby'),
                trailing: IconButton(
                  icon: Icon(Icons.chat),
                  color: Colors.white,
                  onPressed: (){
                    // Aqui va el router al chat
                  },
                ),
              ),
            );
        });
  }

Widget comuGrid() {
    final Orientation orientation = MediaQuery.of(contexto).orientation;
    return GridView.count(
          // Create a grid with 2 columns. If you change the scrollDirection to
          // horizontal, this would produce 2 rows.
          crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3,
          childAspectRatio: (orientation == Orientation.portrait) ? 1.0 : 1.3,
          crossAxisSpacing: 4.0,
          shrinkWrap: true,
          padding: const EdgeInsets.all(4.0),
          children: creaTiles(),
      );    
  }
}

  

  