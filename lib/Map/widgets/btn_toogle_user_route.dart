import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxis_app_public/Map/blocs/map/map_bloc.dart';


class BtnToggleUser extends StatefulWidget {
  const BtnToggleUser({super.key});

  @override
  State<BtnToggleUser> createState() => _BtnToggleUserState();
}

class _BtnToggleUserState extends State<BtnToggleUser> {
  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapBloc>(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: IconButton(
          icon:  Icon(
            (mapBloc.state.showMyRoute)? Icons.route:Icons.cancel_outlined,
            color: Colors.black,
          ),
          onPressed: () {
            mapBloc.add(OnToggleUserRoute());
            setState(() {
              
            },);
            
          },
        ),
      ),
    );
  }
}
