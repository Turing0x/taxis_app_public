import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

part 'gps_event.dart';
part 'gps_state.dart';

class GpsBloc extends Bloc<GpsEvent, GpsState> {
  StreamSubscription? gpsServicesSubscription;

  GpsBloc()
      //super es la manera de como se va a configurar, inicialmente, cuando se llama al bloc(esto sucede en el main)
      : super(
          const GpsState(isGpsEnabled: false, isGpsPermissionGranted: false),
        ) {
    //Recibe el evento
    on<GpsAndPermissionEvent>((event, emit) =>
        emit(state.copyWith(isGpsEnabled: event.isGpsEnabled, isGpsPermissionGranted: event.isGpsPermissionGranted)));

    //Ejecuta funcion _init
    _init();
  }

  Future<void> _init() async {
    final gpsInitStatus = await Future.wait([_checkGpsStatus(), _isPermissionGranted()]);

    add(GpsAndPermissionEvent(isGpsEnabled: gpsInitStatus[0], isGpsPermissionGranted: gpsInitStatus[1]));
  }

  //Verifica si tiene permiso otorgado
  Future<bool> _isPermissionGranted() async {
    final isGranted = await Permission.location.isGranted;
    return isGranted;
  }

  //Verifica si el servicio Location esta habilitado
  Future<bool> _checkGpsStatus() async {
    final isEnable = await Geolocator.isLocationServiceEnabled();

    gpsServicesSubscription = Geolocator.getServiceStatusStream().listen((event) {
      Geolocator.getServiceStatusStream().listen((event) {
        final isEnabled = (event.index == 1) ? true : false;
        add(GpsAndPermissionEvent(isGpsEnabled: isEnabled, isGpsPermissionGranted: state.isGpsPermissionGranted));
      });
    });

    return isEnable;
  }

  Future<bool> askGpsAccess() async {
    final status = await Permission.location.request();

    switch (status) {
      case PermissionStatus.granted:
        add(GpsAndPermissionEvent(isGpsEnabled: state.isGpsEnabled, isGpsPermissionGranted: true));
        return true;
      //Caso contrario es false
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.limited:
      case PermissionStatus.permanentlyDenied:
        add(GpsAndPermissionEvent(isGpsEnabled: state.isGpsEnabled, isGpsPermissionGranted: false));
        openAppSettings();
      case PermissionStatus.provisional:
      // TODO: Handle this case.
    }

    return false;
  }

  @override
  Future<void> close() {
    gpsServicesSubscription?.cancel();
    return super.close();
  }
}
