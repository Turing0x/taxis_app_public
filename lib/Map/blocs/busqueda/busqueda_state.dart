part of 'busqueda_bloc.dart';

 class BusquedaState   {
  final bool seleccionManual;

  BusquedaState({
   this.seleccionManual=false
    });
  
  BusquedaState copywhith({
    bool? seleccionManual
  })=>BusquedaState(
    seleccionManual: seleccionManual ?? this.seleccionManual
  );

}


