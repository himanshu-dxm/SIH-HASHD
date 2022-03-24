import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';

import 'model.dart';
// import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class CapturePicture{
  static List<Uint8List> images = [];
  static List<String> filepaths = [];
  static Future<List<dynamic>> getImages()async{
    var filePath = await getExternalStorageDirectory();
    try{
      print('taking images');
        await ImagePicker().pickImage(source: ImageSource.camera).then((value)async {
          images.add(await value!.readAsBytes());
          File(filePath.toString()+"/${images.length}.jpg").writeAsBytesSync(await value.readAsBytes());
          filepaths.add(filePath.toString()+"/${images.length}.jpg");
        });
      print("filepaths"+filepaths.toString());
      return images;
    }catch(e){
      return [];
    }
  }
  static Future<dynamic> getData()async{
    return await getSuggestions(images[0]);
  }
  static getFilePaths(){
    return filepaths;
  }
}
