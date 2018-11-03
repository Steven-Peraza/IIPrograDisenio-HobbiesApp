import 'package:flutter/material.dart';
import 'package:http/http.dart' show post;
import 'dart:convert';



class Comus extends StatelessWidget {

  BuildContext contexto;

  Widget build(BuildContext context) {
    contexto = context;
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            new SliverAppBar(
              pinned: true,
              centerTitle: true,
              flexibleSpace: new DefaultTabController(
                length: 3,
                child: Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.amber[100],
                    bottom: TabBar(
                      indicatorColor: Colors.green,
                      tabs: [
                        Tab(child: new FlatButton(
                          child: new Text("Profile",style: TextStyle(fontSize: 15.0,
                              color: Colors.black,
                              fontFamily: 'Viking',
                              ),
                            ),
                            onPressed: () {

                            },
                          ),
                        ),
                        Tab(child: new FlatButton(
                          child: new Text("Comus",style: TextStyle(fontSize: 15.0,
                              color: Colors.black,
                              fontFamily: 'Viking',
                              ),
                            ),
                            onPressed: () {
                            },
                          ),
                        ),
                        Tab(child: new FlatButton(
                          child: new Text("Muro",style: TextStyle(fontSize: 15.0,
                              color: Colors.black,
                              fontFamily: 'Viking',
                              ),),
                            onPressed: () {
                              Navigator.push(
                                contexto,
                                MaterialPageRoute(builder: (context) => MaterialApp(
                                    title: 'The Shire',
                                    theme: ThemeData(
                                      primaryColor: Colors.green,
                                      primarySwatch: Colors.green,
                                      scaffoldBackgroundColor: Colors.amber[100],
                                      cursorColor: Colors.green,
                                      accentColor: Colors.green,
                                    ),
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
                                      /*body: EditProfile(idActual: idActual, nombre: nombre, apellidos: apellidos, email: email,
                                                        pass: pass, bio: bio, nick: nick, ubicacion: ubicacion, hobbitses: hobbitses,
                                                        comus: comus
                                                        ),*/
                                    )
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
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
            comulabel(),
            Container(margin: EdgeInsets.only(top: 10.0)),
            comuGrid(),
          ],
        ),
      ],
    )
    );
  }

}




Widget comulabel() {
      return  Text(
        'Comunidades Miembro:',
        style: TextStyle(
          fontFamily: 'Viking',
          fontSize: 15.0,
          // fuente personalizada aqui
          ),
        );
  }

  Widget comuGrid() {
    return GridView.extent(
      shrinkWrap: true,
      maxCrossAxisExtent: 150.0,
      padding: const EdgeInsets.all(4.0),
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
      children: <Widget>[
        Image.asset(
          'assets/images/essiri.png',
          semanticLabel: 'Comunidad X',
        ),
        Image.asset(
          'assets/images/essiri.png',
          semanticLabel: 'Comunidad X',
        ),
        Image.asset(
          'assets/images/essiri.png',
          semanticLabel: 'Comunidad X',
        ),
      ]);
  }