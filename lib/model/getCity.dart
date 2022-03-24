import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

Future<String> getCity()async{
  var city;
  Position p = await GeolocatorPlatform.instance.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
  var lat = p.latitude;
  var long = p.longitude;
  var placemarks = await GeocodingPlatform.instance.placemarkFromCoordinates(lat,long);
  return placemarks.first.locality.toString();
}