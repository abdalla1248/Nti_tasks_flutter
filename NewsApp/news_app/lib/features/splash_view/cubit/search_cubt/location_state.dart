import 'package:geolocator/geolocator.dart';

abstract class LocationState{}
class InitialState extends LocationState{}
class LocationLoading extends LocationState{}
class LocationSuccess extends LocationState{
  Position position;

  LocationSuccess({ required this.position});
}
class LocationError extends LocationState{
  String error;
  LocationError({required this.error});
}