part of 'data_bloc.dart';

abstract class DataState extends Equatable {

}
//enum CodeStatus { init, success, failure }
class InitialState extends DataState {
  final ApiData apiData;

   InitialState({required this.apiData});

  @override
  List<Object?> get props => [apiData];
}

class EmptyState extends DataState{
  @override

  List<Object?> get props => [];

}
