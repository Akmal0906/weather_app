import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/service/weather_api_data.dart';
import 'package:weather_app/service/weather_data.dart';

part 'api_data_event.dart';

part 'api_data_state.dart';

class ApiDataBloc extends Bloc<ApiDataEvent, ApiDataState> {
  ApiDataBloc() : super(ApiDataState()) {
    on<Initial>((event, emit) async {
     try{ ApiData? apiData = await WeatherApi().getData(event.city);
     emit(state.copyWith(apiData: apiData));
     print('apidata=== ${apiData?.clouds?.all}');
     event.onSuccess();
     }

         catch(e){

         }
    });
  }
}
