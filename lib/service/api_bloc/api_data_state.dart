part of 'api_data_bloc.dart';


class ApiDataState extends Equatable {
  ApiData? apiData;

  ApiDataState(
      {this.apiData});

  ApiDataState copyWith(
      { ApiData? apiData}) {
    return ApiDataState(
      apiData: apiData ?? this.apiData,


    );
  }

  @override
  List<Object?> get props => [apiData];
}
