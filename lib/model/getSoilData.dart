import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'getCity.dart';
class APIDATA{
 static getSoildata()async{
   String state = await getState();
   var soil;
   var recommendations;
   String response = await rootBundle.loadString('assets/api/soil-crop.json');
   var json_data = await json.decode(response);
   for(int i=0;i<json_data.length;i++){
     for(int j=0;j<json_data[i].state;j++){
       if(state.toString().split('').join('').toLowerCase()==json_data[i].States[j].toString().split('').join('').toLowerCase())
       {
         soil = json_data[i].name.toString();
         recommendations = json_data[i].Suitablecrop.join(' ').toString();
       }
     }
   }
}
}