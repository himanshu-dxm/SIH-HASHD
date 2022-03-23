import 'dart:ui';
import '../model/create_pdf.dart';
import '../model/pdf_format.dart';
import '../model/capturePics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hashd/widgets/common_styles.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool otpSent = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   // title: Center(child: Text("HI")),
      // ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        alignment: Alignment.bottomCenter,
        child: Stack(
          children: [
            Image.asset(
              "assets/images/home_page_bg.jpg",
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
            ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 2,
                    sigmaY :2
                ),
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Form(
                        child: Column(
                          children: [
                            Text(
                              "SIH-HASHD",
                              style: TextStyle(
                                color: Colors.white
                              ),
                            ),
                            SizedBox(height: 35,),
                            TextFormField(
                              style: TextStyle(
                                color: Colors.white
                              ),
                              maxLength: 16,
                              keyboardType: TextInputType.text,
                              decoration: CommonStyles.textFieldStyle("Enter Name"),
                            ),
                            SizedBox(height: 15,),
                            TextFormField(
                              style: TextStyle(
                                  color: Colors.white
                              ),
                              maxLength: 16,
                              keyboardType: TextInputType.number,
                              decoration: CommonStyles.textFieldStyle("Enter Aadhaar Number"),
                            ),
                            SizedBox(height: 15,),
                            TextFormField(
                              style: TextStyle(
                                  color: Colors.white
                              ),
                              maxLength: 10,
                              keyboardType: TextInputType.number,
                              decoration: CommonStyles.textFieldStyle("Enter Phone Number"),
                            ),
                            SizedBox(height: 20,),
                            otpSent?TextFormField(
                              style: TextStyle(
                                color: Colors.white
                              ),
                              maxLength: 6,
                              keyboardType: TextInputType.number,
                              decoration: CommonStyles.textFieldStyle("Enter OTP"),
                            ):
                            GestureDetector(
                              onTap: () async{
                                setState(() {
                                  otpSent = true;
                                });
                                
                                // //add my stuff
                                // var images = await CapturePicture.getImages();
                                // var ans = await CapturePicture.getData();
                                // generatePDF(PDFTitle(title: "he"), Id(id: '123',time:DateTime.now().toString()), Details(crop: "CROP",soil: "SOIL",rain_avg: "RAIN AVG",no_of_cases: 2,no_of_images: 2,location: "LOCATION"), images);
                              },
                              child: Container(
                                child: CommonStyles.roundButton(context, "Send OTP"),
                              ),
                            ),
                            SizedBox(height: 20,),
                            otpSent?GestureDetector(
                              onTap: () {
                                setState(() {
                                  otpSent=false;
                                });
                              },
                              child: Container(
                                child: CommonStyles.roundButton(context, "Submit"),
                              ),
                            ):Container()
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}
