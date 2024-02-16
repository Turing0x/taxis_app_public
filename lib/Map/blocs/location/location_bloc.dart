import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  StreamSubscription<Position>? positionStream;

  LocationBloc() : super(const LocationState()) {
    //Escucha Eventos
    on<OnNewUserLocationEvent>((event, emit) {
      emit(state.copyWith(
        lastKnowLocation: event.newLocation,
        // agrega al final, de la ya existente lista de Historial, la nueva ubicacion.
        myLocationHistory: [...state.myLocationHistory, event.newLocation],
      ));
    });

    on<OnStartFollowingUserEvent>((event, emit) {
      emit(state.copyWith(followingUser: true));
    });

    on<OnStopFollowingUserEvent>((event, emit) {
      emit(state.copyWith(followingUser: false));
    });
  }

  Future getCurrentPosition() async {
    final position = await Geolocator.getCurrentPosition();

    add(OnNewUserLocationEvent(LatLng(position.latitude, position.longitude)));
  }

  void startFollowingUsers() {
    positionStream = Geolocator.getPositionStream(
            locationSettings: const LocationSettings(accuracy: LocationAccuracy.best, distanceFilter: 10))
        .listen((event) {
      final position = event;
      add(OnNewUserLocationEvent(LatLng(position.latitude, position.longitude)));
      add(OnStartFollowingUserEvent());
    });
  }

  //Limpia la suscripción
  void stopFollowingUsers() {
    positionStream?.cancel();
    add(OnStopFollowingUserEvent());
  }

  @override
  Future<void> close() {
    stopFollowingUsers();
    return super.close();
  }
}
