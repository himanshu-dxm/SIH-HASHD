import 'dart:async';

import 'package:hashd/model/capturePics.dart';
import 'package:hashd/model/create_pdf.dart';
import 'package:hashd/model/databaseStorage.dart';
import 'package:hashd/model/pdf_format.dart';
import 'package:hashd/model/storageModels.dart';
import 'package:hashd/model/weather_data.dart';

class Prediction {
  static void getPredictions() async {
    //get predictions and pass "pred" to next page
    var RID = DateTime.now().millisecondsSinceEpoch.toString();
    print("RId"+RID);
    var filepaths = CapturePicture.getFilePaths();
    print(filepaths);
    var predictions =await CapturePicture.getData();
    print((predictions).toString());
    // var soildata = await APIDATA.getSoildata();
    Predictions pred = Predictions(disease: predictions['disease'], plantName: predictions['plant'], remedy: predictions['remedy'],recommendations:"soildata.recommendations");
    // //Details
    Details details = Details(soil: "soildata.soil", humidity: WeatherData.weather.humidity.toString(), crop: predictions['plant'], no_of_cases: 1, location: WeatherData.weather.city, no_of_images: CapturePicture.images.length);
    // //store images to database
    var EID = await Database.getExpert(predictions['plant'].toString());
    print(EID);
    String no_of_cases = '0';//TODO
    ReportFormat report = ReportFormat(UID: 'UID', EID: EID, crop: details.crop, humidity: details.humidity, location: details.location, lock: '0', no_of_cases: no_of_cases, no_of_images: details.no_of_images.toString(), soil: details.soil);
    var urls = await Database.pushImages(RID);
    Database.pushdata(RID, report, urls);
    //generate pdf
    generatePDF(PDFTitle(title: 'Request'),Id(id:RID,time:DateTime.now().toString()) , details, CapturePicture.images, pred);
    //clear images
    CapturePicture.images.clear();
    CapturePicture.filepaths.clear();
    // print('soildata: '+soildata.toString());
    print('pred'+pred.toString());
    print("report"+report.toString());

  }
}