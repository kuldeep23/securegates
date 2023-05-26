import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:secure_gates_project/services/login_presistence_service.dart';

final loginPresistenseController =
    ChangeNotifierProvider<LoginPresistenseController>((ref) {
  return LoginPresistenseController(ref);
});

class LoginPresistenseController extends ChangeNotifier {
  final Ref _ref;
  bool _loginStatus = false;

  LoginPresistenseController(this._ref) : super() {
    getStatus();
  }

  bool get loginStatus => _loginStatus;

  Future<void> getStatus() async {
    final theme =
        await _ref.watch(loginPresistenceServiceProvider).getLoginStatus();

    _loginStatus = theme;

    notifyListeners();
  }

  Future<void> setStatus(bool isLogedIn) async {
    await _ref.watch(loginPresistenceServiceProvider).setLoginStatus(isLogedIn);

    if (isLogedIn) {
      _loginStatus = true;
    } else {
      _loginStatus = false;
    }

    notifyListeners();
  }
}
