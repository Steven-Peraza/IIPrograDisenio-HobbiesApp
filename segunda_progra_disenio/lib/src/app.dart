import 'package:flutter/material.dart';
import 'screens/login.dart';


class App extends StatelessWidget {
  Widget build(context) {
    return MaterialApp(
      title: 'The Shire',
      theme: ThemeData(
        primaryColor: Colors.green,
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.amber[100],
        dialogBackgroundColor: Colors.amber[100],
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
        body: Login(),
      ),
    );
  }
}