part of 'data_bloc.dart';

abstract class DataEvent extends Equatable {
  const DataEvent();
}
class Initial extends DataEvent{
  final String? city;
 // final Function onSuccess;

   const Initial({this.city});

  @override
  List<Object?> get props =>[city];

}
