import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';

import 'model.dart';
// import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class CapturePicture{
  static List<Uint8List> images = [];
  static List<String> filepaths = [];
  static Future getImages()async{
    var filePath = await getExternalStorageDirectory();
    try{
      print('taking images');
        await ImagePicker().pickImage(source: ImageSource.camera).then((value)async {
          print("tool image");
          var b = await value!.readAsBytes();
          images.add(b);
          // await File(filePath.toString()+"/i/${images.length}image.png").create(recursive: true).then((value)async{
          //   await value.writeAsBytes(b).then((value) {
          //             filepaths.add(filePath.toString()+"/i/${images.length}image.png");
          //           print("file added");
          //           });
          // });
          await value.saveTo(filePath!.path.toString()+"/${images.length}image.jpg");
          filepaths.add(filePath.path.toString()+"/${images.length}image.jpg");
          print("file added");
          print("filepaths"+filepaths.toString());
        });
    }catch(e){
      print(e.toString());
    }
  }
  static Future<dynamic> getData()async{
    return await getSuggestions(images[0]);
  }
  static getFilePaths(){
    return filepaths;
  }
}
