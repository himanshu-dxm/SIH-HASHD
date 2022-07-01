import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tflite/tflite.dart';
import 'model.dart';
import 'package:image_picker/image_picker.dart';

class CapturePicture{
  static List<Uint8List?> images = [];
  static List<String?> filepaths = [];
  static List? outputs;
  static File? image1;
  String output = '';

  static Future<void> getImages()async{
    try {
      var filePath = await getExternalStorageDirectory();
      await ImagePicker().pickImage(source: ImageSource.camera).then((value)async {
            print("tool image");
            var b = await value!.readAsBytes();
            images.add(b);
            await File(filePath!.path.toString()+"/i/${images.length}image.png").create(recursive: true).then((value)async{
              await value.writeAsBytes(b).then((value) {
                        filepaths.add(filePath.path.toString()+"/i/${images.length}image.png");
                      print("file added");
                      });
            });
            
          });
    } on Exception catch (e) {
      // TODO
      print(e.toString());
    }
  }

  static pickImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(image==null) {
      print("Image======null");
      return null;
    }
    print("Image Picked ______ "+image.path.toString());
    image1 = File(image.path);

    classifyImage(image1!);
  }
  static classifyImage(File image) async {
    print("In classify Image:|"+image.path.toString());
    var output = await Tflite.runModelOnImage(
      path: image.path,
      imageMean: 127.5,
      imageStd: 127.5,
      numResults: 6,
      threshold: 0.05,
    );
    outputs = output;
    print("Outputs="+outputs.toString());

    // var diseaseName = _outputs![0]["label"];
  }


  static Future<void> getGallery()async{
    var filePath = await getExternalStorageDirectory();
    try{
      print('taking images');
         await FilePicker.platform.pickFiles(allowMultiple: true,type:FileType.custom,allowedExtensions: ['jpg','png','jpeg']).then((value)async {
           for(var file in value!.files){
             var b = await File(file.path!).readAsBytes();
             images.add(b);
             print(images);
             filepaths.add(file.path);
             print("added image");
           }
        });

        // await ImagePicker().pickImage(source: ImageSource.camera).then((value)async {
        //   print("tool image");
        //   var b = await value!.readAsBytes();
        //   images.add(b);
        //   // await File(filePath.toString()+"/i/${images.length}image.png").create(recursive: true).then((value)async{
        //   //   await value.writeAsBytes(b).then((value) {
        //   //             filepaths.add(filePath.toString()+"/i/${images.length}image.png");
        //   //           print("file added");
        //   //           });
        //   // });
          
        // });
    }catch(e){
      print(e.toString());
    }
  }
  static Future<dynamic> getData() async {

    var x = await getSuggestions(images[1]);
    // var x;
    // x['disease'] = outputs![0]["label"];
    // x['plant'] = "Plant Name";
    // x['remedy'] = "Default Remedy";
    // x['recommendations'] = "Default Recommendations";
    return x;
  }
  static getFilePaths(){
    return filepaths;
  }
}
