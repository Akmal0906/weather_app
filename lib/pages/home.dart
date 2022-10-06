// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:weather_app/models/city.dart';
import 'package:weather_app/models/constants.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Constants myconstants = Constants();
  int temperature = 0;
  int maxTemp = 0;
  String weatherStateName = 'Loading...';
  int humidity = 0;
  int windSpeed = 0;
  var currentData = 'Loading...';
  String imageUrl = '';
  int woeid = 44418;
  String location = 'London';
  var selectedCities = City.getSelectedCities();
  List<String> cities = ['London'];
  List consolidateWeatherList = [];

  //Api calls url
  String searchLocationUrl =
      'https://www.metaweather.com/api/location/search/?query='; //To get the woeid
  String searchWeatherUrl =
      'https://www.metaweather.com/api/location/'; //to get weather details using the woeid
  void fetchLocation(String location) async {
    var searchResult = await http.get(Uri.parse(searchLocationUrl + location));
    var result = json.decode(searchResult.body);
    print(result);
  }

  @override
  void initState() {
    fetchLocation(cities[0]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:const Text('Home'),
      ),
    );
  }
}
