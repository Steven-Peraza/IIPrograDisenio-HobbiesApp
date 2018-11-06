import 'package:flutter/material.dart';
import 'package:http/http.dart' show post;
import 'dart:convert';
import '../CONSTANTS.dart';
import 'editProfile.dart';
import 'Wall/wall.dart';
import 'comunities.dart';


class Profile extends StatelessWidget {

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

  Profile({Key key, this.idActual,  this.nombre, this.apellidos, this.comus, this.email, this.pass, this.bio, this.hobbitses,
              this.nick, this.ubicacion}) : super(key: key);

void getComus() async {
    Uri uri = new Uri.http(CONSTANTS.BASE_URL, "/comus/getComuUser");
    Map<String,dynamic> jsonUser = {
      'idActual':idActual
    };
    Map<String,String> headers = {
    'Content-type' : 'application/json',
    'Accept': 'application/json',
    };
    var finalResponse = await post(uri, body: json.encode(jsonUser), headers: headers)
      .then((response){
        if (response.statusCode == 201) {
          var extractdata = json.decode(response.body);
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
                  body: Comus(idActual: idActual, nombre: nombre, apellidos: apellidos, email: email,
                                    pass: pass, bio: bio, nick: nick, ubicacion: ubicacion, hobbitses: hobbitses,
                                    comus: extractdata),
                )
              ),
            ),
          );
        }
        //_showDialog(); 
      });
  }

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
                              getComus();
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
                                    home: Wall() // Aqui va el Muro *******
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
                    body: EditProfile(idActual: idActual, nombre: nombre, apellidos: apellidos, email: email,
                                      pass: pass, bio: bio, nick: nick, ubicacion: ubicacion, hobbitses: hobbitses,
                                      comus: comus
                                      ),
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
                '$nombre',
                style: TextStyle(
                  fontFamily: 'Morris',
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                '$nick',
                style: TextStyle(
                  fontFamily: 'Morris',
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                '$ubicacion',
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
      '$email',
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
      '$bio',
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