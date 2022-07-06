import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hashd/model/capturePics.dart';
import 'package:hashd/model/getDatabase.dart';
import 'package:hashd/screens/reviewPage.dart';
import 'package:hashd/screens/temp.dart';
import 'package:hashd/services/Predic.dart';
import 'package:hashd/widgets/weatherInfoView.dart';
import 'package:tflite/tflite.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isDeleted = false;
  int numImages = 0;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    isLoading = true;
    loadModel().then((value) {
      setState(() {
        isLoading = false;
      });
    });
  }

  loadModel() async {
    Tflite.close();
    try {
      String? res = await Tflite.loadModel(
        model: 'assets/model/trial_model1.tflite',
        // model: 'assets/model/model.tflite',
        labels: 'assets/model/labels.txt',
      );
      print(res);
    } on PlatformException {
      print("Cannot Load Model");
    }
    print("Model Loaded");
  }

  void dispose() {
    Tflite.close();
    super.dispose();
    print("Model disposed");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff587308),
        centerTitle: true,
        leading: Icon(Icons.arrow_right_sharp,size: 32,),
        title: TextButton(
          onPressed: (){
            Navigator.push(context,MaterialPageRoute(builder: (ctx)=>TempPage()));
          },
            child:Text("Kisan Seva",style: TextStyle(fontSize: 24),),
        ),
      ),
      body: Container(
        child: Stack(
          children: [
            Image.network(
              "https://farmer.gov.in/imagedefault/containerbg.jpg",
              width: double.infinity,
              height: double.infinity,
              repeat: ImageRepeat.repeat,
            ),
            Container(
              child: !isLoading?Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Top Notifications
                  Container(
                    child: Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            WeatherInfoView(),
                            !isDeleted?DatabaseData.notif(context):Container(),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Bottom buttons
                  Container(
                    height: MediaQuery.of(context).size.height*0.12,
                    child: Container(
                      margin: EdgeInsets.only(bottom: 16),
                        width: MediaQuery.of(context).size.width,
                        child: (numImages==0)?Container(
                        // height: MediaQuery.of(context).size.height*0.85,
                          alignment: Alignment.bottomCenter,
                          child: FloatingActionButton.extended(
                            backgroundColor: Color(0xff587308),
                          onPressed: () async {
                            print("Button Pressed");
                            setState(() {
                              isLoading = true;
                            });
                            var img=await CapturePicture.pickImageCamera();
                            setState(() {
                              isLoading = false;
                              numImages = CapturePicture.images.length;
                            });
                          },
                            label: const Text(
                              "CAPTURE"
                            ),
                          icon: const Icon(
                            Icons.camera_alt_outlined
                          ),
                          // backgroundColor: Colors.green,
                        ),
                      ):Container(
                        height: MediaQuery.of(context).size.height,
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              child: FloatingActionButton.extended(
                                backgroundColor: Color(0xff587308),
                                  onPressed: () async {
                                    print("Add Button Pressed");
                                    setState(() {
                                      isLoading = true;
                                    });
                                    var img=await CapturePicture.pickImageGallery();
                                    setState(() {
                                      isLoading = false;
                                      numImages = CapturePicture.images.length;
                                    });
                                  },
                                  label: Text(
                                    "Add ("+numImages.toString()+")"
                                  ),
                                icon: Icon(Icons.add),
                              ),
                            ),
                            Container(
                              child: FloatingActionButton.extended(
                                backgroundColor: Color(0xff587308),
                                  onPressed: () async {

                                    setState(() {
                                      isLoading = true;
                                      numImages = 0;
                                    });
                                    // var s = await Prediction.getPredictions();
                                    var s = await Prediction.performPrediction();
                                    if(s==false){
                                      print('error in main pred');
                                      setState(() {
                                        isLoading = true;
                                      });
                                    }
                                    isDeleted = false;
                                    isLoading=false;
                                    setState(() {
                                      isLoading = false;
                                    });
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ReviewPage()));
                                    // Timer(const Duration(seconds: 5), (){});
                                    // Timer(const Duration(seconds: 10),(){
                                    //   isLoading=false;
                                    //   Navigator.push(context, MaterialPageRoute(builder: (context)=>ReviewPage()));
                                    // });
                                  },
                                  label: const Text(
                                    "Done"
                                  ),
                                icon: Icon(Icons.done),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ):Container(child: Center(child: CircularProgressIndicator()))),
          ],
        ),
      ));
  }
}