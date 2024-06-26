import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:secure_gates_project/controller/user_controller.dart';
import 'package:secure_gates_project/general_providers.dart';
import 'package:secure_gates_project/services/login_presistence_service.dart';

import '../custom_exception.dart';

final authServiceProvider = Provider<AuthenticationService>((ref) {
  return AuthenticationService(ref);
});

abstract class BaseAuthenticationService {
  Future<void> signInWithEmail(String email, String password);
  Future<void> signOut();
}

class AuthenticationService implements BaseAuthenticationService {
  final Dio _dio = Dio();
  final Ref ref;

  AuthenticationService(this.ref);

  @override
  Future<void> signInWithEmail(String email, String password) async {
    try {
      final formData = FormData.fromMap({"email": email, "password": password});
      final userResponse = await _dio.post(
        "${ref.read(generalUrlPathProvider)}/user_login.php",
        data: formData,
      );
      if (userResponse.data["flag"] == 1) {
        final testData =
            Map<String, dynamic>.from(userResponse.data["data"] as dynamic);

        final passingData = jsonEncode(testData);
        await ref
            .read(loginPresistenceServiceProvider)
            .setUserInPrefs(passingData);
        await ref.read(userControllerProvider).configCurrentUser();
      } else {}
    } catch (e) {
      throw CustomExeption(message: e.toString());
    }
  }

  @override
  Future<void> signOut() async {
    await ref.watch(loginPresistenceServiceProvider).setUserInPrefs("");
    ref.watch(userControllerProvider).configCurrentUser();
  }
}
