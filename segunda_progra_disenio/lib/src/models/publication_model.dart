class PublicationModel {
  String id;
  String text;
  String mediaType;
  String mediaLink;
  DateTime publicationDate;
  String type;
  String hobby;

  PublicationModel(
    this.id,
    this.text,
    this.mediaType,
    this.hobby,
    this.mediaLink,
    this.publicationDate,
    this.type
    );

  PublicationModel.fromJason(Map<String,dynamic> parsedJson){
    this.id = parsedJson["id"];
    this.type = parsedJson["type"];
    this.mediaLink = parsedJson["linkMultimedia"];
    this.mediaType = parsedJson["tipoMultimedia"];
    this.text = parsedJson["text"];
    this.publicationDate = DateTime.parse(parsedJson["fechaPublicacion"]);
    this.hobby = parsedJson["hobby"];
  }

  

  
}