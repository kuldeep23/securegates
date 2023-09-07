import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:secure_gates_project/entities/resident.dart';
import 'package:secure_gates_project/entities/staff.dart';

import 'package:secure_gates_project/pages/authentication/login_page.dart';
import 'package:secure_gates_project/pages/authentication/signup_page.dart';
import 'package:secure_gates_project/pages/directory/block_resident_details_page.dart';
import 'package:secure_gates_project/pages/directory/block_resident_page.dart';
import 'package:secure_gates_project/pages/directory/directory_page.dart';
import 'package:secure_gates_project/pages/domesticStaff/domestic_staff_member_details_page.dart';
import 'package:secure_gates_project/pages/domesticStaff/domestic_staff_page.dart';
import 'package:secure_gates_project/pages/homepage/home_page.dart';
import 'package:secure_gates_project/pages/visitors/visitors_tabs_page.dart';
import 'package:secure_gates_project/routes/app_routes_constants.dart';

import '../controller/user_controller.dart';
import '../pages/domesticStaff/domestic_staff_members_page.dart';
import '../pages/error/error_page.dart';

class MyAppRouterConfig {
  static final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>();

  final bool isAuth;

  // static GoRouter returnRouter(bool isAuth) {
  //   GoRouter router = GoRouter(
  //       initialLocation: "/",
  //       routes: [ // using a factory is important
  // because it promises to return _an_ object of this type
  // but it doesn't promise to make a new one.
  ///return the instance of the
  MyAppRouterConfig(this.isAuth);
  // This named constructor is the "real" constructor
  // It'll be called exactly once, by the static property assignment above
  // it's also private, so it can only be called in this class

  static GoRouter get router => _router;

  static final GoRouter _router = GoRouter(
    navigatorKey: rootNavigatorKey,
    routes: [
      GoRoute(
        name: MyAppRoutes.splashScreen,
        path: "/",
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        name: MyAppRoutes.homePage,
        path: "/home-screen",
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        name: MyAppRoutes.domesticStaffPage,
        path: "/domestic-staff",
        builder: (context, state) => const DomesticStaffListPage(),
      ),
      GoRoute(
        name: MyAppRoutes.directory,
        path: "/directory",
        builder: (context, state) => const DirectoryHomePage(),
      ),
      GoRoute(
        name: MyAppRoutes.blockResidentPage,
        path: "/block-resident-page",
        builder: (context, state) {
          final blockName = state.extra! as String;
          return BlockResidentPage(
            blockName: blockName,
          );
        },
      ),
      GoRoute(
        name: MyAppRoutes.blockResidentDetailsPage,
        path: "/block-resident-details-page",
        builder: (context, state) {
          final resident = state.extra! as Resident;
          return BlockResidentDetailsPage(
            residentData: resident,
          );
        },
      ),
      GoRoute(
        name: MyAppRoutes.domesticStaffMembersDetailsPage,
        path: "/domestic-staff-members-details",
        builder: (context, state) {
          final staffMember = state.extra! as StaffMember;
          return DomesticStaffMemberDetailsPage(
            staffMember: staffMember,
          );
        },
      ),
      GoRoute(
          name: MyAppRoutes.domesticStaffMembersPage,
          path: "/domestic-staff-members",
          builder: (context, state) {
            final staffType = state.extra! as String;
            return DomesticStaffMembersPage(
              staffType: staffType,
            );
          }),
      GoRoute(
        name: MyAppRoutes.loginPage,
        path: "/login-page",
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        name: MyAppRoutes.signupPage,
        path: "/signup-page",
        builder: (context, state) => const SignupPage(),
      ),
      GoRoute(
        name: MyAppRoutes.visitorsPage,
        path: "/visitors-page",
        builder: (context, state) => const VisitorsTabsPage(),
      ),
    ],
    errorBuilder: (BuildContext context, GoRouterState state) =>
        const ErrorPage(),

    // onException: (context, state, router) => const ErrorPage(),
    // redirect: (context, state) {
    //   if (!isAuth) {
    //     return "/login-page";
    //   } else {}
    //   return null;
    // },
  );
}

class SplashScreen extends HookConsumerWidget {
  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginStatus = ref.watch(userControllerProvider).currentUser;

    useEffect(() {
      ref.watch(userControllerProvider).configCurrentUser();

      return null;
    }, []);

    if (loginStatus != null) {
      return const HomePage();
    } else {
      return const LoginPage();
    }
  }
}
