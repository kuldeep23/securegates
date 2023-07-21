import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:secure_gates_project/controller/user_controller.dart';
import 'package:secure_gates_project/routes/app_routes_config.dart';

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginStatus = ref.watch(userControllerProvider).currentUser;

    useEffect(() {
      ref.watch(userControllerProvider).configCurrentUser();

      return null;
    }, []);

    return MaterialApp.router(
      routeInformationParser:
          MyAppRouterConfig.returnRouter(loginStatus != null)
              .routeInformationParser,
      routeInformationProvider:
          MyAppRouterConfig.returnRouter(loginStatus != null)
              .routeInformationProvider,
      routerDelegate:
          MyAppRouterConfig.returnRouter(loginStatus != null).routerDelegate,
      debugShowCheckedModeBanner: false,
      title: 'Secure Gates',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xffFF6663),
        ),
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.white),
          color: Color(0xffFF6663),
        ),
        fontFamily: "Ubuntu",
        useMaterial3: true,
      ),
      // home: loginStatus != null ? const HomePage() : const LoginPage(),
    );
  }
}
