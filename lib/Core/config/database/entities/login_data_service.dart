import 'package:isar/isar.dart';
import 'package:taxis_app_public/Core/config/database/entities/login_data.dart';
import 'package:taxis_app_public/Core/config/database/isar.dart';

class LoginDataService {
  late Future<Isar> db;

  LoginDataService() {
    db = IsarService().isar;
  }

  Future<List<LoginData>> getData() async {
    final isar = await db;
    return isar.loginDatas.where().findAll();
  }

  void saveData(LoginData data) async {
    final isar = await db;
    isar.writeTxn(() async {
      await isar.loginDatas.where().deleteAll();
      await isar.loginDatas.put(data);
    });
  }

  // Getter of all Properties
  Future<String?> getRole() async {
    final isar = await db;
    final getter = await isar.loginDatas.where().findAll();
    if (getter.isNotEmpty && getter[0].role != null) {
      return getter[0].role;
    }
    return '';
  }

  Future<String?> getUserInfo() async {
    final isar = await db;
    final getter = await isar.loginDatas.where().findAll();
    if (getter.isNotEmpty && getter[0].userInfo != null) {
      return getter[0].userInfo;
    }
    return '';
  }

  Future<String?> getToken() async {
    final isar = await db;
    final getter = await isar.loginDatas.where().findAll();
    if (getter.isNotEmpty && getter[0].token != null) {
      return getter[0].token;
    }
    return '';
  }

  // Delete of all Properties
  void deleteData() async {
    final isar = await db;
    isar.writeTxn(() async {
      await isar.loginDatas.where().deleteAll();
    });
  }
}
