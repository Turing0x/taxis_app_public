import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taxis_app_public/Map/models/places_results.dart';
import 'package:taxis_app_public/Map/models/search_results.dart';
import 'package:taxis_app_public/Map/services/traffic_services.dart';

class SearchDestination extends SearchDelegate<SearchResults> {
  @override
  final String searchFieldLabel = 'Buscar';
  final TrafficService trafficService;
  final LatLng proximidad;

  SearchDestination(this.proximidad) : trafficService = TrafficService();

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () => query = '',
          icon: const Icon(
            Icons.delete,
            color: Colors.black,
          ))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: RETORNAR alGO
    return IconButton(
        onPressed: () => close(context, SearchResults(cancelo: true)),
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.blue,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    // trafficService.getPlacesPorQuery(query.trim(), proximidad);
    return _construirResultadoSugerencia();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    if (query.isEmpty) {
      return ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.location_on),
            title: const Text('Ubicacion Manual'),
            onTap: () {
              close(context, SearchResults(cancelo: false, manual: true));
            },
          )
        ],
      );
    } else {
      return _construirResultadoSugerencia();
    }
  }

  Widget _construirResultadoSugerencia() {
    if (query == '') {
      return Container();
    }
//(query.trim(), proximidad)
    trafficService.getSugerenciasPorQuery(query.trim(), proximidad);
    return StreamBuilder(
      stream: trafficService.sugerenciasStream,
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        } else {
          final findResponse = snapshot.data as FindPlacesRespose;
          final lugares = findResponse.candidates;
          if (lugares.isEmpty) {
            return ListTile(
              title: Text('No hay Resultadoos con $query'),
            );
          }
          return ListView.separated(
            separatorBuilder: (_, index) => const Divider(),
            itemCount: lugares.length,
            itemBuilder: (context, index) {
              final lugar = lugares[index];
              return ListTile(
                leading: const Icon(Icons.place),
                title: Text(lugar.formattedAddress),
                onTap: () {
                  close(context, SearchResults(
                    cancelo: false,
                    manual: false,
                    position: LatLng(lugar.geometry.location.lat, lugar.geometry.location.lng),
                    nombreDestino: 'lugar.name'));
                },
              );
            },
          );
        }
      },
    );
  }
}
