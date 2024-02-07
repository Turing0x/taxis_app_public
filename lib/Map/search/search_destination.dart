import 'package:flutter/material.dart';
import 'package:taxis_app_public/Map/models/search_results.dart';

class SearchDestination extends SearchDelegate<SearchResults>{
  @override
  final String searchFieldLabel ='Buscar';
  
  @override
  List<Widget>? buildActions(BuildContext context) {
    
return [
  IconButton(onPressed: () =>query='', icon: const Icon(Icons.delete, color: Colors.black,))
];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: RETORNAR alGO
    return IconButton(onPressed: () => close(context, SearchResults(cancelo: true)), icon: const Icon(Icons.arrow_back,color: Colors.blue,));
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return const Text('Build Results');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
 return ListView(
  children: [
    ListTile(
      leading: const Icon(Icons.location_on),
      title: const Text('Ubicacion Manual'),
      onTap: () {
        close(context,SearchResults(cancelo: false,manual: true));
      },
    )
  ],
 );
  }
}