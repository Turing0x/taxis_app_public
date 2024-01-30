import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxis_app_public/Map_app/blocs/map/map_bloc.dart';


class BtnToggleUser extends StatelessWidget {
  const BtnToggleUser({super.key});

  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapBloc>(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: IconButton(
          icon: const Icon(
            Icons.more_horiz_rounded,
            color: Colors.black,
          ),
          onPressed: () {
            mapBloc.add(OnToggleUserRoute());
          },
        ),
      ),
    );
  }
}
