import 'package:flutter/material.dart';
import 'package:http/http.dart' show post, get;
import '../mixins/validation_mixin.dart';
import 'dart:convert';

class SignUp extends StatefulWidget {
  createState() {
    return SignUpState();
  }
}

class SignUpState extends State<SignUp> with ValidationMixin {
  final formKey = GlobalKey<FormState>();

  String nombre = '';
  String apellidos = '';
  String nick = '';
  String ubicacion = '';
  String email = '';
  String pass = '';
  String newHobbit = '';
  List<String> hobbitses = [];
  // valores de la lista de hobbies
  Map<String, bool> values = {

  };

  Map<String, bool> newValues ={

  };

  String searchHobbie = '';

  void addHobbitses() {
    for (var entry in values.entries) {
      if (entry.value) {
        hobbitses.add(entry.key);
      }
    }
  }

  void sendNewUser() async {
    Uri uri = new Uri.http("192.168.1.125:3000", "/user/signup");
    Map<String,dynamic> jsonUser = {
      'name':nombre,
      'lastName':apellidos,
      'nick':nick,
      'ubicacion':ubicacion,
      'email':email,
      'pass':pass,
      'hobbies':hobbitses,
      'comunidades':[],
      'bio': 'Soy parte de la comunidad del anillo!',
      'foto': ''
    };
    Map<String,String> headers = {
    'Content-type' : 'application/json',
    'Accept': 'application/json',
    };
    var finalResponse = await post(uri, body: json.encode(jsonUser), headers: headers)
      .then((response){
        if (this.mounted){
          setState(() {
          nombre = '';
          apellidos = '';
          nick = '';
          ubicacion = '';
          email = '';
          pass = '';
          newHobbit = '';
          values = {
          };
          });
        }

        _showDialog(); 
      });
  }

