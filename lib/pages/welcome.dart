import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/models/city.dart';
import 'package:weather_app/models/constants.dart';
import 'package:weather_app/pages/home.dart';
import 'package:weather_app/service/weather_api_data.dart';

import '../service/api_bloc/api_data_bloc.dart';
import '../service/weather_data.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    Constants myconstants = Constants();
    List<City> cities =
        City.citiesList.where((city) => city.isDefault == false).toList();
    List<City> selected = City.getSelectedCities();
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
  create: (context) => ApiDataBloc(),
  child: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: myconstants.secondaryColor,
        centerTitle: true,
        title: Text('${selected.length} selected'),
      ),
      body: ListView.builder(
        itemCount: cities.length,
        itemBuilder: (context, index) {
          return Container(
            height: size.height * 0.08,
            width: size.width,
            margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                border: cities[index].isSelected == true
                    ? Border.all(
                        color: myconstants.secondaryColor.withOpacity(0.6),
                        width: 2,
                      )
                    : Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: myconstants.primaryColor.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3)),
                ]),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      cities[index].isSelected = !cities[index].isSelected;
                    });
                  },
                  child: Image(
                    image: AssetImage(cities[index].isSelected == true
                        ? 'assets/images/checked.png'
                        : 'assets/images/unchecked.png'),
                    width: 30,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  cities[index].city,
                  style: TextStyle(
                      fontSize: 16,
                      color: cities[index].isSelected == true
                          ? myconstants.primaryColor
                          : Colors.black54),
                )
              ],
            ),
          );
        },
      ),
      floatingActionButton: BlocBuilder<ApiDataBloc,ApiDataState>(
        builder: (context, state) {
        return FloatingActionButton(
        onPressed: ()async{
          print('UPDATE-POSITION IS WORKING');

          context.read<ApiDataBloc>().add(Initial(city: await WeatherApi().updatePosition(), onSuccess: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Home()));

          }));

          print('${await WeatherApi().updatePosition()} IS WORKING');

          print('${state.apiData?.name} IS WORKING');

        },
        backgroundColor: myconstants.secondaryColor,
        child: const Icon(Icons.pin_drop),
      );
  },
),
    ),
);
  }

  Future updatePosition() async {
    Position position = await _determinePosition();
    print('func2');
    var placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    for (var element in placemark) {print(element);}
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Home(
              latitude: position.latitude.toString(),
              longitude: position.longitude.toString(),
              address: placemark[2].thoroughfare,
              speed: position.speed.toString(),
            )));
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    print('func1');

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
}
