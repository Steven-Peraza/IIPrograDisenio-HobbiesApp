import 'package:flutter/material.dart';
import '../../models/publication_model.dart';
import './publication_list.dart';
import 'package:http/http.dart' show post,get;
import 'dart:convert';
import '../../CONSTANTS.dart';
class Wall extends StatefulWidget {
  @override
    State<StatefulWidget> createState() {
      // TODO: implement createState
      return WallState();
    }
}

class WallState extends State<Wall>{
List<PublicationModel> publicationsList = [];

getPublications() async{
  final response = await get('https://'+CONSTANTS.BASE_URL+'/publications/getByHobby/Futbol');
  final parsedJson = json.decode(response.body) as List;
  setState(() {
      publicationsList = parsedJson.map((e)=> new PublicationModel.fromJason(e)).toList();
    });
  print(publicationsList);
}

@override
  Widget build(BuildContext context) {
    getPublications();
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('The Shire', 
        style:TextStyle(fontSize: 20.0,color: Colors.black, fontFamily:'Viking')
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
            icon: Image.asset('assets/images/bag_end_alternate_1.png'),
            onPressed: (){print("hola");},
          )
        ],
      ),
      body: PublicationList(publicationsList)
      
    );
  }
}
