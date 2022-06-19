
import 'dart:io';
import 'dart:typed_data';
import 'package:image/image.dart' as img;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class TempPage extends StatefulWidget {
  const TempPage({Key? key}) : super(key: key);

  @override
  State<TempPage> createState() => _TempPageState();
}

class _TempPageState extends State<TempPage> {
  List? _outputs;
  File? _image;
  bool _loading = false;
  double _imageHeight=10.0,_imageWidth=10.0;
  // List<CameraDescription>? cameras;
  @override
  void initState() {
    super.initState();
    _loading = true;
    loadModel().then((value) {
      setState(() {
        _loading = false;
      });
    });
  }

  void dispose() {
    Tflite.close();
    super.dispose();
    print("Model disposed");
  }

  String output = '';


  selectImagePicker() async {
    var image = await ImagePicker().pickImage(source: ImageSource.camera);
    if(image==null) return null;
    setState(() {

    });
    print("Image Getting Predicted -------");
    predictImage(image);
  }

  Future predictImage(image) async {
    if(image==null) return;
    // await classifyImage(image);
    new FileImage(image)
        .resolve(ImageConfiguration())
        .addListener((ImageStreamListener((ImageInfo info,bool _) {
          setState(() {
            _imageHeight = info.image.height.toDouble();
            _imageWidth = info.image.width.toDouble();
          });
    })));
    setState(() {
      _image = image;
      _loading = false;
    });
  }

  pickImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(image==null) {
      print("Image======null");
      return null;
    }
    print("Image Picked ______ "+image.path.toString());
    setState(() {
      _loading = true;
      _image = File(image.path);
    });
    classifyImage(_image!);
  }
  model(File image) {

  }

  loadModel() async {
    Tflite.close();
    try {
      String? res = await Tflite.loadModel(
          model: 'assets/model/model.tflite',
          labels: 'assets/model/labels.txt'
      );
      print(res);
    } on PlatformException {
      print("Cannot Load Model");
    }
    print("Model Loaded");
  }
  classifyImage(File image) async {
    print("In classify Image");
    var imageBytes = (await rootBundle.load(image.path)).buffer;
    img.Image oriImage = img.decodeJpg(imageBytes.asUint8List())!;
    img.Image resizedImage = img.copyResize(oriImage,height: 256,width: 256);
    // var output = await Tflite.runModelOnImage(
    //   path: image.path,
    //   imageMean: 127.5,
    //   imageStd: 127.5,
    //   numResults: 38,
    //   threshold: 0.5,
    //   asynch: true
    // );

    var output = await Tflite.runModelOnBinary(
      binary: imageToByteListFloat32(resizedImage,256,127.5,127.5),
      numResults: 38,
      threshold: 0.1,
      asynch: true
    );
    
    setState(() {
      _loading = false;
      _outputs = output;
    });
  }
  Uint8List imageToByteListFloat32(
      img.Image image,
      int inputSize,
      double mean,
      double std
      ) {
    var convertedBytes = Float32List(1*inputSize*inputSize*3);
    var buffer = Float32List.view(convertedBytes.buffer);
    int pixelIndex = 0;
    for(var i=0;i<inputSize ;i++) {
      for(var j=0;j<inputSize;j++) {
        var pixel = image.getPixel(j,i);
        buffer[pixelIndex++] = (img.getRed(pixel)-mean)/std;
        buffer[pixelIndex++] = (img.getGreen(pixel)-mean)/std;
        buffer[pixelIndex++] = (img.getBlue(pixel)-mean)/std;
      }
    }
    return convertedBytes.buffer.asUint8List();
  }
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // endDrawer: Drawer(
      //   elevation: 16,
      //   child: Container(
      //     child: ListView(
      //       padding: EdgeInsets.zero,
      //       children: [
      //         DrawerHeader(
      //           decoration: BoxDecoration(
      //             color: Color(0xff587308),
      //           ),
      //           child: Container(
      //             child: Row(
      //               mainAxisAlignment: MainAxisAlignment.start,
      //               children: [
      //                 Container(
      //                     // alignment: Alignment.topLeft,
      //                     child: InkWell(
      //                         onTap: (){
      //                           Navigator.pop(context);
      //                         },
      //                         child: Icon(Icons.close,size: 40,)
      //                     )
      //                 ),
      //                 Container(
      //                   child: Text(
      //                     "APP Name",
      //                     style: TextStyle(
      //                       fontSize: 25
      //                     ),
      //                   ),
      //                 ),
      //               ],
      //             ),
      //           )
      //         ),
      //         Column(
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: [
      //             SizedBox(height: 50,),
      //             GestureDetector(
      //               onTap: () {
      //                 // TODO: Translate
      //                 // translate();
      //                 // setState(() {});
      //               },
      //               child: Container(
      //                 padding: EdgeInsets.all(8),
      //                 child: Row(
      //                   mainAxisAlignment: MainAxisAlignment.start,
      //                   children: [
      //                     Icon(Icons.translate,size: 48,),
      //                     SizedBox(width: 8,),
      //                     Text("Translate",style: TextStyle(
      //                       fontSize: 24
      //                     ),),
      //                   ],
      //                 ),
      //               ),
      //             ),
      //             SizedBox(height: 24,),
      //             GestureDetector(
      //                 onTap: () {
      //                   LanguageML.speechOutput('data', 'to_lang');
      //                 },
      //                 child: Container(
      //                   padding: EdgeInsets.all(8),
      //                   child: Row(
      //                     mainAxisAlignment: MainAxisAlignment.start,
      //                     children: [
      //                       Icon(Icons.mic,size: 48,),
      //                       SizedBox(width: 8,),
      //                       Text("Audio Assist",style: TextStyle(
      //                           fontSize: 24
      //                       ),),
      //                     ],
      //                   ),
      //                 ),
      //             ),
      //             SizedBox(height: 24,),
      //             GestureDetector(
      //               onTap: () async {
      //                 print("Shop Tapped");
      //                 WebView.openMap("fertilizers");
      //               },
      //               child: Container(
      //                 padding: EdgeInsets.all(8),
      //                 child: Row(
      //                   mainAxisAlignment: MainAxisAlignment.start,
      //                   children: [
      //                     Icon(Icons.shopping_cart,size: 48,),
      //                     SizedBox(width: 8,),
      //                     Text("Open Stores",style: TextStyle(
      //                         fontSize: 24
      //                     ),),
      //                   ],
      //                 ),
      //               ),
      //             ),
      //             SizedBox(height: 24,),
      //             GestureDetector(
      //               onTap: () async {
      //                 // TODO: Help page redirect
      //               },
      //               child: Container(
      //                 padding: EdgeInsets.all(8),
      //                 child: Row(
      //                   mainAxisAlignment: MainAxisAlignment.start,
      //                   children: [
      //                     Icon(Icons.help_outline_outlined,size: 48,),
      //                     SizedBox(width: 8,),
      //                     Text("Govt. Aids",style: TextStyle(
      //                         fontSize: 24
      //                     ),),
      //                   ],
      //                 ),
      //               ),
      //             ),
      //           ],
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
      appBar: AppBar(
        centerTitle: true,
        title: Text("For Trial Usage"),
      ),
        // body: DatabaseData.notif(context)
        body: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _loading ? Container(
                height: 300 ,
                width: 300,
              ):Container(
                margin: EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _image==null ? Container() :Image.file(_image!),
                    SizedBox(
                      height: 20,
                    ),
                    _image == null ? Container() : _outputs != null ?
                        Text(_outputs![0]["label"],
                        style: TextStyle(
                          color: Colors.black,
                            fontSize: 20
                          ),
                        ) : Container(
                      child: Text(""),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                    FloatingActionButton(
                      onPressed: pickImage,
                      tooltip: "Pick Image",
                      child: Icon(Icons.camera,
                      size: 20,
                      color: Colors.white,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        )
    );
  }
}
