part of 'busqueda_bloc.dart';

sealed class BusquedaEvent  {
  const BusquedaEvent();
}

class OnActivarMarcadorManual extends BusquedaEvent {}

class OnDesactivarMarcadorManual extends BusquedaEvent {}

class OnAgregarHistorial  extends BusquedaEvent {
  final SearchResults result;

  OnAgregarHistorial({required this.result});
}

