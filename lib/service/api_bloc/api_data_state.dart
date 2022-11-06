part of 'api_data_bloc.dart';

enum CodeStatus { init, success, failure }

class ApiDataState extends Equatable {
  ApiData? apiData;
  CodeStatus codeStatus;

  ApiDataState(
      {this.apiData, required this.codeStatus});

  ApiDataState copyWith(
      {CodeStatus? codeStatus, ApiData? apiData}) {
    return ApiDataState(
      apiData: apiData ?? this.apiData,

      codeStatus: codeStatus ?? this.codeStatus,
    );
  }

  @override
  List<Object?> get props => [apiData, codeStatus];
}
