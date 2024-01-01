import 'package:flutter/material.dart';

import 'package:weather_app/models/constants.dart';
import 'package:weather_app/pages/info_screen.dart';

import '../service/weather_api_server.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Image(
            image: const AssetImage('assets/images/winter.jpg'),
            fit: BoxFit.cover,
            height: size.height,
            width: size.width,
          ),
          TextButton(
              onPressed: () {
                print('Welcome screen  IS WORKING');
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Please wating'),duration: Duration(milliseconds: 800),
                  backgroundColor: Colors.grey,
                  behavior: SnackBarBehavior.fixed,));
                WeatherApi().updatePosition().then(
                        (value) =>
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                InfoScreen(
                                  city: value,
                                ))));
              },
              child: const Text(
                'Press the Text',
                style: TextStyle(
                    color: Colors.white, fontSize: 22, letterSpacing: 1),
              ))
        ],
      ),
    );
  }
}
