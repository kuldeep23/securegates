import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:secure_gates_project/secure_gates_app.dart';
import 'package:secure_gates_project/services/login_presistence_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LoginPresistenceService.init();
  await FastCachedImageConfig.init(clearCacheAfter: const Duration(days: 15));
  runApp(const ProviderScope(child: MyApp()));
}
