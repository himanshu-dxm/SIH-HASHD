import 'dart:typed_data';
import 'model.dart';
// import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class CapturePicture{
  static List<Uint8List> images = [];
  static var num =1;
static Future<List<dynamic>> getImages()async{
  try{
    for(int i=0;i<num;i++)
  {
    print("adding img"+i.toString());
    await ImagePicker().pickImage(source: ImageSource.camera).then((value)async {
      images.add(await value!.readAsBytes());
    });
  }
  return images;
}catch(e){
  return [];
}
}
static Future<dynamic> getData()async{
  return await getSuggestions(images[0]);
}
}
