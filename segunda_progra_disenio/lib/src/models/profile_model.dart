

class ProfileModel {
  String nombre;
  String nick;
  String ubicacion;
  String foto;
  String bio;
  String email;
  String pass;
  List<String> hobbies;
  List<String> comunidades;

  ProfileModel (this.bio,
  this.comunidades,
  this.email,
  this.foto,
  this.hobbies,
  this.nick,
  this.nombre,
  this.pass,
  this.ubicacion);

  ProfileModel.fromJson(Map<String, dynamic> parsedJson){
    nombre = parsedJson['nombre'];
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
