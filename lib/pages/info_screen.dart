

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../service/weather_bloc/data_bloc.dart';

class InfoScreen extends StatefulWidget {
  final String city;

  const InfoScreen({Key? key, required this.city}) : super(key: key);

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DataBloc()..add(Initial(city: widget.city)),
      child: SafeArea(
        child: Scaffold(
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration:const BoxDecoration(
              image: DecorationImage(
                  image:
                        AssetImage('assets/images/backgroundImage.jpg'),
                  fit: BoxFit.cover),
            ),
            child: SingleChildScrollView(
              child:
                  BlocBuilder<DataBloc, DataState>(builder: (context, state) {
                if (state is LoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is InitialState) {
                  return Column(
                    children: [
                      const SizedBox(
                        height: 22,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on_outlined,
                                  color: Colors.white,
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Text(
                                  state.weatherData.location.name,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Sf',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18),
                                )
                              ],
                            ),

                          ],
                        ),
                      ),
                      Container(
                        height: 100,
                        width: 100,
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Image.network(
                          'https:${state.weatherData.current.condition.icon}',
                          fit: BoxFit.fill,
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          state.weatherData.current.condition.text,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16),
                        ),
                      ),
                      Center(
                        child: Text(
                          '${state.weatherData.current.tempC}',
                          style: const TextStyle(
                              fontSize: 64,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Sf',
                              color: Colors.white),
                        ),
                      ),
                      Column(
                        children: [
                          const Text(
                            'Precipitations',
                            style: TextStyle(
                                fontFamily: 'Sf',
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                                color: Colors.white),
                          ),
                          Text(
                            'Max.: ${state.weatherData.forecast.forecastday[0].day.maxtempC}º   Min.:${state.weatherData.forecast.forecastday[0].day.mintempC} º',
                            style: const TextStyle(
                                fontFamily: 'Sf',
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                                color: Colors.white),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: 47,
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(horizontal: 40),
                        decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset('assets/images/rain.svg'),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  '${state.weatherData.forecast.forecastday[0].day.dailyWillItRain}',
                                  style: const TextStyle(
                                      fontFamily: 'Sf',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                      color: Colors.white),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                SvgPicture.asset('assets/images/foiz.svg'),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  state.weatherData.current.pressureMb
                                      .toString(),
                                  style: const TextStyle(
                                      fontFamily: 'Sf',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                      color: Colors.white),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                SvgPicture.asset('assets/images/wind.svg'),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  '${state.weatherData.current.windKph}km/h',
                                  style: const TextStyle(
                                      fontFamily: 'Sf',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                      color: Colors.white),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        height:200,
alignment: Alignment.center,                   decoration: BoxDecoration(
                          // color:  Colors.deepPurpleAccent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 23,
                          itemBuilder: (BuildContext context, int index) {
                            debugPrint(
                                'real url picture ${state.weatherData.current.condition.icon}');
                            if (DateTime.now().hour + index <= 23) {
                              debugPrint('index $index');
                              return item(
                                  state.weatherData.forecast.forecastday[0]
                                      .hour[DateTime.now().hour + index].tempC
                                      .toString(),
                                  DateTime.now().hour + index,
                                  state
                                      .weatherData
                                      .forecast
                                      .forecastday[0]
                                      .hour[DateTime.now().hour + index]
                                      .condition
                                      .icon,
                                  state
                                      .weatherData
                                      .forecast
                                      .forecastday[0]
                                      .hour[DateTime.now().hour + index]
                                      .condition
                                      .text);
                            } else {
                              debugPrint('firstly if working');

                              return item(
                                  state
                                      .weatherData
                                      .forecast
                                      .forecastday[1]
                                      .hour[DateTime.now().hour + index - 24]
                                      .tempC
                                      .toString(),
                                  DateTime.now().hour + index - 24,
                                  state
                                      .weatherData
                                      .forecast
                                      .forecastday[1]
                                      .hour[DateTime.now().hour + index - 24]
                                      .condition
                                      .icon,
                                  state
                                      .weatherData
                                      .forecast
                                      .forecastday[1]
                                      .hour[DateTime.now().hour + index - 24]
                                      .condition
                                      .text);
                            }
                          },
                        ),
                      )
                    ],
                  );
                }
                return const Center(
                  child: Text('data is empty'),
                );
              }),
            ),
          ),

        ),
      ),
    );
  }

  Widget item(String str, int index, String url, String situate) {
    return Container(
      height:100,
      width:100,
alignment: Alignment.center, margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
crossAxisAlignment: CrossAxisAlignment.center,   children: [
          Column(
            children: [
              const SizedBox(
                height: 6,
              ),
              Text(
                str,
                style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontFamily: 'SF',
                    fontSize: 16),
              ),
              const SizedBox(
                height: 4,
              ),
              CachedNetworkImage(
                imageUrl: 'https:$url',
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                situate,
                style: const TextStyle(
                    fontFamily: 'SF',
                    fontWeight: FontWeight.w400,
                    fontSize: 14),
              ),
              //const SizedBox(height: 5,),
            ],
          ),

          Text(
            '$index:00',
            style: const TextStyle(
                fontFamily: 'SF', fontWeight: FontWeight.w400, fontSize: 18),
          ),
          //const  SizedBox(height: 6,),
        ],
      ),
    );
  }
}
