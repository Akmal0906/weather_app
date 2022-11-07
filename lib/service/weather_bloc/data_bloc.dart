import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/service/weather_api_data.dart';
import 'package:weather_app/service/weather_data.dart';

part 'data_event.dart';

part 'data_state.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  DataBloc() : super(const DataState()) {
    on<Initial>((event, emit) async {
     try{ ApiData? apiData = await WeatherApi().getData(event.city);
     emit(state.copyWith(apiData: apiData));
     print('apidata=== ${apiData?.clouds?.all}');
    // event.onSuccess();
     }

         catch(e){

         }
    });
  }
}
