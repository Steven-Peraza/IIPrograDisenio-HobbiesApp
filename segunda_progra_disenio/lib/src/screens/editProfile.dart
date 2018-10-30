import 'package:flutter/material.dart';
import '../mixins/validation_mixin.dart';
import 'profile.dart';
import 'package:http/http.dart' show post, get;
import 'dart:convert';

class EditProfile extends StatefulWidget {
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
  EditProfile({Key key, this.idActual,  this.nombre, this.apellidos, this.comus, this.email, this.pass, this.bio, this.hobbitses,
              this.nick, this.ubicacion}) : super(key: key);
  @override
  EditProfileState createState() => new EditProfileState();
}

class EditProfileState extends State<EditProfile> with ValidationMixin {
  final formKey = GlobalKey<FormState>();

  String nombre = '';
  String apellidos = '';
  String nick = '';
  String ubicacion = '';
  String email = '';
  String pass = '';
  String newHobbit = '';
  String bio = '';
  String foto = '';
  List<dynamic> hobbitses = [];
  List<dynamic> comusv2 = [];
  // valores de la lista de hobbies
  Map<String, bool> values = {

  };

  Map<String, bool> newValues ={

  };

  String searchHobbie = '';

  Map<String, bool> comus = {
    'Alcoholicos Anonimos': true,
    'Clases de controlar la ira': true,
    'Comunidad de Stalkeadores de Celebridades': true,
  };

