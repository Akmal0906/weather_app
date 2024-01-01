part of 'data_bloc.dart';

abstract class DataState extends Equatable {}

//enum CodeStatus { init, success, failure }
class InitialState extends DataState {
  final WeatherData weatherData;

  InitialState({required this.weatherData});

  @override
  List<Object?> get props => [weatherData];
}

class LoadingState extends DataState {
  @override
  List<Object?> get props => [];
}
