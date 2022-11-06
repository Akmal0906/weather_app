part of 'data_bloc.dart';

abstract class DataEvent extends Equatable {
  const DataEvent();
}
class Initial extends DataEvent{
   String? city;
   Function onSuccess;

   Initial({this.city,required this.onSuccess});

  @override
  List<Object?> get props =>[city,onSuccess];

}
