import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hashd/model/capturePics.dart';
import 'package:hashd/screens/reviewPage.dart';
import 'package:hashd/screens/temp.dart';
import 'package:hashd/services/Predic.dart';
import 'package:hashd/widgets/weatherInfoView.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff587308),
        centerTitle: true,
        title: Text(
            "H",
          style: TextStyle(
            fontSize: 40
          ),
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
                children: [
                  // Top Notifications
                  Container(
                    child: Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            // TODO: Weather info Page
                            WeatherInfoView(),
                            !isDeleted?Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(40),
                                  border: Border.all(color: Colors.white),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.8),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: Offset(0,3),
                                    )
                                  ]
                              ),
                              margin: EdgeInsets.all(8),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  // mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    ListTile(
                                      leading: Icon(Icons.notifications),
                                      title: Text(
                                        "Notification 1",
                                      ),
                                      subtitle: Text("Description"),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        TextButton(
                                          child: Text('Check Details'),
                                          onPressed: () {
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=>ReviewPage()));
                                          },
                                        ),
                                        const SizedBox(width: 8),
                                        TextButton(
                                          child: Text('Delete'),
                                          onPressed: () {
                                            setState(() {
                                              isDeleted = true;
                                            });
                                          },
                                        ),
                                        const SizedBox(width: 8),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ):Container(),
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
                            print("Button Pressesd");
                            setState(() {
                              isLoading = true;
                            });
                            var img=await CapturePicture.getImages();
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
                                    var img=await CapturePicture.getImages();
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
                                    Prediction.getPredictions();
                                    setState(() {
                                      isLoading = true;
                                      numImages = 0;
                                    });
                                    isDeleted = false;
                                    // Timer(const Duration(seconds: 5), (){});
                                    Timer(const Duration(seconds: 10),(){
                                      isLoading=false;
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ReviewPage()));
                                    });
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