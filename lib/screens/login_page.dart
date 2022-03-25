import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hashd/model/sms.dart';
import 'package:hashd/screens/home.dart';
import 'package:hashd/screens/temp.dart';
import 'package:hashd/widgets/common_styles.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {


  bool otpSent = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff587308),
        title: Center(child: Text("SIH HASHED")),
        leading: GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>TempPage()));
          },
          child: Container(
            child: Image.asset(
                "assets/images/logo.jpeg",
              width: 100,
              height: 100,
            )
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
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
                              // Text(
                              //   "SIH-HASHD",
                              //   style: TextStyle(
                              //     color: Colors.white
                              //   ),
                              // ),
                              // SizedBox(height: 35,),
                              TextFormField(
                                style: TextStyle(
                                  color: Colors.white
                                ),
                                maxLength: 16,
                                keyboardType: TextInputType.text,
                                decoration: CommonStyles.textFieldStyle("Enter Name"),
                              ),
                              SizedBox(height: 5,),
                              TextFormField(
                                style: TextStyle(
                                    color: Colors.white
                                ),
                                maxLength: 16,
                                keyboardType: TextInputType.number,
                                decoration: CommonStyles.textFieldStyle("Enter Aadhaar Number"),
                              ),
                              SizedBox(height: 5,),
                              TextFormField(
                                style: TextStyle(
                                    color: Colors.white
                                ),
                                maxLength: 10,
                                keyboardType: TextInputType.number,
                                decoration: CommonStyles.textFieldStyle("Enter Phone Number"),
                              ),
                              SizedBox(height: 5,),
                              otpSent?TextFormField(
                                style: TextStyle(
                                  color: Colors.white
                                ),
                                maxLength: 6,
                                keyboardType: TextInputType.number,
                                // autofocus: true,
                                enabled: true,
                                decoration: CommonStyles.textFieldStyle("Enter OTP"),
                              ):
                              GestureDetector(
                                onTap: () async {
                                  SMS.sendMessage();
                                  setState(() {
                                    otpSent = true;
                                  });
                                },
                                child: Container(
                                  child: CommonStyles.roundButton(context, "Send OTP"),
                                ),
                              ),
                              SizedBox(height: 20,),
                              otpSent?GestureDetector(
                                onTap: () {
                                  //TODO : Change push to PushReplacement
                                  otpSent=false;
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
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
        ),
      )
    );
  }
}
