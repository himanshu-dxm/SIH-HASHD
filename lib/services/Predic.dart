import 'package:hashd/model/capturePics.dart';
import 'package:hashd/model/create_pdf.dart';
import 'package:hashd/model/databaseStorage.dart';
import 'package:hashd/model/pdf_format.dart';
import 'package:hashd/model/storageModels.dart';
import 'package:hashd/model/weather_data.dart';

class Prediction {
  static void getPredictions() async {
    //get predictions and pass "pred" to next page
    var RID = DateTime.now().toString();
    print("RId"+RID);
    var images = await CapturePicture.getImages();
    var filepaths = CapturePicture.getFilePaths();
    var predictions =await CapturePicture.getData();
    // var soildata = await APIDATA.getSoildata();
    Predictions pred = Predictions(disease: predictions.disease, plantName: predictions.name, remedy: predictions.remedy,recommendations:"soildata.recommendations");
    //Details
    Details details = Details(soil: "soildata.soil", humidity: WeatherData.weather.humidity.toString(), crop: predictions.name, no_of_cases: 1, location: WeatherData.weather.city, no_of_images: images.length);
    //store images to database
    var urls = await Database.pushImages(filepaths, RID);
    var EID = await Database.getExpert(predictions.name);
    String no_of_cases = '0';
    ReportFormat report = ReportFormat(UID: 'UID', EID: EID, crop: details.crop, humidity: details.humidity, location: details.location, lock: '0', no_of_cases: no_of_cases, no_of_images: details.no_of_images.toString(), soil: details.soil);
    Database.pushdata(RID, report, urls);
    //generate pdf
    generatePDF(PDFTitle(title: 'Request'),Id(id:RID,time:DateTime.now().toString()) , details, images, pred);
    //clear images
    // CapturePicture.images.clear();
    // CapturePicture.filepaths.clear();
    // print('soildata: '+soildata.toString());
    print('pred'+pred.toString());
    print("report"+report.toString());

  }
}