  void addValues() {
    for (var hobb in widget.hobbitses) {
      values['$hobb'] = true;
    }
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

  void sendEditUser() async{
    Uri uri = new Uri.http("192.168.1.125:3000", "/profiles/editProfile");
    Map<String,dynamic> jsonUser = {
      'idActual':widget.idActual,
      'name':nombre,
      'lastName':apellidos,
      'nick':nick,
      'ubicacion':ubicacion,
      'email':email,
      'pass':pass,
      'hobbies':hobbitses,
      'comunidades':comusv2,
      'bio': bio,
      'foto': foto
    };
    Map<String,String> headers = {
    'Content-type' : 'application/json',
    'Accept': 'application/json',
    };
    var finalResponse = await post(uri, body: json.encode(jsonUser), headers: headers)
      .then((response){
        if (response.statusCode == 201){
          _showDialog();           
        }
        else
        {
          throw Exception('Jaja C mamo!'); 
        }

      });
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
                'Editar Perfil:',
                style: TextStyle(
                  fontSize: 15.0,
                  fontFamily: 'Viking',
                  color: Colors.black,
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
            Container(margin: EdgeInsets.only(top: 25.0)),
            bioField(),
            Container(margin: EdgeInsets.only(top: 40.0)),
            textoMedio(),
            Container(margin: EdgeInsets.only(top: 25.0)),
            viewHobbitButton(),
            Container(margin: EdgeInsets.only(top: 40.0)),
            textoMedio2(),
            Container(margin: EdgeInsets.only(top: 25.0)),
            createNewHobbitButton(),
            Container(margin: EdgeInsets.only(top: 40.0)),
            textoMedio4(),
            Container(margin: EdgeInsets.only(top: 25.0)),
            comuList(),
            Container(margin: EdgeInsets.only(top: 40.0)),
            createButton(),
            Container(margin: EdgeInsets.only(top: 40.0)),
            returnButton(),

          ],
        ),
      ),
      ],
    )
    );
    
  }

  void _showDialog() {
    // flutter defined function
      showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Editar Perfil",style: TextStyle(fontFamily:'Viking'),),
          content: new Text("Usuario modificado correctamente!",style: TextStyle(fontFamily:'Morris'),),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Cerrar",style: TextStyle(fontFamily:'Viking'),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
    }
  void getData() async {
    Uri uri = new Uri.http("192.168.1.125:3000", "/profiles/getProfile");
    Map<String,dynamic> jsonUser = {
      'id':widget.idActual
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
                      title: Text('The Shire',style: TextStyle(fontFamily:'Viking',fontSize: 20.0),),
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
           throw Exception('Por aqui nunca pasare! Jeje');
        }
      });
  }

  Widget returnButton() {
    return RaisedButton(
      onPressed: () {
        getData();
      },
      child: Text(
        'Volver al Perfil',
        style: TextStyle(
          fontFamily: 'Viking',
          color: Colors.white,
        // fuente personalizada aqui
        ),
      ),
      color: Colors.green,
    );
  }

  Widget comuList() {
    return ListView(
      shrinkWrap: true,
        children: comus.keys.map((String key) {
          return new CheckboxListTile(
            title: new Text(key,style: TextStyle(fontFamily:'Morris',fontSize: 20.0),),
            value: comus[key],
            onChanged: (bool value) {
              setState(() {
                comus[key] = value;
              });
            },
          );
        }).toList()
      );
  }

  Widget viewHobbitButton() {
    return RaisedButton(
      onPressed: () {
        addValues();
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
                  "Busqueda de Hobbies",style: TextStyle(fontFamily:'Viking'),
                ),
                new TextField(
                  style: TextStyle(fontFamily:'Morris',fontSize: 20.0, color: Colors.black),
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
              child: new Text("Cerrar",style: TextStyle(fontFamily:'Viking'),),
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
      initialValue: widget.nombre,
      style: TextStyle(fontFamily:'Morris', fontSize: 20.0, color: Colors.black),
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
      initialValue: widget.apellidos,
      style: TextStyle(fontFamily:'Morris',fontSize: 20.0, color: Colors.black),
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
      initialValue: widget.nick,
      style: TextStyle(fontFamily:'Morris',fontSize: 20.0, color: Colors.black),
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
      initialValue: widget.ubicacion,
      style: TextStyle(fontFamily:'Morris',fontSize: 20.0, color: Colors.black),
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
      initialValue: widget.email,
      style: TextStyle(fontFamily:'Morris',fontSize: 20.0, color: Colors.black),
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
      initialValue: widget.pass,
      style: TextStyle(fontFamily:'Morris',fontSize: 20.0, color: Colors.black),
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

  Widget bioField() {
    return TextFormField(
      initialValue: widget.bio,
      style: TextStyle(fontFamily:'Morris',fontSize: 20.0, color: Colors.black),
      decoration: InputDecoration(
        labelText: 'Bio:',
        hintText: 'Soy parte de la comunidad del anillo!',
      ),
      validator: validateNull,
      onSaved: (String value) {
        bio = value;
      },
    );
  }

  void addHobbitses() {
    for (var entry in values.entries) {
      if (entry.value) {
        hobbitses.add(entry.key);
      }
    }
  }

  Widget createButton() {
    return RaisedButton(
      onPressed: () {
        if (formKey.currentState.validate()) {
          formKey.currentState.save();
          addHobbitses();
          sendEditUser();
        }
      },
      child: Text(
        'Edit Profile',
        style: TextStyle(
          fontFamily: 'Viking',
          color: Colors.white,
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
        fontFamily: 'Viking',
        fontSize: 15.0,
        // fuente personalizada aqui
        ),
      );
  }

  Widget textoMedio() {
    return  Text(
      'Hobbitses Preferidos:',
      style: TextStyle(
        fontFamily: 'Viking',
        fontSize: 15.0,
        // fuente personalizada aqui
        ),
      );
  }
  

  Widget textoMedio2() {
    return  Text(
      'Crear Nuevo Hobbit:',
      style: TextStyle(
        fontFamily: 'Viking',
        fontSize: 15.0,
        // fuente personalizada aqui
        ),
      );
  }

  Widget textoMedio4() {
    return  Text(
      'Comunidades Miembro:',
      style: TextStyle(
        fontFamily: 'Viking',
        fontSize: 15.0,
        // fuente personalizada aqui
        ),
      );
  }

  void creatingHobbit(){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Crea tu Hobbit",style: TextStyle(
            fontFamily: 'Viking',
            // fuente personalizada aqui
            ),
          ),
          content: new SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                new TextField(
                  style: TextStyle(
                    fontFamily: 'Morris',
                    fontSize: 20.0,
                    color: Colors.black
                    // fuente personalizada aqui
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
                            title: new Text("Nuevo Hobby", style: TextStyle(
                              fontFamily: 'Viking',
                              // fuente personalizada aqui
                              ),
                            ),
                            content: new Text("Hobby creado correctamente",style: TextStyle(
                              fontFamily: 'Morris',
                              fontSize: 20.0,
                              // fuente personalizada aqui
                              ),
                            ),
                          );
                        }
                      );
                    }
                    else{
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return new AlertDialog(
                            title: new Text("Nuevo Hobby", style: TextStyle(
                              fontFamily: 'Viking',
                              // fuente personalizada aqui
                              ),
                            ),
                            content: new Text("Error! Longitud Minima del hobby es 4 caracteres.",style: TextStyle(
                              fontFamily: 'Morris',
                              // fuente personalizada aqui
                              ),
                            ),
                          );
                        }
                      );
                    }
                    
                  },
                  child: Text(
                    'Agregar Hobbit',
                    style: TextStyle(
                      fontFamily: 'Viking',
                      color: Colors.white,
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
              child: new Text("Cerrar",style: TextStyle(
                fontFamily: 'Viking',
                // fuente personalizada aqui
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
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
}