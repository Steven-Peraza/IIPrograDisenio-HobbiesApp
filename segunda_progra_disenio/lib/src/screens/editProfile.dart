import 'package:flutter/material.dart';
import '../mixins/validation_mixin.dart';
import '../CONSTANTS.dart';
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
  String newDescr = '';
  String newComu = '';
  String bio = '';
  String foto = '';
  List<dynamic> hobbitses = [];
  List<dynamic> comusFinal = [];
  List<dynamic> comusv2 = [];
  List<dynamic> comusv3 = [];
  // valores de la lista de hobbies
  Map<String, bool> values = {

  };

  Map<String, bool> newValues ={

  };

  String searchHobbie = '';
  String searchCommie = '';

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
    Uri uri = new Uri.http(CONSTANTS.BASE_URL, "/hobbit/getHobbit");
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
    Uri uri = new Uri.https(CONSTANTS.BASE_URL, "/profiles/editProfile");
    Map<String,dynamic> jsonUser = {
      'idActual':widget.idActual,
      'name':nombre,
      'lastName':apellidos,
      'nick':nick,
      'ubicacion':ubicacion,
      'email':email,
      'pass':pass,
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
    Uri uri = new Uri.https(CONSTANTS.BASE_URL, "/hobbit/newHobbit");
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

  void postComu(String newComu, String hobSelect, String descrip) async {
    Uri uri = new Uri.http("192.168.1.125:3000", "/comus/newComu");
    Map<String,dynamic> jsonUser = {
      'name':newComu,
      'hobby':hobSelect,
      'descripcion': descrip,
      'users':[widget.idActual],
      'foto':""
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
            searchHobbie = '';
          });
        }
        //_showDialog(); 
      });
  }

  void getComus() async {
    Uri uri = new Uri.http("192.168.1.125:3000", "/comus/getComus");
    Map<String,dynamic> jsonUser = {
      'hobbies':widget.hobbitses
    };
    Map<String,String> headers = {
    'Content-type' : 'application/json',
    'Accept': 'application/json',
    };
    var finalResponse = await post(uri, body: json.encode(jsonUser), headers: headers)
      .then((response){
        if (this.mounted){
          var extractdata = json.decode(response.body);
          //print(extractdata);
          setState(() {
            print("Pase por el get: "+extractdata.toString());
            comusv2 = extractdata;
          });
        }
        //_showDialog(); 
      });
  }

  void joinComus(String joinNewComu) async {
    Uri uri = new Uri.http("192.168.1.125:3000", "/comus/joinComu");
    Map<String,dynamic> jsonUser = {
      'name':joinNewComu,
      'idActual': widget.idActual
    };
    Map<String,String> headers = {
    'Content-type' : 'application/json',
    'Accept': 'application/json',
    };
    var finalResponse = await post(uri, body: json.encode(jsonUser), headers: headers)
      .then((response){
        if (this.mounted){
          setState(() {
            comusFinal = widget.comus;
            comusFinal.add(joinNewComu);
          });
        }
        //_showDialog(); 
      });
  }

  void addNewHobby(String joinNewHobby) async {
    Uri uri = new Uri.http("192.168.1.125:3000", "/profiles/addHobby");
    Map<String,dynamic> jsonUser = {
      'newHobby':joinNewHobby,
      'idActual': widget.idActual
    };
    Map<String,String> headers = {
    'Content-type' : 'application/json',
    'Accept': 'application/json',
    };
    var finalResponse = await post(uri, body: json.encode(jsonUser), headers: headers)
      .then((response){
        if (this.mounted){
          print("Nuevo hobby anyadido");
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
            createButton(),
            Container(margin: EdgeInsets.only(top: 40.0)),            
            textoMedio(),
            Container(margin: EdgeInsets.only(top: 25.0)),
            viewHobbitButton(),
            Container(margin: EdgeInsets.only(top: 40.0)),
            textoMedio2(),
            Container(margin: EdgeInsets.only(top: 25.0)),
            createNewHobbitButton(),
            Container(margin: EdgeInsets.only(top: 40.0)),
            textoMedio5(),
            Container(margin: EdgeInsets.only(top: 25.0)),
            joinComuButton(),
            Container(margin: EdgeInsets.only(top: 40.0)),
            textoMedio4(),
            Container(margin: EdgeInsets.only(top: 25.0)),
            createNewComuButton(),
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
    Uri uri = new Uri.https(CONSTANTS.BASE_URL, "/profiles/getProfile");
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
    var textController = new TextEditingController();
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
                  controller: textController,
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
                          textController.text = key;
                          searchHobbie = key;
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
              child: new Text("Add Hobby",style: TextStyle(fontFamily:'Viking'),),
              onPressed: () {
                addNewHobby(searchHobbie);
                showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return new AlertDialog(
                            title: new Text("Hobbitses Preferidos", style: TextStyle(
                              fontFamily: 'Viking',
                              // fuente personalizada aqui
                              ),
                            ),
                            content: new Text("Nuevo Hobby agregado: $searchHobbie!",style: TextStyle(
                              fontFamily: 'Morris',
                              // fuente personalizada aqui
                              ),
                            ),
                          );
                        }
                      );
              },
            ),
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

  void searchCommies(String text){
    print("comusV2"+comusv2.toString());
    //print(widget.comus);
    for (var entry in comusv2) {
      if ((entry.startsWith(text)) && (!(widget.comus.contains(entry)))) {
        comusv3.add(entry);
      }
    }
    print(comusv3);
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
          getHobbitses();
          addHobbitses();
          sendEditUser();
        }
      },
      child: Text(
        'Edit Personal Data',
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
      'Crear Nuevas Comunidades:',
      style: TextStyle(
        fontFamily: 'Viking',
        fontSize: 15.0,
        // fuente personalizada aqui
        ),
      );
  }

  Widget textoMedio5() {
    return  Text(
      'Unirse a una Comunidad:',
      style: TextStyle(
        fontFamily: 'Viking',
        fontSize: 15.0,
        // fuente personalizada aqui
        ),
      );
  }

  Widget joinComuButton() {
    return RaisedButton(
      onPressed: () {
        getComus();
        joiningComu();
      },
      child: Text(
        'Join Community',
        style: TextStyle(
          fontFamily: 'Viking',
          color: Colors.white,
        // fuente personalizada aqui
        ),
      ),
      color: Colors.green,
    );
  }

  void joiningComu(){
    var textController = new TextEditingController();
    String comuActual;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Unete a una comunidad!",style: TextStyle(fontFamily:'Viking'),),
          content: new SingleChildScrollView(
            child: new Column(
              children: <Widget>[
                new Text(
                  "Busqueda de Comunidades segun tus hobbies!",style: TextStyle(fontFamily:'Viking'),
                ),
                new TextField(
                  controller: textController,
                  style: TextStyle(fontFamily:'Morris',fontSize: 20.0, color: Colors.black),
                  decoration: InputDecoration(
                    labelText: 'Comu a Buscar:',
                    hintText: 'Comunidad del Anillo',
                  ),
                  //validator: validateNull,
                  onSubmitted: (String value) {
                    searchCommie = value;
                    searchCommies(searchCommie);
                  },
                  onChanged: (String value){
                    comusv3 = [];
                  },
                ),
                new ListView(
                shrinkWrap: true,
                  children:  new List<Widget>.generate(comusv3.length, (index) {
                    comuActual = comusv3[index];
                    print('ListItem:' + comuActual);
                        return new ListTile( 
                            title: new Text(comuActual,style: TextStyle(fontFamily:'Morris',fontSize: 20.0),),
                                  onTap: () {
                                    setState(() {
                                      textController.text = comusv3[index];
                                      searchCommie = comusv3[index];
                                    });
                                  },
                          );
                      }),
                ),
              ],
            ),
          ),
              
          
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Unirse",style: TextStyle(fontFamily:'Viking'),),
              onPressed: () {
                joinComus(searchCommie);
                showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return new AlertDialog(
                            title: new Text("Unete a una comunidad!", style: TextStyle(
                              fontFamily: 'Viking',
                              // fuente personalizada aqui
                              ),
                            ),
                            content: new Text("Te has unido a la Comunidad de $searchCommie!",style: TextStyle(
                              fontFamily: 'Morris',
                              // fuente personalizada aqui
                              ),
                            ),
                          );
                        }
                      );
              },
            ),
            new FlatButton(
              child: new Text("Cerrar",style: TextStyle(fontFamily:'Viking'),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
    setState(() {
      newValues = {};
    });
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
              ],
            ),
            
          ),    
          
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
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
                    'New Hobbit',
                    style: TextStyle(
                      fontFamily: 'Viking',
                    // fuente personalizada aqui
                    ),
                  ),
                ),
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


  void creatingComu(){
    var textController = new TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Crea tu Comunidad",style: TextStyle(
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
                    labelText: 'Comunidad a crear:',
                    hintText: 'Comunidad del anillo',
                  ),
                  onSubmitted: (String value) {
                    setState(() {
                      newComu = value;                 
                    });

                  },
                ),
                new TextField(
                  style: TextStyle(
                    fontFamily: 'Morris',
                    fontSize: 20.0,
                    color: Colors.black
                    // fuente personalizada aqui
                    ),
                  decoration: InputDecoration(
                    labelText: 'Descripcion:',
                    hintText: 'Comunidad dedicada a salvar la Tierra Media',
                  ),
                  onSubmitted: (String value) {
                    setState(() {
                      newDescr = value;                 
                    });

                  },
                ),
                new TextField(
                  controller: textController,
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
                          textController.text = key;
                          searchHobbie = key;
                          newValues = {};
                        });
                      },
                    );
                  }).toList()
                ),
                new Container(margin: EdgeInsets.only(top: 25.0)),
              ],
            ),
            
          ),    
          
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
                        new FlatButton(
                  onPressed: () {
                    print("desc ="+newDescr);
                    print("comu ="+newComu);
                    print("hobb ="+searchHobbie);
                    if (( newDescr.length >= 10 ) && ( newComu.length >= 10 ) && (searchHobbie != '')){
                      postComu(newComu,searchHobbie,newDescr);
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return new AlertDialog(
                            title: new Text("Nueva Commie", style: TextStyle(
                              fontFamily: 'Viking',
                              // fuente personalizada aqui
                              ),
                            ),
                            content: new Text("Comunidad creada correctamente",style: TextStyle(
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
                            title: new Text("Nueva Commie", style: TextStyle(
                              fontFamily: 'Viking',
                              // fuente personalizada aqui
                              ),
                            ),
                            content: new Text("Error! Longitud Minima de los campos es de 10 caracteres O datos insuficientes.",style: TextStyle(
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
                    'Crear Comu',
                    style: TextStyle(
                      fontFamily: 'Viking',
                    // fuente personalizada aqui
                    ),
                  ),
                ),
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

  Widget createNewComuButton() {
    return RaisedButton(
      onPressed: () {
        addValues();
        creatingComu();
      },
      child: Text(
        'Create New Comu',
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