  void getHobbitses() async {
    Uri uri = new Uri.http("192.168.1.125:3000", "/hobbit/getHobbit");
    var response = await get(uri);
    if (response.statusCode == 201) {
    // If server returns an OK response, parse the JSON
      var list = json.decode(response.body);
      for (var entry in list) {
        if (!(values.containsKey(entry))) {
          values['$entry'] = false;
        }

    }
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }

  void postHobb(String newHobbit) async {
    Uri uri = new Uri.http("192.168.1.125:3000", "/hobbit/newHobbit");
    Map<String,dynamic> jsonUser = {
      'name':newHobbit,
    };
    Map<String,String> headers = {
    'Content-type' : 'application/json',
    'Accept': 'application/json',
    };
    var finalResponse = await post(uri, body: json.encode(jsonUser), headers: headers)
      .then((response){
        if (this.mounted){
          setState(() {
            newHobbit = '';
          });
        }
        //_showDialog(); 
      });
  }

  Widget build(context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            new SliverAppBar(
              pinned: true,
              centerTitle: true,
              title: new Text(
                'Crea una nueva cuenta:',
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black,
                  fontFamily: 'Viking',
                  // fuente personalizada aqui
                ),
              ),
              backgroundColor: Colors.amber[100],
            ),
          ];
        },
      body: ListView(
      padding: EdgeInsets.all(20.0),
      children: <Widget>[
        Form(
        key: formKey,
        child: Column(
          children: [
            textoInicio(),
            Container(margin: EdgeInsets.only(top: 25.0)),
            rowN1(),
            Container(margin: EdgeInsets.only(top: 25.0)),
            rowN2(),
            Container(margin: EdgeInsets.only(top: 25.0)),
            emailField(),
            Container(margin: EdgeInsets.only(top: 25.0)),
            passField(),
            Container(margin: EdgeInsets.only(top: 40.0)),
            textoMedio(),
            Container(margin: EdgeInsets.only(top: 25.0)),
            viewHobbitButton(),
            Container(margin: EdgeInsets.only(top: 40.0)),
            textoMedio2(),
            Container(margin: EdgeInsets.only(top: 25.0)),
            createNewHobbitButton(),
            Container(margin: EdgeInsets.only(top: 40.0)),
            textoMedio3(),
            Container(margin: EdgeInsets.only(top: 25.0)),
            createButton(),
          ],
        ),
      ),
      ],
    )
    );
    
  }

  void hobbitList() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Hobbitses Preferidos",style: TextStyle(fontFamily:'Viking'),),
          content: new SingleChildScrollView(
            child: new Column(
              children: <Widget>[
                new Text(
                  "Busqueda de Hobbies",
                  style: TextStyle(
                    fontFamily: 'Viking',
                  ),
                ),
                new TextField(
                  style: TextStyle(
                    fontFamily: 'Morris',
                    color: Colors.black,
                    fontSize: 20.0,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Hobbie a Buscar:',
                    hintText: 'Cazar Huargos',
                  ),
                  //validator: validateNull,
                  onSubmitted: (String value) {
                    searchHobbie = value;
                    searchHobbiton(searchHobbie);
                  },
                  onChanged: (String value){
                    newValues = {};
                  },
                ),
                new ListView(
                shrinkWrap: true,
                  children: newValues.keys.map((String key) {
                    return new CheckboxListTile(
                      title: new Text(key,style: TextStyle(fontFamily:'Morris',fontSize: 20.0),),
                      value: newValues[key],
                      onChanged: (bool value) {
                        setState(() {
                          newValues[key] = value;
                          values[key] = value;
                        });
                      },
                    );
                  }).toList()
                ),
              ],
            ),
          ),
              
          
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Cerrar",style: TextStyle(
                    fontFamily: 'Viking',
                  )),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
    setState(() {
      newValues = {};
    });
    
  }

  void searchHobbiton(String text){
    for (var entry in values.entries) {
      if (entry.key.startsWith(text)) {
        var joder = entry.key;
        newValues[joder] = entry.value;
      }
    }
  }

  void creatingHobbit(){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Crea tu Hobbit",style: TextStyle(
                    fontFamily: 'Viking',
                  ),),
          content: new SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                new TextField(
                  style: TextStyle(
                    fontFamily: 'Morris',
                    color: Colors.black,
                    fontSize: 20.0,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Hobbie a Crear:',
                    hintText: 'Cazar Huargos',
                  ),
                  onSubmitted: (String value) {
                    newHobbit = value;
                  },
                ),
                new Container(margin: EdgeInsets.only(top: 25.0)),
                new FlatButton(
                  onPressed: () {
                    if ( newHobbit.length >= 4 ) {
                      postHobb(newHobbit);
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return new AlertDialog(
                            title: new Text("Nuevo Hobby",style: TextStyle(
                              fontFamily: 'Viking',
                            ),),
                            content: new Text("Hobby creado correctamente",style: TextStyle(
                              fontFamily: 'Morris',
                            ),),
                          );
                        }
                      );
                    }
                    else{
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return new AlertDialog(
                            title: new Text("Nuevo Hobby",style: TextStyle(
                              fontFamily: 'Viking',
                            ),),
                            content: new Text("Error! Longitud Minima del hobby es 4 caracteres.",style: TextStyle(
                              fontFamily: 'Morris',
                            )),
                          );
                        }
                      );
                    }
                    
                  },
                  child: Text(
                    'Agregar Hobbit',
                    style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Viking',
                    // fuente personalizada aqui
                    ),
                  ),
                  color: Colors.green,
                ),
              ],
            ),
            
          ),    
          
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Cerrar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget rowN1() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: nameField(),
        ),
        Container(margin: EdgeInsets.only(left: 10.0)),
        Expanded(
          child: appField(),
        ),
      ],
    );
  }

  Widget rowN2() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: nickField(),
        ),
        Container(margin: EdgeInsets.only(left: 10.0)),
        Expanded(
          child: ubiField(),
        ),
      ],
    );
  }

  Widget nameField() {
    return TextFormField(
      style: TextStyle(
                    fontFamily: 'Morris',
                    color: Colors.black,
                    fontSize: 20.0,
                  ),
      decoration: InputDecoration(
        labelText: 'Name:',
        hintText: 'Bilbo',
      ),
      validator: validateNull,
      onSaved: (String value) {
        nombre = value;
      },
    );
  }

  Widget appField() {
    return TextFormField(
      style: TextStyle(
                    fontFamily: 'Morris',
                    color: Colors.black,
                    fontSize: 20.0,
                  ),
      decoration: InputDecoration(
        labelText: 'Last Names:',
        hintText: 'Baggins',
      ),
      validator: validateNull,
      onSaved: (String value) {
        apellidos = value;
      },
    );
  }

  Widget nickField() {
    return TextFormField(
      style: TextStyle(
                    fontFamily: 'Morris',
                    color: Colors.black,
                    fontSize: 20.0,
                  ),
      decoration: InputDecoration(
        labelText: 'Nickname:',
        hintText: '"Buglar"',
      ),
      validator: validateNull,
      onSaved: (String value) {
        nick = value;
      },
    );
  }

  Widget ubiField() {
    return TextFormField(
      style: TextStyle(
                    fontFamily: 'Morris',
                    color: Colors.black,
                    fontSize: 20.0,
                  ),
      decoration: InputDecoration(
        labelText: 'Ubicacion:',
        hintText: 'The Shire',
      ),
      validator: validateNull,
      onSaved: (String value) {
        ubicacion = value;
      },
    );
  }

  Widget emailField() {
    return TextFormField(
      style: TextStyle(
                    fontFamily: 'Morris',
                    color: Colors.black,
                    fontSize: 20.0,
                  ),
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
      style: TextStyle(
                    fontFamily: 'Morris',
                    color: Colors.black,
                    fontSize: 20.0,
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

  Widget createButton() {
    return RaisedButton(
      onPressed: () {
        if (formKey.currentState.validate()) {
          formKey.currentState.save();
          addHobbitses();
          // aqui van todos las variables
          sendNewUser();
          formKey.currentState.reset();
          setState(() {
            values = {
            };            
          });
        }
      },
      child: Text(
        'Create Profile',
        style: TextStyle(
        color: Colors.white,
        fontFamily: 'Viking',
        // fuente personalizada aqui
        ),
      ),
      color: Colors.green,
    );
  }

  Widget textoInicio() {
    return  Text(
      'Datos Personales:',
      style: TextStyle(
        fontSize: 15.0,
        fontFamily: 'Viking',
        // fuente personalizada aqui
        ),
      );
  }

  Widget textoMedio() {
    return  Text(
      'Hobbies:',
      style: TextStyle(
        fontSize: 15.0,
        fontFamily: 'Viking',
        // fuente personalizada aqui
        ),
      );
  }
  

  Widget textoMedio2() {
    return  Text(
      'No encuentras tu Hobby? Crealo!',
      style: TextStyle(
        fontSize: 15.0,
        fontFamily: 'Viking',
        // fuente personalizada aqui
        ),
      );
  }

  Widget textoMedio3() {
    return  Text(
      'Registro de Cuenta',
      style: TextStyle(
        fontSize: 15.0,
        fontFamily: 'Viking',
        // fuente personalizada aqui
        ),
      );
  }

  Widget viewHobbitButton() {
    return RaisedButton(
      onPressed: () {
        getHobbitses();
        hobbitList();
      },
      child: Text(
        'Agregar Hobbitses',
        style: TextStyle(
        fontFamily: 'Viking',
        color: Colors.white,
        // fuente personalizada aqui
        ),
      ),
      color: Colors.green,
    );
  }

  Widget createNewHobbitButton() {
    return RaisedButton(
      onPressed: () {
        creatingHobbit();
      },
      child: Text(
        'Create New Hobbit',
        style: TextStyle(
        fontFamily: 'Viking',
        color: Colors.white,
        // fuente personalizada aqui
        ),
      ),
      color: Colors.green,
    );
  }

  // user defined function
  void _showDialog() {
    // flutter defined function
      showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("SignUp", style:TextStyle(fontFamily:'Viking')),
          content: new Text("Usuario creado correctamente!", style:TextStyle(fontFamily:'Morris')),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Cerrar", style:TextStyle(fontFamily:'Viking')),
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