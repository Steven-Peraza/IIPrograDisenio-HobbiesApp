import 'dart:convert';

class PublicationModel {
  String id;
  String text;
  String mediaType;
  String mediaLink;
  DateTime publicationDate;
  String type;
  String hobby;
  String username;

  PublicationModel(
    this.id,
    this.text,
    this.mediaType,
    this.hobby,
    this.mediaLink,
    this.publicationDate,
    this.type,
    this.username
    );

  PublicationModel.fromJason(Map<String,dynamic> parsedJson){
    this.id = parsedJson["id"];
    this.type = parsedJson["type"];
    this.mediaLink = parsedJson["linkMultimedia"];
    this.mediaType = parsedJson["tipoMultimedia"];
    this.text = parsedJson["text"];
    this.publicationDate = DateTime.parse(parsedJson["fechaPublicacion"]);
    this.hobby = parsedJson["hobby"];
    this.username = parsedJson["username"];

  }

  String toJson(){
    return json.encode({
      'id':id,
      'type':type,
      'linkMultimedia':mediaLink,
      'tipoMultimedia':mediaType,
      'text':text,
      'fechaPublicacion':publicationDate.toString(),
      'hobby':hobby,
      'username':username
    });
  }

  

  
}