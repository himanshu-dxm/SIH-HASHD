import 'package:flutter/material.dart';
import 'package:hashd/model/capturePics.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int numImages = 0;
  @override
  Widget build(BuildContext context) {
    bool isLoading = false;
    return !isLoading?Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("SIH HASHD"),
      ),
      body: SingleChildScrollView(
        child: (numImages==0)?Container(
          height: MediaQuery.of(context).size.height*0.85,
          alignment: Alignment.bottomCenter,
          child: FloatingActionButton.extended(
            onPressed: () async {
              print("Button Pressesd");
              setState(() {
                isLoading = true;
              });
              var img=await CapturePicture.getImages();
              setState(() {
                isLoading = false;
                numImages = img.length;
              });
              print(img.length);
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
          height: MediaQuery.of(context).size.height*0.85,
          alignment: Alignment.bottomCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                child: FloatingActionButton.extended(
                    onPressed: () async {
                      print("Button Pressed");
                      setState(() {
                        isLoading = true;
                      });
                      var img=await CapturePicture.getImages();
                      setState(() {
                        isLoading = false;
                        numImages = img.length;
                      });
                      print(img.length);
                    },
                    label: const Text(
                      "Add "
                    ),
                  icon: Icon(Icons.add),
                ),
              ),
              Container(
                child: FloatingActionButton.extended(
                    onPressed: (){
                      setState(() {
                        numImages = 0;
                      });
                      CapturePicture.images.clear();
                      print("Done Capturing");
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
    ):Center(child: CircularProgressIndicator());
  }
}