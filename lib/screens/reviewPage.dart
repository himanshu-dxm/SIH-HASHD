// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:hashd/model/language.dart';
import 'package:hashd/model/pdf_format.dart';
import 'package:hashd/services/Predic.dart';
import 'package:hashd/widgets/common_styles.dart';
import 'package:intl/intl.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({Key? key}) : super(key: key);

  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  bool isLoading = false;
  late Predictions preds;
  late String cropName;
  late String diseaseDetected;
  late String remedy;

  @override
  void initState() {
    super.initState();
    preds = Prediction.preds;
    cropName = preds.plantName;
    diseaseDetected = preds.disease;
    remedy = preds.remedy;
  }

  void translate() async {
    var a = await LanguageML.convertLanguage('hindi', remedy);
    var b = await LanguageML.convertLanguage('hindi', cropName);
    var c = await LanguageML.convertLanguage('hindi', diseaseDetected);
    setState(() {
      remedy = a;
      cropName = b;
      diseaseDetected = c;
    });
  }

  void speakUp() {
    LanguageML.speechOutput(remedy, 'hi');
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: () {
              // TODO: Translate
              translate();
              setState(() {});
            },
            child: Container(
              padding: EdgeInsets.all(8),
                child: Icon(Icons.translate),
            ),
          ),

          GestureDetector(
            onTap: () {
              speakUp();
            },
              child: Container(
                padding: EdgeInsets.all(8),
                  child: Icon(Icons.keyboard_voice)
              )
          ),
        ],
        backgroundColor: Color(0xff587308),
        centerTitle: true,
        title: Text(
          "H",
          style: TextStyle(
              fontSize: 40
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
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
                  child: MyListView(cropName: cropName,diseaseDetected: diseaseDetected,remedy: remedy,),
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
  late String remedy;
  MyListView({required String cropName,required String diseaseDetected,required String remedy}) {
    this.remedy = remedy;
    this.cropName = cropName;
    this.diseaseDetected = diseaseDetected;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // Image Container
        Container(
          margin:EdgeInsets.all(8),
          child: Image.asset(
            "assets/images/download.jpg",
          ),
        ),

        // Disease Container
        Container(
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
          height: MediaQuery.of(context).size.height*0.20,
          margin: EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // mainAxisSize: MainAxisSize.max,
            children: [
              ListTile(
                // leading: Icon(Icons.album),
                title: Text(
                  "Crop: "+cropName+
                      "\nDisease Detected: "+diseaseDetected,
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold
                  ),
                ),
                // subtitle: Text(
                //   "Disease Detected: "+preds.disease,
                //   style: TextStyle(
                //     fontSize: 20,
                //     fontWeight: FontWeight.w600,
                //   ),
                // ),
              ),
            ],
          ),
        ),

        // // Predictions
        Container(
          height: 350,

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
              child: Text(
                  "Solution: "+remedy,
                style: TextStyle(
                  fontSize: 18
                ),
              ),
            ),
          ),
        ),

        // Contact Expert
        CommonStyles.roundButton(context, "Contact Expert"),
      ],
    );
  }
}


