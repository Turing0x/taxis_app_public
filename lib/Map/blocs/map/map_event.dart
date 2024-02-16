part of 'map_bloc.dart';

abstract class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

class OnMapaListo extends MapEvent {
  final GoogleMapController controller;

  const OnMapaListo(this.controller);
}

class OnStopFollowingUser extends MapEvent {}

class OnCrearRutaInicioDestino extends MapEvent {
  final List<LatLng> coords;
  final double distancia;
  final String duration;

  const OnCrearRutaInicioDestino({required this.coords, required this.distancia, required this.duration});
}

class OnStartFollowingUser extends MapEvent {}

class UpdateUserPolylineEvent extends MapEvent {
  final List<LatLng> userLocations;

  const UpdateUserPolylineEvent(this.userLocations);
}

class OnUbicacionCambio extends MapEvent {
  final LatLng ubicacion;

  const OnUbicacionCambio(this.ubicacion);
}

class OnToggleUserRoute extends MapEvent {}

class OnMovioMapa extends MapEvent {
  final LatLng centroMapa;
  const OnMovioMapa({required this.centroMapa});
}
