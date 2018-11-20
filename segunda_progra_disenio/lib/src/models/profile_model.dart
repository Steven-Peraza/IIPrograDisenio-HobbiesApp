

class ProfileModel {
  String apelllidos;
  String id;
  String nombre;
  String nick;
  String ubicacion;
  String foto;
  String bio;
  String email;
  String pass;
  List<dynamic> hobbies;
  List<dynamic> comunidades;

  ProfileModel (
  this.apelllidos,
  this.id, 
  this.bio,
  this.comunidades,
  this.email,
  this.foto,
  this.hobbies,
  this.nick,
  this.nombre,
  this.pass,
  this.ubicacion){
    this.comunidades = [];
    this.hobbies = [];
  }

  ProfileModel.fromJson(Map<String, dynamic> parsedJson){
    id = parsedJson['_id'];
    apelllidos = parsedJson['lastName'];
    nombre = parsedJson['name'];
    nick = parsedJson['nick'];
    ubicacion = parsedJson['ubicacion'];
    foto = parsedJson['foto'];
    bio = parsedJson['bio'];
    email = parsedJson['email'];
    pass = parsedJson['pass'];
    hobbies = parsedJson['hobbies'];
    comunidades = parsedJson['comunidades'];

  }

}
