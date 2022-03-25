
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hashd/model/User.dart';

class DatabaseData{
  static Future<List<dynamic>> getNotifications()async{
    List json=[];
    var UID = MyUser.UID.toString();
    await FirebaseFirestore.instance.collection('reports').where('UID',isEqualTo: UID).where('lock',isEqualTo: '2').get().then((snap){
      for(var i in snap.docs){
        json.add(i);
      }
    });
    print(json);
    return json;
  }
}