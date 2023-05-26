import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:secure_gates_project/controller/login_presistense_controller.dart';

import '../custom_exception.dart';

final authServiceProvider = Provider<AuthenticationService>((ref) {
  return AuthenticationService(Dio(), ref);
});

abstract class BaseAuthenticationService {
  Future<void> signInWithEmail(String email, String password);
  Future<void> signOut();
}

class AuthenticationService implements BaseAuthenticationService {
  final Dio _dio;
  final Ref ref;

  const AuthenticationService(this._dio, this.ref);

  @override
  Future<void> signInWithEmail(String email, String password) async {
    try {
      final formData = FormData.fromMap({"email": email, "password": password});
      final userResponse = await _dio.post(
        "https://gatesadmin.000webhostapp.com/user_login.php",
        data: formData,
      );
      if (userResponse.data["flag"] == 1) {
        await ref.watch(loginPresistenseController).setStatus(true);
      }
    } catch (e) {
      throw CustomExeption(message: e.toString());
    }
  }

  @override
  Future<void> signOut() async {
    await ref.watch(loginPresistenseController).setStatus(false);
  }
}
