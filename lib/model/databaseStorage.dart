import 'dart:convert';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'storageModels.dart';

class Database{
  static Future<String> getExpert(String crop)async{
     try {
       await FirebaseFirestore.instance.collection('experts').where('crop',isEqualTo: crop.toLowerCase().toString()).get().then((value) {
        return(value.docs.first.get('EID'));
           });
           return '';
     } on Exception catch (e) {
       // TODO
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
  static Future<String> pushImages(List<String>filepaths,String RID)async{
    List<String> urls=[];
    for (var i = 0;i<filepaths.length;i++) {
      await FirebaseStorage.instance.ref(RID).child(i.toString()).putFile(File(filepaths[i]));
      urls.add(await FirebaseStorage.instance.ref(RID).child(i.toString()).getDownloadURL());
    }
    print("imags pushed\n\n");
    print(json.encode(urls));
    print('\n\n');
    return json.encode(urls);
  }
  // static Future<String> getNoOFCases()
}