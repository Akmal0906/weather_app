import 'package:dio/dio.dart';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/models/weather_model.dart';

class WeatherApi {
  Future updatePosition() async {
    Position position = await _determinePosition();
    var placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print('AAAAAAAA${placemark[0].subThoroughfare}');
    print(placemark.join(''));
    return placemark[1].locality;
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future getData(String city) async {
    final dio = Dio();
    try {
      var response = await dio.get(
          'https://api.weatherapi.com/v1/forecast.json?key=6d609b696894475698d105756221112&q=$city&days=5&aqi=no&alerts=no');
      print(response.realUri);
      print('RESPONSE DATA COMING SERVER ${response.data}');

      return WeatherData.fromJson(response.data);
    } catch (e) {
      print(e.toString());
    }
  }
}
