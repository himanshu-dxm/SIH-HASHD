import 'package:flutter/material.dart';
import 'package:hashd/model/language.dart';
import 'package:hashd/model/pdf_format.dart';
import 'package:hashd/services/Predic.dart';
import 'package:hashd/widgets/common_styles.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({Key? key}) : super(key: key);

  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  bool isLoading = false;
  late Predictions preds;

  @override
  void initState() {
    super.initState();
    preds = Prediction.preds;
  }

  @override
  Widget build(BuildContext context) {
    var remedy = preds.remedy;
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: () async{
              // TODO: Translate
              var ans = await LanguageML.convertLanguage('hindi', preds.remedy);
              setState(() {
                remedy=ans;
              });
            },
            child: Container(
                child: Icon(Icons.translate),
            ),
          ),

          GestureDetector(
            onTap: () {

            },
              child: Container(
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
                  child: MyListView(preds: preds),
              ),
            ]
          ),
        ),
      ),
    );
  }
}

class MyListView extends StatelessWidget {
  late Predictions preds;
  MyListView({required Predictions preds}) {
    this.preds = preds;
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
                  "Crop: "+preds.plantName+
                      "\nDisease Detected: "+preds.disease,
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
                  "Solution: "+preds.remedy,
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


