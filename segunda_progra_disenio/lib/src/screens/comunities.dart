import 'package:flutter/material.dart';
import 'package:http/http.dart' show post;
import 'dart:convert';

import 'profile.dart';



class Comus extends StatelessWidget {
  final String idActual;
  final String nombre;
  final String apellidos;
  final String nick;
  final String ubicacion;
  final String email;
  final String pass;
  final String bio;
  final List<dynamic> hobbitses;
  final List<dynamic> comus;
  BuildContext contexto;

  Comus({Key key, this.idActual,  this.nombre, this.apellidos, this.comus, this.email, this.pass, this.bio, this.hobbitses,
              this.nick, this.ubicacion}) : super(key: key);

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
                    bottom: TabBar(
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
                                      body: new Profile(idActual: idActual, nombre: nombre, apellidos: apellidos, email: email,
                                                        pass: pass, bio: bio, nick: nick, ubicacion: ubicacion, hobbitses: hobbitses,
                                                        comus: comus
                                                        ),
                                    )
                                  ),
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
                            },
                          ),
                        ),
                        Tab(child: new FlatButton(
                          child: new Text("Muro",style: TextStyle(fontSize: 10.0,
                              color: Colors.black,
                              fontFamily: 'Viking',
                              ),),
                            onPressed: () {
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
      body: comuGrid(),
    );
  }


List<Widget> creaTiles() {
    String comuActual;
    return new List<Widget>.generate(comus.length, (index) {
      comuActual = comus[index];
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

  

  