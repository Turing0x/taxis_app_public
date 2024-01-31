import 'package:permission_handler/permission_handler.dart';
import 'package:taxis_app_public/Core/config/database/entities/login_data_service.dart';

Future<String> initialRoute() async {
  final role = await LoginDataService().getRole();

  if (role != '' ) {
    return _initialRouteByRole(role!);
  }

  if(!await isPermissionGranted()) return 'location_permission';

  return 'auth_page';
}

String _initialRouteByRole(String role) {
  
  Map<String, String> mainPages = {
    'main_driver': 'main_storage_page',
    'main_client': 'main_commercial_page',
  };

  return mainPages[role]!;
}

Future<bool> isPermissionGranted() async {
  final isGranted = await Permission.location.isGranted;
  return isGranted;
}