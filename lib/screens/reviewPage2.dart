// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:hashd/model/language.dart';
import 'package:hashd/model/maps.dart';
import 'package:hashd/model/pdf_format.dart';
import 'package:hashd/services/Predic.dart';
import 'package:hashd/widgets/common_styles.dart';
import 'package:intl/intl.dart';

class ReviewPage2 extends StatefulWidget {
  var doc;
  ReviewPage2(doc) {
    this.doc = doc;
  }

  @override
  _ReviewPage2State createState() => _ReviewPage2State();
}

class _ReviewPage2State extends State<ReviewPage2> {
  bool isLoading = false;
  late Predictions preds;
  late String cropName;
  late String diseaseDetected;
  // late String prediction;
  late String message;
  late String products;
  late String links;

  @override
  void initState() {
    super.initState();
    cropName = widget.doc['crop'];
    diseaseDetected = widget.doc['disease'];
    // prediction = widget.doc['prediction'];
    message = widget.doc['message'];
    products = widget.doc['products'];
    links = widget.doc['links'];
  }

  void translate() async {
    var a = await LanguageML.convertLanguage('hindi', message);
    var b = await LanguageML.convertLanguage('hindi', cropName);
    var c = await LanguageML.convertLanguage('hindi', diseaseDetected);
    setState(() {
      message = a;
      cropName = b;
      diseaseDetected = c;
    });
  }

