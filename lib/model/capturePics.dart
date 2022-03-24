import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';

import 'model.dart';
// import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class CapturePicture{
  static List<Uint8List> images = [];
  static List<String> filepaths = [];
  static var num =1;
  static Future<List<dynamic>> getImages()async{
    var filePath = await getExternalStorageDirectory();
    try{
      for(int i=0;i<num;i++)
      {
        print("adding img"+i.toString());
        await ImagePicker().pickImage(source: ImageSource.camera).then((value)async {
          File(filePath.toString()+"/${i}.jpg").writeAsBytesSync(await value!.readAsBytes());
          images.add(await value.readAsBytes());
          filepaths.add(filePath.toString()+"/${i}.jpg");
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
  static getFilePaths(){
    return filepaths;
  }
}
