part of 'busqueda_bloc.dart';

sealed class BusquedaEvent extends Equatable {
  const BusquedaEvent();

  @override
  List<Object> get props => [];
}
class OnActivarMarcadorManual extends BusquedaEvent{}
class OnDesactivarMarcadorManual extends BusquedaEvent{}
