import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../entities/user.dart';
import '../services/login_presistence_service.dart';

final userControllerProvider = ChangeNotifierProvider<UserController>((ref) {
  return UserController(ref);
});

class UserController extends ChangeNotifier {
  final Ref _ref;
  User? _currentUser;

  UserController(this._ref);

  User? get currentUser => _currentUser;

  Future<void> configCurrentUser() async {
    final userData =
        await _ref.read(loginPresistenceServiceProvider).getUserFromPrefs();
    _currentUser = userData;

    notifyListeners();
  }
}

// optimas23@gmail.com
