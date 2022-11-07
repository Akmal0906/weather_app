part of 'data_bloc.dart';


class DataState extends Equatable {
  final ApiData? apiData;

  const DataState(
      {this.apiData});

  DataState copyWith(
      { ApiData? apiData}) {
    return DataState(
      apiData: apiData ?? this.apiData,


    );
  }

  @override
  List<Object?> get props => [apiData];
}
