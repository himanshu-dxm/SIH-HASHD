
import 'package:flutter/material.dart';
import 'package:hashd/model/User.dart';
import 'package:hashd/model/databaseStorage.dart';
import 'package:hashd/model/getDatabase.dart';
import 'package:hashd/model/getSoilData.dart';
import 'package:hashd/model/weather_data.dart';
import 'package:hashd/screens/home.dart';
import 'package:hashd/screens/login_page.dart';
import 'package:hashd/screens/temp.dart';
import 'package:hashd/screens/temp1.dart';
import 'package:hashd/widgets/weatherInfoView.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:learning_translate/learning_translate.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialise();
  runApp(MyApp());
}

Future<void> initialise() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final prefs = await SharedPreferences.getInstance();
  var a = prefs.getBool('uidset');
  MyApp.uid = a!=null?a:false;
  MyUser.UID = (a!=null&&a!=false)?prefs.getString('UID')!:'';
  await WeatherData.getWeather();
  await TranslationModelManager.download('en');
  await TranslationModelManager.download('hi');
  await TranslationModelManager.download('te');
  await TranslationModelManager.download('kn');
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  static bool uid = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Home',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: uid?HomePage():LoginPage(),
      // home: TempPage(),
    );
  }
}
