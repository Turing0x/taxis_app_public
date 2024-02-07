part of 'map_bloc.dart';

class MapState extends Equatable {
  final bool isMapInicialized;
  final bool isFollowingUser;
  final bool showMyRoute;
 final LatLng? ubicacionCentral;

  // Polylines
  final Map<String, Polyline> polylines;


   MapState({
    this.ubicacionCentral,
    this.isMapInicialized = false,
    this.isFollowingUser = false,
    this.showMyRoute = true,
    
    Map<String, Polyline>? polylines,
  }) : polylines = polylines ??
        <String, Polyline>{}; //Si no se le pasa valor, por defecto asigna  {} a polylines

  MapState copyWith(
          {
          LatLng? ubicacionCentral,  
          bool? isMapInicialized,
          bool? isFollowingUser,
          bool? showMyRoute,
          Map<String, Polyline>? polylines}) =>
      MapState(
          ubicacionCentral:ubicacionCentral?? this.ubicacionCentral,
          isMapInicialized: isMapInicialized ?? this.isMapInicialized,
          isFollowingUser: isFollowingUser ?? this.isFollowingUser,
          polylines: polylines ?? this.polylines,
          showMyRoute: showMyRoute ?? this.showMyRoute);

  @override
  List<Object> get props =>
      [isMapInicialized, isFollowingUser, polylines, showMyRoute];
}
