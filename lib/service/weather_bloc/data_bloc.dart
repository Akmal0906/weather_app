import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/service/weather_api_server.dart';

part 'data_event.dart';

part 'data_state.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  DataBloc() : super(LoadingState()) {
    on<Initial>((event, emit) async {
      try {
        WeatherData weatherData = await WeatherApi().getData(event.city);
        emit(InitialState(weatherData: weatherData));
        print('weatherData.current!.cloud=== ${weatherData.current.cloud}');
        // event.onSuccess();
      } catch (e) {

      }
    });
  }
}
