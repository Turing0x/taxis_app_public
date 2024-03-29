import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

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
    }
  }
}
