import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:taxis_app_public/Core/config/database/entities/login_data_service.dart';
import 'package:taxis_app_public/Core/riverpod/declarations.dart';
import 'package:taxis_app_public/shared/widgets.dart';

class UserControllers {

  late Dio _dio;

  UserControllers() {
    _initializeDio();
  }

  Future<void> _initializeDio() async {
    final token = await LoginDataService().getToken();

    _dio = Dio(
      BaseOptions(
        baseUrl: Uri.http(dotenv.env['SERVER_URL']!).toString(),
        headers: {
          'Content-Type': 'application/json',
          'access-token': token,
        },
        validateStatus: (status) => true,
      ),
    );
  }

  Future<bool> login(String username, String pass) async {
    authStatus.value = true;
    try {

      await _initializeDio();
      Response response = await _dio.post('/api/auth/signin',
        data: jsonEncode({'username': username, 'password': pass}));
      authStatus.value = false;

      if (response.statusCode == 200) {
        return true;
      }

      showToast(response.data['api_message']);

      return false;
    } on DioException catch (_) {
      return false;
    }
  }

  // Future<void> saveUser(String fullname, String ci, String address, String phoneNumber) async {
  //   try {

  //     await _initializeDio();
  //     Response response = await _dio.post('/api/users', 
  //       data: jsonEncode({
  //         'fullname': fullname, 
  //         'ci': ci,
  //         'address': address,
  //         'phoneNumber': phoneNumber
  //       }));

  //     if (response.statusCode == 200) {
  //       return;
  //     }

  //     if( response.statusCode == 401 ) {
  //       EasyLoading.showError('Por favor, reinicie su sesión actual, su token ha expirado');
  //       return;
  //     }

  //     EasyLoading.showError('No se pudo crear el usuario con la información proporcionada');
  //     return;
  //   } on Exception catch (_) {
  //     EasyLoading.showError('No se pudo crear el usuario con la información proporcionada');
  //   }
  // }

  // Future<bool> changePass(String actualPass, String newPass) async {
  //   try {

  //     await _initializeDio();
  //     EasyLoading.show(status: 'Cambiando contraseña...');

  //     Response response = await _dio.post('/api/users/changePassword', 
  //       data: jsonEncode({'actualPass': actualPass, 'newPass': newPass}));

  //     if (response.statusCode == 200) {
  //       EasyLoading.showSuccess(response.data['api_message']);
  //       return true;
  //     }

  //     if( response.statusCode == 401 ) {
  //       EasyLoading.showError('Por favor, reinicie su sesión actual, su token ha expirado');
  //       return false;
  //     }

  //     EasyLoading.showError(response.data['api_message']);
  //     return false;
  //   } on Exception catch (e) {
  //     EasyLoading.showError(e.toString());
  //     return false;
  //   }
  // }

}