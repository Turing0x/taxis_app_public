import 'package:isar/isar.dart';

part 'login_data.g.dart';

@collection
class LoginData {
  Id id = Isar.autoIncrement;

  String? role;
  String? token;
  String? userInfo;
}
