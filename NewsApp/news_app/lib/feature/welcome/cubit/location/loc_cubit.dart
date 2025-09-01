import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/feature/welcome/cubit/location/locstate.dart';
import 'package:news_app/feature/welcome/data/repo/location_repo.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class LocationCubit extends Cubit<LocationState>
{
  LocationCubit() : super(LocationInitial());
  static LocationCubit get(context) => BlocProvider.of(context);
  final Completer<GoogleMapController> controller =
      Completer<GoogleMapController>();
  Set<Marker> markers = {};
  getLocation() async {
    LocationRepo repo = LocationRepo();
    emit(LocationLoading());
    var response = await repo.getLocation();
    response.fold(
        (String error) => emit(LocationError( error)),
        (position) {
          markers.add(
            Marker(
              markerId: MarkerId("current_location"),
              position: LatLng(position.latitude, position.longitude),
            ),
          );
          emit(LocationSuccess( position));
        }
    );
  }
}