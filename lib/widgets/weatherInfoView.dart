import 'package:flutter/material.dart';
import 'package:hashd/model/weather_data.dart';

class WeatherInfoView extends StatefulWidget {
  const WeatherInfoView({Key? key}) : super(key: key);

  @override
  _WeatherInfoViewState createState() => _WeatherInfoViewState();
}

class _WeatherInfoViewState extends State<WeatherInfoView> {
  WeatherLocations weather=WeatherData.weather;

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height*0.25,
      margin: EdgeInsets.all(8),
      child: Center(
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // mainAxisSize: MainAxisSize.max,
            children: [
              ListTile(
                trailing: Image.network("http://openweathermap.org/img/wn//${weather.iconUrl}@4x.png"),
                // leading: Icon(Icons.album),
                title: Text(
                  weather.city,
                ),
                subtitle: Text(
                  "\nTemperature: "+weather.temperature+
                      "\nWeather Type:"+weather.weatherType+"\nHumidity: "+weather.humidity.toString()+"\nPressure: "+weather.pressure.toString(),
                ),
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //     TextButton(
              //       child: Text('Check Details'),
              //       onPressed: () {/* ... */},
              //     ),
              //     const SizedBox(width: 8),
              //     TextButton(
              //       child: Text('Delete'),
              //       onPressed: () {/* ... */},
              //     ),
              //     const SizedBox(width: 8),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
