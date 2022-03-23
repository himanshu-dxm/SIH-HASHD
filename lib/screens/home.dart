import 'package:flutter/material.dart';
import 'package:hashd/model/capturePics.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    bool isLoading = false;
    return !isLoading?Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("SIH HASHD"),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height*0.8,
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
        ),
      ),
    ):Center(child: CircularProgressIndicator());
  }
}