import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../service/weather_bloc/data_bloc.dart';


class Home extends StatefulWidget {

 final String city;


  const Home({Key? key,required this.city})
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
    return
      BlocProvider(
        create: (context)  => DataBloc()..add(Initial(city: widget.city)),
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Weather'),
            backgroundColor: Colors.lightBlue,
          ),
          body: SingleChildScrollView(
            child: BlocBuilder<DataBloc, DataState>(
                builder: (context, state) {
                if(state is EmptyState){
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }else if(state is InitialState){
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('City name ${state.apiData.name}'),
                      const SizedBox(
                        height: 20,
                      ),
                      Text('Temperature ${(state.apiData.main!.temp!.toInt()-
                          32
                      )/1.8.toInt()}'),
                      const SizedBox(
                        height: 20,
                      ),
                      Text('Temperature minimum ${(state.apiData.main!.tempMin
                          !.toInt())- 273}'),
                      const SizedBox(
                        height: 20,
                      ),
                      Text('Temperature maximum ${state.apiData.main?.tempMax
                          ?.toInt()}'),
                    ],
                  );
                }
             return const Center(
               child: Text('dsofogdojgdflgd'),
             );

                }


            ),
          ),
        ),
      )
    ;
  }
}
