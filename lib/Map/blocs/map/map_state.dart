part of 'map_bloc.dart';

class MapState {
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
  }) : polylines = polylines ?? <String, Polyline>{};

  MapState copyWith({
    LatLng? ubicacionCentral2,   
    bool? isMapInicialized2,
    bool? isFollowingUser2,
    bool? showMyRoute,
    Map<String, Polyline>? polylines2,
  }) {
    return MapState(
      ubicacionCentral: ubicacionCentral2 ?? ubicacionCentral,
      isMapInicialized: isMapInicialized2 ?? isMapInicialized,
      isFollowingUser: isFollowingUser2 ?? isFollowingUser,
      polylines: polylines2 ?? polylines,
      showMyRoute: showMyRoute ?? this.showMyRoute,
    );
  }

}