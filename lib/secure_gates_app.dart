import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:secure_gates_project/routes/app_routes_config.dart';

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      routeInformationParser: MyAppRouterConfig.router.routeInformationParser,
      routeInformationProvider:
          MyAppRouterConfig.router.routeInformationProvider,
      routerDelegate: MyAppRouterConfig.router.routerDelegate,
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
    );
  }
}
