import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../service/weather_bloc/data_bloc.dart';


class Home extends StatefulWidget {
  String? latitude;
  String? longitude;
  String? speed;
  String? address;

  Home({Key? key, this.address, this.latitude, this.longitude, this.speed})
      : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DataBloc(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Weather'),
          backgroundColor: Colors.lightBlue,
        ),
        body: SingleChildScrollView(
              child: BlocBuilder<DataBloc, DataState>(
            builder: (context, state) {
              print('STATE NAME ${state.apiData?.name}');
              print('TEMPERATURE${state.apiData?.main?.tempMax}');
              print('TEMPERATURE MIN${state.apiData?.main?.tempMin}');
              print('TEMPERATURE TEMP${state.apiData?.main?.temp}');

                return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('City name ${state.apiData?.name}'),
                  const SizedBox(
                    height: 20,
                  ),
                  Text('Temperature ${state.apiData?.main?.temp}'),
                  const SizedBox(
                    height: 20,
                  ),
                  Text('Temperature minimum ${state.apiData?.main?.tempMin}'),
                  const SizedBox(
                    height: 20,
                  ),
                  Text('Temperature maximum ${state.apiData?.main?.tempMax}'),
                ],
              );

              }


          ),
        ),
      ),
    );
  }
}
