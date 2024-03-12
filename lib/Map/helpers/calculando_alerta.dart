import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<void> calculandoAlerta(BuildContext context) async {
  if (Platform.isAndroid) {
    showDialog(
      context: context,
      builder: (context) => const AlertDialog(
        title: Text('Espere por favor'),
        content: Text('Calculando ruta'),
      ),
    );
  } else {
    showCupertinoDialog(
      context: context,
      builder: (context) => const CupertinoAlertDialog(
        title: Text('Espere por favor'),
        content: CupertinoActivityIndicator(),
      ),
    );
  }
}
