import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:secure_gates_project/controller/user_controller.dart';
import 'package:secure_gates_project/pages/authentication/login_page.dart';
import 'package:secure_gates_project/pages/homepage/home_page.dart';

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginStatus = ref.watch(userControllerProvider).currentUser;

    useEffect(() {
      ref.watch(userControllerProvider).configCurrentUser();

      return null;
    }, []);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: loginStatus != null ? const HomePage() : const LoginPage(),
    );
  }
}
