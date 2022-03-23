import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("SIH HASHD"),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height*0.8,
          alignment: Alignment.bottomCenter,
          child: FloatingActionButton.extended(
            onPressed: () {
              print("Button Pressesd");
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
    );
  }
}
