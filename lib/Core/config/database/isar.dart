import 'dart:io';

import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:taxis_app_public/Core/config/database/entities/login_data.dart';

class IsarService {
  late Future<Isar> isar;

  IsarService() {
    isar = openDb();
  }

  Future<Isar> openDb() async {
    Directory dbPath = await getApplicationDocumentsDirectory();

    if (Isar.instanceNames.isNotEmpty) {
      return Future.value(Isar.getInstance());
    }

    return await Isar.open([LoginDataSchema], directory: dbPath.path, inspector: true);
  }
}
