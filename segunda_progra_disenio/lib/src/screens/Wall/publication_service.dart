import 'dart:io';
import 'package:dio/dio.dart';
import 'package:segunda_progra_disenio/src/CONSTANTS.dart';

class PublicationService{

uploadImage(File image) async {
  Dio dio = new Dio();
  dio.options.baseUrl = 'https://'+CONSTANTS.BASE_URL;
var response;
FormData formData = new FormData.from({
   "photo": new UploadFileInfo(image, DateTime.now().toString()+'.jpeg')
});
response = await dio.post("/publications/uploadImage", data: formData);
print(response.data);
return response.data['file']['location'];
}

}