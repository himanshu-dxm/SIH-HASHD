import 'dart:convert';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hashd/model/capturePics.dart';
import 'storageModels.dart';

class Database{
  static Future<String> getExpert(String crop)async{
     try {
       print(crop);
       await FirebaseFirestore.instance.collection('experts').where('crop',isEqualTo: crop.toLowerCase().toString()).get().then((value) {
        return(value.docs.first.get('EID'));
           });
           return 'no expert';
     } on Exception catch (e) {
       // TODO
       print('didnt get expert error');
       return(e.toString());
     }
    
  }
  static Future createUser(User user)async{
    await FirebaseFirestore.instance.collection('users').add({
      'UID':user.UID,
      'name':user.name,
      'phone':user.phone,
      'aadhar':user.aadhar
    });
}
  static Future pushdata(String RID,ReportFormat report,String urls)async{
    await FirebaseFirestore.instance.collection('reports').add({
      'RID':RID,
      'UID':report.UID,
      'EID':report.EID,
      'soil':report.soil,
      'crop':report.crop,
      'humidity':report.humidity,
      'location':report.location,
      'lock':report.lock,
      'no_of_cases':report.no_of_cases,
      'no_of_images':report.no_of_images,
      'imageUrls':urls
    });
    print("data pushed to db\n\n");
  }
  static Future<String> pushImages(String RID)async{
    try {
      var filepaths = CapturePicture.filepaths;
      List<String> urls=[];
      for (var i = 0;i<filepaths.length;i++) {
        var file = File(filepaths[i]);
         await FirebaseStorage.instance.ref().child(RID+'/'+i.toString()+'.jpg').putFile(file);
              urls.add(await FirebaseStorage.instance.ref().child(RID+'/'+i.toString()+'.jpg').getDownloadURL());
      }
      print("imags pushed\n\n");
      print(json.encode(urls));
      print('\n\n');
      return json.encode(urls);
    } on Exception catch (e) {
      // TODO
      print(e.toString());
      return '';
    }
  }
  // static Future<String> getNoOFCases()
  static Future<dynamic> getdatabaseData()async{
    List<Map<String,dynamic>> ans = [];
    await FirebaseFirestore.instance.collection('reports').get().then((value) {
      print("in dab");
      value.docs.forEach((element) {
        if(element['RID']=='1648141315319'){
          print("lock of "+element['RID']+" is "+element['lock']);
        }
        else{
          print(element['RID']+"  "+element['lock'].toString());
        }
        print(element.data());
        ans.add(element.data());
      });
      print(ans);
      return ans;
    });

  }
}