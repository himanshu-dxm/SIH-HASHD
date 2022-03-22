import 'dart:convert';
import 'package:flutter/services.dart';
// import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
//https://github.com/nandakishormpai/Plant_Disease_Detector
//thanks vroooos 
Future createAlbum()async {
  try{
  // var bytes = (Image.asset('download.jpg')).image;
  print("in");
ByteData bytes = await rootBundle.load("assets/images/download.jpg"); //load sound from assets
  final soundbytes = bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
  var imgdata=base64Encode(soundbytes);
  final response = await http.post(
    Uri.parse("https://plant-disease-detector-pytorch.herokuapp.com/"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'image': imgdata,
    }),
  );
  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    print(jsonDecode(response.body).toString());
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    // throw Exception('Failed to create album.').toString();
    print('else');
  }}
  catch(e){
    print(e);
  }

}


//in pubspec add http
//https://soilgrids.org/