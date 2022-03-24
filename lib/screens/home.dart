import 'package:flutter/material.dart';
import 'package:hashd/model/capturePics.dart';
import 'package:hashd/model/create_pdf.dart';
import 'package:hashd/model/getCity.dart';
import 'package:hashd/model/getSoilData.dart';
import 'package:hashd/model/pdf_format.dart';
import 'package:hashd/screens/reviewPage.dart';
import 'package:hashd/widgets/weatherInfoView.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isDeleted = false;
  int numImages = 0;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    bool isLoading = false;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
            "planet!",
          style: TextStyle(
            fontSize: 40
          ),
        ),
      ),
      body: !isLoading?Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Top Notifications
          Container(
            child: Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // TODO: Weather info Page
                    WeatherInfoView(),
                    !isDeleted?Container(
                      margin: EdgeInsets.all(8),
                      child: Center(
                        child: Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            // mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              ListTile(
                                leading: Icon(Icons.album),
                                title: Text(
                                  "Notification 1",
                                ),
                                subtitle: Text("Description"),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    child: Text('Check Details'),
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ReviewPage()));
                                    },
                                  ),
                                  const SizedBox(width: 8),
                                  TextButton(
                                    child: Text('Delete'),
                                    onPressed: () {
                                      setState(() {
                                        isDeleted = true;
                                      });
                                    },
                                  ),
                                  const SizedBox(width: 8),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ):Container(),
                  ],
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
                child: (numImages==0)?Container(
                // height: MediaQuery.of(context).size.height*0.85,
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
                height: MediaQuery.of(context).size.height,
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      child: FloatingActionButton.extended(
                          onPressed: () async {
                            print("Add Button Pressed");
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
                          label: Text(
                            "Add ("+numImages.toString()+")"
                          ),
                        icon: Icon(Icons.add),
                      ),
                    ),
                    Container(
                      child: FloatingActionButton.extended(
                          onPressed: () async {
                            setState(() {
                              numImages = 0;
                              isLoading = true;
                            });
                            print("Done Capturing");
                            //get predictions and pass "pred" to next page
                            var images = await CapturePicture.getImages();
                            var predictions =await CapturePicture.getData();
                            var soilData = await APIDATA.getSoildata();
                            Predictions pred = Predictions(disease: predictions.disease, plantName: predictions.name, remedy: predictions.remedy,recommendations:soilData.recommendations);
                            print(pred);
                            //Details
                            var city = await getCity();
                            // Details details = Details(soil: soilData.soil, rain_avg: rain_avg, crop: predictions.name, no_of_cases: no_of_cases, location: city, no_of_images: no_of_images)
                            //store images to database

                            //generate pdf
                            // generatePDF(title, id, details, images, pred);
                            //clear images
                            // CapturePicture.images.clear();
                            
                            setState(() {
                              isLoading = false;
                            });
                            isDeleted = false;
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
          ),
        ],
      ):Center(child: CircularProgressIndicator()));
  }
}