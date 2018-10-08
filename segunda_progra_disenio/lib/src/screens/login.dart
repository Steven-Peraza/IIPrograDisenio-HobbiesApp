import 'package:flutter/material.dart';
import '../mixins/validation_mixin.dart';

class Login extends StatefulWidget {
  createState() {
    return LoginState();
  }
}

class LoginState extends State<Login> with ValidationMixin {
  final formKey = GlobalKey<FormState>();

  String email = '';
  String pass = '';

  Widget build(context) {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            textoIncio(),
            Container(margin: EdgeInsets.only(top: 25.0)),
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

  Widget textoIncio() {
    return  Text(
      'Inicio de Sesion',
      style: TextStyle(
        fontSize: 20.0,
        // fuente personalizada aqui
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
        // se navega a la pantalla de registro
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