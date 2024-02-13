
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxis_app_public/Map/blocs/busqueda/busqueda_bloc.dart';
import 'package:taxis_app_public/Map/blocs/location/location_bloc.dart';
import 'package:taxis_app_public/Map/models/search_results.dart';
import 'package:taxis_app_public/Map/search/search_destination.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusquedaBloc, BusquedaState>(
      builder: (context, state) {
        return(!state.seleccionManual)? FadeInDown(
          duration: const Duration(milliseconds: 300),
          child: buildSearchbar(context)):Container();
      },
    );
  }

  Widget buildSearchbar(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        width: width,
        child: GestureDetector(
          onTap: () async {
            final resultado = await showSearch(
                context: context, delegate: SearchDestination( 
            BlocProvider.of<LocationBloc>(context).state.lastKnowLocation!
                ));
            retornoBusqueda(resultado!, context);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                      offset: Offset(0, 5))
                ]),
            child: const Text('¿Dónde quieres ir?',
                style: TextStyle(color: Colors.black87)),
          ),
        ),
      ),
    );
  }

  void retornoBusqueda(SearchResults result, BuildContext context) {
    final busqueda = BlocProvider.of<BusquedaBloc>(context);
    if (result.cancelo) return;
    if (result.manual!) {
      busqueda.add(OnActivarMarcadorManual());
      return;
    }
  }
}
