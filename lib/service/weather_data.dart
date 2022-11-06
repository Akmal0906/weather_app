import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/service/weather_api_data.dart';

class WeatherApi {
  static const String url ='https://api.openweathermap.org/data/2.5/weather?q=Samarkand&appid=f14d444c68f95239729ccdd7b990a47e';
  static const String apiKey =
      'f14d444c68f95239729ccdd7b990a47e';
  static const String baseUrl =
      'https://api.openweathermap.org/data/2.5/weather?q=';

  Future<String?> updatePosition() async {
    Position position = await _determinePosition();
    var placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    return placemark[0].locality;
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
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  Future<ApiData?> getData(String? city) async {
    final dio = Dio();
    try {
      var response = await dio.get('$baseUrl$city&appid=$apiKey');
      print(response.realUri);
      print('RESPONSE DATA COMING SERVER ${response.data}');

      return ApiData.fromJson(response.data);
    } catch (e) {
      print(e.toString());
    }
    return null;
  }
}
