import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/widgets.dart';
import '../blocs/gps/gps_bloc.dart';

class GpsAcessScreen extends StatelessWidget {
  const GpsAcessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: BlocBuilder<GpsBloc, GpsState>(
          builder: (context, state) {
            return (!state.isGpsEnabled) ? const _EnableGpsMessage() : const _AccessButton();
          },
        ),
      ),
    );
  }
}

class _AccessButton extends StatelessWidget {
  const _AccessButton();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: size.height * 0.6,
          margin: EdgeInsets.only(left: size.width * .07, right: size.width * .07),
          child: Image.asset('assets/request_location.jpg'),
        ),
        dosisText('Permitir tu ubicación', fontWeight: FontWeight.bold, size: 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: dosisText('Necesitaremos tu ubicación para brindarte una mejor experiencia.',
              maxLines: 3, textAlign: TextAlign.center),
        ),
        Container(
          height: 50,
          margin: const EdgeInsets.only(top: 20, bottom: 30),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 2, spreadRadius: 1)],
              gradient: const LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [
                Color(0xFFFF4E56),
                Color(0xFFFF684A),
              ])),
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.transparent)),
            onPressed: () async {
              final gpsBloc = BlocProvider.of<GpsBloc>(context);
              final contex = Navigator.of(context);

              bool resp = await gpsBloc.askGpsAccess();

              if (resp) {
                contex.pushNamedAndRemoveUntil('auth_page', (Route<dynamic> route) => false);
              }
            },
            child: dosisText('Claro, Estoy de Acuerdo', color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
        dosisText('Ahora no', fontWeight: FontWeight.bold, color: const Color(0xFFFD7E86))
      ],
    );
  }
}

class _EnableGpsMessage extends StatelessWidget {
  const _EnableGpsMessage();

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Debe habilitar el GPS",
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
    );
  }
}
