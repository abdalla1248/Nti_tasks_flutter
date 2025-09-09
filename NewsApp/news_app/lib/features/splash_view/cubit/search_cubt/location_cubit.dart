import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:news_app/features/splash_view/cubit/search_cubt/location_state.dart';
import 'package:news_app/features/splash_view/data/repo/location_repo.dart';

class LocationCubit extends Cubit<LocationState>{
  LocationCubit():super(InitialState());
  static LocationCubit get(context)=>BlocProvider.of(context);
  final Completer<GoogleMapController> controller =
  Completer<GoogleMapController>();
  Set<Marker> markers = {};


  getLocation()async{
    LocationRepo locationRepo= LocationRepo();
    emit(LocationLoading());
    var response =await locationRepo.getLocation();
    response.fold(
        (error)=>emit(LocationError(error: error)),
        (position){
          markers.add(
              Marker(
                  markerId: MarkerId('current location'),
                  position: LatLng(position.latitude, position.longitude)
              )
          );
          emit(LocationSuccess( position: position));
        }
    );
  }

}