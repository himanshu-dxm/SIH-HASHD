import 'package:flutter/material.dart';
import 'package:hashd/model/databaseStorage.dart';
import 'package:hashd/model/getSoilData.dart';
import 'package:hashd/model/weather_data.dart';
import 'package:hashd/screens/login_page.dart';
import 'package:hashd/widgets/weatherInfoView.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:learning_translate/learning_translate.dart';

Future<void> main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
  WeatherData.getWeather();
  await TranslationModelManager.download('en');
  await TranslationModelManager.download('hi');
  await TranslationModelManager.download('te');
  await TranslationModelManager.download('kn');
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  
  @override
  Widget build(BuildContext context) {
    APIDATA.getSoildata();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: LoginPage(),
    );
  }
}
