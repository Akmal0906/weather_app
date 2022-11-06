part of 'api_data_bloc.dart';

abstract class ApiDataEvent extends Equatable {
  const ApiDataEvent();
}
class Initial extends ApiDataEvent{
   String? city;
   Function onSuccess;

   Initial({this.city,required this.onSuccess});

  @override
  List<Object?> get props =>[city,onSuccess];

}
