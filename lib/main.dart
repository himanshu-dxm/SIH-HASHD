import 'package:flutter/material.dart';
import 'package:hashd/model/weather_data.dart';
import 'package:hashd/screens/login_page.dart';
import 'package:hashd/widgets/weatherInfoView.dart';

void main() {
  runApp(MyApp());
  WeatherData.getWeather();
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: LoginPage(),
    );
  }
}
