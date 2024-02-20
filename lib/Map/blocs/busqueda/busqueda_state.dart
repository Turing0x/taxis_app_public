part of 'busqueda_bloc.dart';

class BusquedaState {
  final bool seleccionManual;
  final List<SearchResults> historial;

  BusquedaState({
    this.seleccionManual = false,
    List<SearchResults>? historial,
  }):historial=(historial ==null)?[]:historial;

  BusquedaState copywhith({bool? seleccionManual, List<SearchResults>? historial}) =>
      BusquedaState(
        seleccionManual: seleccionManual ?? this.seleccionManual,
        historial: historial??this.historial
      );
}
