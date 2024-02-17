part of 'map_bloc.dart';

class MapState {
  final bool isMapInicialized;
  final bool isFollowingUser;
  final bool showMyRoute;
  final LatLng? ubicacionCentral;

  // Polylines
  final Map<String, Polyline> polylines;
  final Map<String, Marker> markers;

  MapState({
    this.ubicacionCentral,
    this.isMapInicialized = false,
    this.isFollowingUser = false,
    this.showMyRoute = true,
    Map<String, Polyline>? polylines,
    Map<String, Marker>? markers,
  }): polylines = polylines ?? <String, Polyline>{},
      markers = markers ?? <String, Marker>{};

  MapState copyWith({
    LatLng? ubicacionCentral2,
    bool? isMapInicialized2,
    bool? isFollowingUser2,
    bool? showMyRoute,
    Map<String, Polyline>? polylines2,
    Map<String, Marker>? markers2,
  }) {
    return MapState(
      ubicacionCentral: ubicacionCentral2 ?? ubicacionCentral,
      isMapInicialized: isMapInicialized2 ?? isMapInicialized,
      isFollowingUser: isFollowingUser2 ?? isFollowingUser,
      polylines: polylines2 ?? polylines,
      markers: markers2 ?? markers,
      showMyRoute: showMyRoute ?? this.showMyRoute,
    );
  }
}
