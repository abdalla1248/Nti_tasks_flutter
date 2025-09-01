import 'package:geolocator/geolocator.dart';

abstract class LocationState{}

class LocationInitial extends LocationState{}

class LocationLoading extends LocationState{}
class LocationSuccess extends LocationState
{
  final Position position;
  LocationSuccess(this.position);
}

class LocationError extends LocationState
{
  final String message;
  LocationError(this.message);
}