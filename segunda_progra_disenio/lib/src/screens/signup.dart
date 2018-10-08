import 'package:flutter/material.dart';
import '../mixins/validation_mixin.dart';

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
  // valores de la lista de hobbies
  Map<String, bool> values = {
    'acm1pt': false,
    'chupala': false,
    'asd': false,
    'fdgh': false,
    'qwe': false,
    'asds': false,
    'zxc': false,
    'chubnmpala': false,
  };

  Map<String, bool> tipos = {
    'Deporte': false,
    'Arte': false,
    'Ocio': false,
  };

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
            textoMedio(),
            Container(margin: EdgeInsets.only(top: 40.0)),
            hobbitList(),
            Container(margin: EdgeInsets.only(top: 25.0)),
            textoMedio2(),
            Container(margin: EdgeInsets.only(top: 25.0)),
            newHobbitField(),
            Container(margin: EdgeInsets.only(top: 25.0)),
            textoMedio3(),
            Container(margin: EdgeInsets.only(top: 25.0)),
            typeHobbitList(),
            Container(margin: EdgeInsets.only(top: 25.0)),
            createNewHobbitButton(),
            Container(margin: EdgeInsets.only(top: 40.0)),
            createButton(),
          ],
        ),
      ),
      ],
    )
    );
    
  }

  Widget hobbitList() {
    return ListView(
      shrinkWrap: true,
        children: values.keys.map((String key) {
          return new CheckboxListTile(
            title: new Text(key),
            value: values[key],
            onChanged: (bool value) {
              setState(() {
                values[key] = value;
              });
            },
          );
        }).toList()
      );
  }

  Widget typeHobbitList() {
    return ListView(
      shrinkWrap: true,
        children: tipos.keys.map((String key) {
          return new CheckboxListTile(
            title: new Text(key),
            value: tipos[key],
            onChanged: (bool value) {
              setState(() {
                tipos[key] = value;
              });
            },
          );
        }).toList()
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
      decoration: InputDecoration(
        labelText: 'Nickname:',
        hintText: 'Buglar',
      ),
      validator: validateNull,
      onSaved: (String value) {
        nick = value;
      },
    );
  }

  Widget ubiField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Ubicacion:',
        hintText: 'The Shire',
      ),
      validator: validateNull,
      onSaved: (String value) {
        email = value;
      },
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

  Widget createButton() {
    return RaisedButton(
      onPressed: () {
        if (formKey.currentState.validate()) {
          formKey.currentState.save();
          // aqui van todos las variables
          print('Time to post $nombre and $apellidos to the API');
        }
      },
      child: Text(
        'Create Profile',
        style: TextStyle(
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
        fontSize: 20.0,
        // fuente personalizada aqui
        ),
      );
  }

  Widget textoMedio() {
    return  Text(
      'Hobbitses Preferidos:',
      style: TextStyle(
        fontSize: 20.0,
        // fuente personalizada aqui
        ),
      );
  }
  

  Widget textoMedio2() {
    return  Text(
      'No encuentras tu Hobby? Crealo!',
      style: TextStyle(
        fontSize: 20.0,
        // fuente personalizada aqui
        ),
      );
  }

  Widget textoMedio3() {
    return  Text(
      'Tipo de Hobbit:',
      style: TextStyle(
        fontSize: 20.0,
        // fuente personalizada aqui
        ),
      );
  }

  Widget newHobbitField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Nombre del Hobby:',
        hintText: 'Walking into Mordor',
      ),
      validator: validateNull,
      onSaved: (String value) {
        newHobbit = value;
      },
    );
  }

  Widget newHobbitList() {
    return null;
  }

  Widget createNewHobbitButton() {
    return RaisedButton(
      onPressed: () {
        /*if (formKey.currentState.validate()) {
          formKey.currentState.save();
          // aqui van todos las variables
          print('Time to post $nombre and $apellidos to the API');
        }*/
      },
      child: Text(
        'Create New Hobbit',
        style: TextStyle(
        color: Colors.white,
        // fuente personalizada aqui
        ),
      ),
      color: Colors.green,
    );
  }
}