import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taxis_app_public/Map/blocs/location/location_bloc.dart';
import 'package:taxis_app_public/Map/themes/uber.dart';



part 'map_event.dart';
part 'map_state.dart'; //state.

class MapBloc extends Bloc<MapEvent, MapState> {
  final LocationBloc locationBloc;

  GoogleMapController? _mapController;
  StreamSubscription<LocationState>? locationStateSubscription;
   Polyline _miRuta =  const Polyline(polylineId:
   PolylineId('myRoute'),
   color:Colors.black87,
   width: 4 );

  MapBloc({required this.locationBloc}) : super( MapState()) {
    //Eventos 
   

    //Suscripcion al LocationBloc para escuchar los cambios del state
    locationStateSubscription = locationBloc.stream.listen((locationState) {
      if (locationState.lastKnowLocation != null) {
        add(UpdateUserPolylineEvent(locationState.myLocationHistory));
      }

      if (state.isFollowingUser == false) return;
      if (locationState.lastKnowLocation == null) return;
      //En este punto ya contiene la ultima localizacion conocida y el seguimiento al usuario en true
      moverCamera(locationState.lastKnowLocation!);
    });
  }

   void initMapa( GoogleMapController controller ) {
    if ( !state.isMapInicialized ) {
      _mapController = controller;
      _mapController!.setMapStyle( jsonEncode(uberMapTheme) );

      add( OnMapaListo(controller) );
    }
  }

  void _onStartFollowingUser(
      OnStartFollowingUser event, Emitter<MapState> emit) {
    emit(state.copyWith(isFollowingUser: true));
    if (locationBloc.state.lastKnowLocation == null) return;
    moverCamera(locationBloc.state.lastKnowLocation!);
  }

  void _onPolylineNewPoint(
      UpdateUserPolylineEvent event, Emitter<MapState> emit) {
    final myRoute = Polyline(
        polylineId: const PolylineId('myRoute'),
        color: Colors.black,
        width: 5,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        points: event.userLocations);

    final Map<String, Polyline> currentPolylines =
        Map.from(state.polylines); //crea una copia de estado actual.
    currentPolylines['myRoute'] = myRoute;

    emit(state.copyWith(polylines: currentPolylines));
  }

  void moverCamera(LatLng newLocation) {
    final CameraUpdate cameraUpdate = CameraUpdate.newLatLng(newLocation);
    _mapController!.animateCamera(cameraUpdate);
  }

  @override
  Future<void> close() {
    locationStateSubscription?.cancel();
    return super.close();
  }
@override
  Stream<MapState>mapEventToState(MapEvent event)async*{

  if(event is OnMapaListo){
    
    yield state.copyWith( isMapInicialized: true);
  }else if(event is OnUbicacionCambio){
yield* _onNuevaUbicacon(event);
   
  }else if(event is OnToggleUserRoute){
    
   yield* _onToggleUserRoute(event);
  }else if(event is OnStartFollowingUser){
   yield* _OnStartFollowingUser(event);
  }else if( event is OnMovioMapa){
    
    yield  state.copyWith(ubicacionCentral: event.centroMapa);
  }
 
}

  Stream<MapState> _OnStartFollowingUser(OnStartFollowingUser event)async*{
    
    yield state.copyWith(isFollowingUser: !state.isFollowingUser);
  }
 

Stream<MapState>_onNuevaUbicacon(OnUbicacionCambio event)async*{
  if(state.isFollowingUser){
    moverCamera(event.ubicacion);
  }
  List<LatLng> points=[..._miRuta.points,event.ubicacion];
   _miRuta.copyWith(pointsParam: points);
   
   final currrentPolylines =state.polylines;
   currrentPolylines['myRoute']=_miRuta;
   
   yield state.copyWith( polylines: currrentPolylines); 

}
Stream<MapState>_onToggleUserRoute(OnToggleUserRoute event)async*{
if(!state.showMyRoute){
      _miRuta =_miRuta.copyWith(colorParam: Colors.black87); 
    }else {
      _miRuta =_miRuta.copyWith(colorParam: Colors.transparent); 
    }
     final currrentPolylines =state.polylines;
     currrentPolylines['myRoute']=_miRuta;
     yield state.copyWith(
       showMyRoute: !state.showMyRoute,
       polylines: currrentPolylines
       );
}

}
