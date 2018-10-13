import 'package:flutter/material.dart';
import '../mixins/validation_mixin.dart';
import 'editProfile.dart';

class Profile extends StatefulWidget {
  createState() {
    return ProfileState();
  }
}

class ProfileState extends State<Profile> with ValidationMixin {

  Widget build(context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            new SliverAppBar(
              pinned: true,
              centerTitle: true,
              title: new Text(
                'Perfil de Usuario:',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                  // fuente personalizada aqui
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
            comulabel(),
            Container(margin: EdgeInsets.only(top: 10.0)),
            comuGrid(),    
          ],
        ),
      ],
    )
    );
  }

  Widget personalStack() {
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
                'Steven Peraza',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                '"Ezz"',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                'Aguas Zarcas',
                style: TextStyle(
                  fontSize: 20.0,
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
      'sjpp8448@gmail.com',
      style: TextStyle(
        fontSize: 15.0,
        // fuente personalizada aqui
        ),
      );
  }

  Widget biolabel() {
    return  Text(
      'Bio:',
      style: TextStyle(
        fontSize: 20.0,
        // fuente personalizada aqui
        ),
      );
  }

  Widget bioText() {
    return  Text(
      'Puto el que lo lea... XD',
      style: TextStyle(
        fontSize: 15.0,
        // fuente personalizada aqui
        ),
      );
  }

  Widget hobbitlabel() {
    return  Text(
      'Hobbies Preferidos:',
      style: TextStyle(
        fontSize: 20.0,
        // fuente personalizada aqui
        ),
      );
  }

  Widget hobbitText() {
    return  Text(
      'Dormir, comer, cagar y juegar',
      style: TextStyle(
        fontSize: 15.0,
        // fuente personalizada aqui
        ),
      );
  }

  Widget comulabel() {
      return  Text(
        'Comunidades Miembro:',
        style: TextStyle(
          fontSize: 20.0,
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

  /*
  Navigator.push(
              context,
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
                      title: Text('The Shire'),
                      centerTitle: true,
                      backgroundColor: Colors.green,
                      actions: <Widget>[
                        IconButton(
                          icon: Image.asset('assets/images/bag_end_alternate_1.png'),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    body: EditProfile(),
                  ),
                )
              ),
            );
  */ 
}