import 'package:flutter/material.dart';
import 'package:http/http.dart' show post;
import '../mixins/validation_mixin.dart';
import 'dart:convert';
import '../CONSTANTS.dart';
import 'profile.dart';
import 'signup.dart';

class Login extends StatefulWidget {
  createState() {
    return LoginState();
  }
}

class LoginState extends State<Login> with ValidationMixin {
  
  void login(String email,String pass) async {
    Uri uri = new Uri.https(CONSTANTS.BASE_URL, "/user/login");
    Map<String,dynamic> jsonUser = {
      'email':email,
      'pass':pass
    };
    Map<String,String> headers = {
    'Content-type' : 'application/json',
    'Accept': 'application/json',
    };
    var finalResponse = await post(uri, body: json.encode(jsonUser), headers: headers)
      .then((response){
        if (this.mounted){
          setState(() {
          email = '';
          pass = '';
        });   
        }

        if (response.statusCode == 201) {
            var extractdata = json.decode(response.body);
            print(extractdata['_id']);
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
                      title: Text('The Shire',style: TextStyle(fontFamily: 'Viking'),),
                      centerTitle: true,
                      backgroundColor: Colors.green,
                      actions: <Widget>[
                        IconButton(
                          icon: Image.asset('assets/images/bag_end_alternate_1.png'),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    body: Profile(idActual: extractdata['_id'], nombre: extractdata['name'], apellidos: extractdata['lastName'],
                                  email: extractdata['email'], pass: extractdata['pass'], bio: extractdata['bio'], nick: extractdata['nick'],
                                  ubicacion: extractdata['ubicacion'], hobbitses: extractdata['hobbies'], comus: extractdata['comunidades']),
                  ),
                )
              ),
            );
        } else {
          // If that response was not OK, throw an error.
           _showDialog(); 
        }
      });
  }

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
                  fontFamily: 'Viking',
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
      style: TextStyle(
        fontFamily: 'Morris',
        fontSize: 20.0,
        color: Colors.black,
      ),
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
      style: TextStyle(
        fontFamily: 'Morris',
        fontSize: 20.0,
        color: Colors.black,
      ),
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
          login(email, pass);
          formKey.currentState.reset();
        }
      },
      child: Text(
        'Ingresar',
        style: TextStyle(
          fontFamily: 'Viking',
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
        fontFamily: 'Morris',
        fontSize: 35.0,
        // fuente personalizada aqui
        ),
      );
  }

  Widget textoUnirse() {
    return  Text(
      'Unete a la comunidad del anillo!',
      style: TextStyle(
        fontFamily: 'Morris',
        fontSize: 30.0,
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
                      title: Text('The Shire',style: TextStyle(fontFamily: 'Viking'),),
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
          fontFamily: 'Viking',
        color: Colors.white,
        // fuente personalizada aqui
        ),
      ),
      color: Colors.green,
    );
  }

  void _showDialog() {
    // flutter defined function
      showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Contraseña o correo incorrectos",style: TextStyle(fontFamily: 'Viking'),),
          content: new Text("Intente de nuevo!",style: TextStyle(fontFamily: 'Morris'),),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Cerrar",style: TextStyle(fontFamily: 'Viking'),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
    }
}