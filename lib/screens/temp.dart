import 'package:flutter/material.dart';
import 'package:hashd/model/getDatabase.dart';
import 'package:hashd/model/maps.dart';
import 'package:hashd/screens/home.dart';
import '../model/language.dart';
import 'help.dart';
class TempPage extends StatelessWidget {
  const TempPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    

    
    return Scaffold(
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
                      // translate();
                      // setState(() {});
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
                        LanguageML.speechOutput('data', 'to_lang');
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
      appBar: AppBar(
        centerTitle: true,
        title: Text("For IMSH"),
      ),
        body: DatabaseData.notif(context)
    );
  }
}
