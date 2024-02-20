import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:taxis_app_public/Map/models/search_results.dart';

part 'busqueda_event.dart';
part 'busqueda_state.dart';

class BusquedaBloc extends Bloc<BusquedaEvent, BusquedaState> {
  BusquedaBloc() : super(BusquedaState());

  @override
  Stream<BusquedaState> mapEventToState(BusquedaEvent event) async* {
    if (event is OnActivarMarcadorManual) {
      yield state.copywhith(seleccionManual: true);
    } else if (event is OnDesactivarMarcadorManual) {
      yield state.copywhith(seleccionManual: false);
    }else if(event is OnAgregarHistorial){
      final existe =state.historial.where((element) => element.nombreDestino==event.result.nombreDestino);
      if(existe.isEmpty){
      final newHistorial =[...state.historial,event.result];
      yield state.copywhith(historial:newHistorial );  
      }
    
    }
  }
}
