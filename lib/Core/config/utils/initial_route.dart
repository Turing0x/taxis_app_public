import 'package:permission_handler/permission_handler.dart';
import 'package:taxis_app_public/Core/config/database/entities/login_data_service.dart';

Future<String> initialRoute() async {
  final role = await LoginDataService().getRole();

  if (role != '' && await isPermissionGranted()) {
    return 'maps_screen';
  }

  if (!await isPermissionGranted()) return 'location_permission';

  return 'auth_page';
}

Future<bool> isPermissionGranted() async {
  final isGranted = await Permission.location.isGranted;
  return isGranted;
}
