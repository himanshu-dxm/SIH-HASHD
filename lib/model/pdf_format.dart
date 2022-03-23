// import 'package:flutter/cupertino.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
// import 'package:image_picker/image_picker.dart';

class Title{
  final String title;
  const Title({
    required this.title,
  });
}

class Details{
  final String soil;
  final String rainAvg;
  final String crop;
  final int noOfCases;
  final String location;
  final int noOfImages;
  const Details({
    required this.soil,
    required this.rainAvg,
    required this.crop,
    required this.noOfCases,
    required this.location,
    required this.noOfImages
  });
}
class Id{
  final String id;
  final String time;
  const Id({
    required this.id,
    required this.time
  });
}
class ImagesUpload{
//   meth()async{
// var img = await ImagePicker().pickImage(source: ImageSource.camera);
// var bytes = img?.readAsBytes();
//   }
  final List<dynamic> images;
  const ImagesUpload({
    required this.images,
  });
}
class Report{
  static Widget buildTitle(Title title){
    return Container(
      alignment:Alignment.center,
      child: Text(title.toString()+" REPORT",style: TextStyle(fontBold: Font.timesBold())),
    );
  }
  static Widget buildID(Title title,Id id){
    return Container(
      child: Column(children: [
        Text(title.toString()+" ID"+id.id.toString()),
        Text("Date: "+id.time.toString())
      ])
    );
  }
  static Widget buildDetails(Details details){
    return Container(
      child: Column(children: [
        Text("CROP : "+details.crop),
        Text("SOIL : "+details.soil),
        Text("AVERAGE RAINFALL(mm) : "+details.rainAvg),
        Text("LOCATION : "+details.location),
        Text("NUMBER OF CASES REPORTED IN THAT LOCATION : "+details.noOfCases.toString()),
        Text("NUMBER OF IMAGES ATTACHED : "+details.noOfImages.toString()),
      ]),
    );
  }

}
