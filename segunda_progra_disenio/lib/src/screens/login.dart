import 'package:flutter/material.dart';
import 'package:http/http.dart' show get;
import '../mixins/validation_mixin.dart';
import 'dart:convert';

import 'profile.dart';
import 'signup.dart';

class Login extends StatefulWidget {
  createState() {
    return LoginState();
  }
}

class LoginState extends State<Login> with ValidationMixin {
  
  void login(String email,String pass) async {
    var response = await get('url/login');

    if(!(json.decode(response.body)['respuesta'] == 'You shall not pass!')){
      setState(() {
          logueo = true;
        });
    }
    
  }

  bool logueo = false;
  final formKey = GlobalKey<FormState>();

  String email = '';
  String pass = '';

  Widget build(context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            new SliverAppBar(
              pinned: true,
              centerTitle: true,
              title: new Text(
                'Inicio de Sesion:',
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
      body: Form(
          key: formKey,
          child: ListView(
            padding: EdgeInsets.all(20.0),
            children: [
              emailField(),
              Container(margin: EdgeInsets.only(top: 10.0)),
              passField(),
              Container(margin: EdgeInsets.only(top: 25.0)),
              submitButton(),
              Container(margin: EdgeInsets.only(top: 40.0)),
              textoMedio(),
              Container(margin: EdgeInsets.only(top: 25.0)),
              textoUnirse(),
              Container(margin: EdgeInsets.only(top: 25.0)),
              signUpButton(),       
            ],
          ),
        ),
    );
  }

  Widget emailField() {
    return TextFormField(
      keyboardType:TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Email:',
        hintText: 'theShire@middleearth.com',
      ),
      validator: validateEmail,
      onSaved: (String value) {
        email = value;
      },
    );
  }

  Widget passField() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Password:',
        hintText: 'Password',
      ),
      validator: validatePass,
      onSaved: (String value) {
        pass = value;
      },
    );
  }

  Widget submitButton() {
    return RaisedButton(
      onPressed: () {
        if (formKey.currentState.validate()) {
          formKey.currentState.save();
          print('Time to post $email and $pass to the API');
          login(email, pass);
          if (logueo){
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
                    body: Profile(),
                  ),
                )
              ),
            );
          }
          else {
            //Texto de c mamo!
          }
        }
      },
      child: Text(
        'Ingresar',
        style: TextStyle(
        color: Colors.white,
        // fuente personalizada aqui
        ),
      ),
      color: Colors.green,
    );
  }

  Widget textoMedio() {
    return  Text(
      'No posees cuenta aun?',
      style: TextStyle(
        fontSize: 20.0,
        // fuente personalizada aqui
        ),
      );
  }

  Widget textoUnirse() {
    return  Text(
      'Unete a la comunidad del anillo!',
      style: TextStyle(
        fontSize: 15.0,
        // fuente personalizada aqui
        ),
      );
  }

  Widget signUpButton() {
    return RaisedButton(
      onPressed: () {
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
                    body: SignUp(),
                  ),
                )
              ),
            );
      },
      child: Text(
        'Unirse',
        style: TextStyle(
        color: Colors.white,
        // fuente personalizada aqui
        ),
      ),
      color: Colors.green,
    );
  }
}