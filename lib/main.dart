import 'package:flutter/material.dart';
import 'package:hashd/model/databaseStorage.dart';
import 'package:hashd/model/weather_data.dart';
import 'package:hashd/screens/login_page.dart';
import 'package:hashd/widgets/weatherInfoView.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
  WeatherData.getWeather();
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  
  @override
  Widget build(BuildContext context) {
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
