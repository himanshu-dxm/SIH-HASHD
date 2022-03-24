import 'package:flutter/material.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({Key? key}) : super(key: key);

  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
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
                              children: [],
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
                        ),
                      ),
                    ],
                  ),
                ):Container(child: Center(child: CircularProgressIndicator()))),
          ],
        ),
      ),
    );
  }
}