  void speakUp() {
    LanguageML.speechOutput(message, 'hindi');
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        leading: GestureDetector(
          child: Icon(Icons.arrow_back_ios),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Color(0xff587308),
        centerTitle: true,
        title: Text(
          "H",
          style: TextStyle(
              fontSize: 40
          ),
        ),
      ),
      endDrawer: Drawer(
        elevation: 16,
        child: Container(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                  decoration: BoxDecoration(
                    color: Color(0xff587308),
                  ),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          // alignment: Alignment.topLeft,
                            child: InkWell(
                                onTap: (){
                                  Navigator.pop(context);
                                },
                                child: Icon(Icons.close,size: 40,)
                            )
                        ),
                        Container(
                          child: Text(
                            "APP Name",
                            style: TextStyle(
                                fontSize: 25
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 50,),
                  GestureDetector(
                    onTap: () {
                      // TODO: Translate
                      translate();
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.translate,size: 48,),
                          SizedBox(width: 8,),
                          Text("Translate",style: TextStyle(
                              fontSize: 24
                          ),),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 24,),
                  GestureDetector(
                    onTap: () {
                      speakUp();
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.mic,size: 48,),
                          SizedBox(width: 8,),
                          Text("Audio Assist",style: TextStyle(
                              fontSize: 24
                          ),),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 24,),
                  GestureDetector(
                    onTap: () async {
                      print("Shop Tapped");
                      WebView.openMap("fertilizers");
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.shopping_cart,size: 48,),
                          SizedBox(width: 8,),
                          Text("Open Stores",style: TextStyle(
                              fontSize: 24
                          ),),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 24,),
                  GestureDetector(
                    onTap: () async {
                      // TODO: Help page redirect
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.help_outline_outlined,size: 48,),
                          SizedBox(width: 8,),
                          Text("Govt. Aids",style: TextStyle(
                              fontSize: 24
                          ),),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height*0.9,
          child: Stack(
              children: [

                // Background Image
                Image.network(
                  "https://farmer.gov.in/imagedefault/containerbg.jpg",
                  width: double.infinity,
                  height: double.infinity,
                  repeat: ImageRepeat.repeat,
                ),

                Container(
                  padding: EdgeInsets.all(8),
                  margin: EdgeInsets.all(8),
                  // height: MediaQuery.of(context).size.height,
                  child: MyListView(
                    cropName: cropName,
                    diseaseDetected: diseaseDetected,
                    // prediction: ,
                    message: message,
                    links: links,
                    products: products,
                  ),
                ),
              ]
          ),
        ),
      ),
    );
  }
}


class MyListView extends StatelessWidget {
  late String cropName;
  late String diseaseDetected;
  // late String prediction;
  late String message;
  late String products;
  late String links;
  late List<String> predictionList;
  late List<String> messageList;
  late List<String> productsList;
  late List<String> linksList;
  MyListView({required String cropName,
    required String diseaseDetected,
    // required String prediction,
    required String message,
    required String products,
    required String links
  }) {
    // this.prediction = prediction;
    this.cropName = cropName;
    this.diseaseDetected = diseaseDetected;
    this.message = message;
    this.products = products;
    this.links = links;
    // predictionList = prediction.split(".");
    messageList = message.split(".");
    productsList = products.split(".");
    linksList = links.split(".");
    print("Message List:"+messageList.toString());
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        // Image Container
        Container(
          margin:EdgeInsets.all(8),
          child: Image.asset(
            "assets/images/download.jpg",
          ),
        ),

        // Disease Container
        // Container(
        //   decoration: BoxDecoration(
        //       color: Color(0xffb7c881),
        //       borderRadius: BorderRadius.circular(40),
        //       border: Border.all(color: Colors.white),
        //       boxShadow: [
        //         BoxShadow(
        //           color: Colors.grey.withOpacity(0.8),
        //           spreadRadius: 5,
        //           blurRadius: 7,
        //           offset: Offset(0,3),
        //         )
        //       ]
        //   ),
        //   height: MediaQuery.of(context).size.height*0.10,
        //   margin: EdgeInsets.all(8),
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //     // mainAxisSize: MainAxisSize.max,
        //     children: [
        //       ListTile(
        //         // leading: Icon(Icons.album),
        //         title: Text(
        //           "Crop: "+cropName+
        //               "\nDisease Detected: "+diseaseDetected,
        //           style: TextStyle(
        //               fontSize: 24,
        //               fontWeight: FontWeight.bold
        //           ),
        //         ),
        //         // subtitle: Text(
        //         //   "Disease Detected: "+preds.disease,
        //         //   style: TextStyle(
        //         //     fontSize: 20,
        //         //     fontWeight: FontWeight.w600,
        //         //   ),
        //         // ),
        //       ),
        //     ],
        //   ),
        // ),

        Container(
          // height: 350,

          margin: EdgeInsets.all(8),
          child: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                  color: Color(0xffb7c881),
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
              padding: EdgeInsets.all(8),
              // child: Text(
              //   "Solution :"+prediction,
              //   style: TextStyle(
              //     fontSize: 18,
              //   ),
              // ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      "Crop: "+cropName+
                          "\nDisease Detected: "+diseaseDetected,
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    // StringList(messageList),
                  ],
                ),
                physics: ScrollPhysics(),
              ),
            ),
          ),
        ),

        // Predictions
        // Container(
        //   height: 350,
        //
        //   margin: EdgeInsets.all(8),
        //   child: SingleChildScrollView(
        //     child: Container(
        //       decoration: BoxDecoration(
        //           color: Color(0xffb7c881),
        //           borderRadius: BorderRadius.circular(40),
        //           border: Border.all(color: Colors.white),
        //           boxShadow: [
        //             BoxShadow(
        //               color: Colors.grey.withOpacity(0.8),
        //               spreadRadius: 5,
        //               blurRadius: 7,
        //               offset: Offset(0,3),
        //             )
        //           ]
        //       ),
        //       padding: EdgeInsets.all(8),
        //       // child: Text(
        //       //   "Solution :"+prediction,
        //       //   style: TextStyle(
        //       //     fontSize: 18,
        //       //   ),
        //       // ),
        //       child: SingleChildScrollView(
        //         child: Column(
        //           children: [
        //             Text(
        //               "Solution : ",
        //               style: TextStyle(
        //                   fontSize: 24,
        //                   fontWeight: FontWeight.bold
        //               ),
        //             ),
        //             StringList(predictionList.isEmpty?['No Suggestions']:predictionList),
        //           ],
        //         ),
        //         physics: ScrollPhysics(),
        //       ),
        //     ),
        //   ),
        // ),

        // Message
        Container(
          // height: 350,

          margin: EdgeInsets.all(8),
          child: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                  color: Color(0xffb7c881),
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
              padding: EdgeInsets.all(8),
              // child: Text(
              //   "Solution :"+prediction,
              //   style: TextStyle(
              //     fontSize: 18,
              //   ),
              // ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      "Message : ",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    StringList(messageList),
                  ],
                ),
                physics: ScrollPhysics(),
              ),
            ),
          ),
        ),

        //Products
        Container(
          // height: 350,

          margin: EdgeInsets.all(8),
          child: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                  color: Color(0xffb7c881),
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
              padding: EdgeInsets.all(8),
              // child: Text(
              //   "Solution :"+prediction,
              //   style: TextStyle(
              //     fontSize: 18,
              //   ),
              // ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      "Products : ",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    StringList(productsList.isEmpty?['No Products Mentioned']:productsList),
                  ],
                ),
                physics: ScrollPhysics(),
              ),
            ),
          ),
        ),

        // Links
        Container(
          // height: 350,

          margin: EdgeInsets.all(8),
          child: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                  color: Color(0xffb7c881),
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
              padding: EdgeInsets.all(8),
              // child: Text(
              //   "Solution :"+prediction,
              //   style: TextStyle(
              //     fontSize: 18,
              //   ),
              // ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      "Links : ",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    StringList(linksList),
                  ],
                ),
                physics: ScrollPhysics(),
              ),
            ),
          ),
        ),


        // Contact Expert
        Container(
          padding: EdgeInsets.all(8),
          child: CommonStyles.roundButton(context, "Contact Expert!"),
        )

      ],
    );
  }
}

class StringList extends StatelessWidget {

  late List<String> predictionList;
  StringList(List<String> predictionList) {
    this.predictionList = predictionList;
    print(this.predictionList);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context,index) {
        return Container(
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.all(8),
            child: Text(
              "* "+predictionList[index],
              style: TextStyle(
                  fontSize: 18
              ),
            )
        );
      },
      itemCount: predictionList.length,
    );
  }
}



