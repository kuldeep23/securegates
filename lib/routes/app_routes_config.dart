import 'package:go_router/go_router.dart';

import 'package:secure_gates_project/pages/authentication/login_page.dart';
import 'package:secure_gates_project/pages/authentication/signup_page.dart';
import 'package:secure_gates_project/pages/domesticStaff/domestic_staff_page.dart';
import 'package:secure_gates_project/pages/homepage/home_page.dart';
import 'package:secure_gates_project/pages/visitors/visitors_tabs_page.dart';
import 'package:secure_gates_project/routes/app_routes_constants.dart';

class MyAppRouterConfig {
  static GoRouter returnRouter(bool isAuth) {
    GoRouter router = GoRouter(
        initialLocation: "/",
        routes: [
          GoRoute(
            name: MyAppRoutes.homePage,
            path: "/",
            builder: (context, state) => const HomePage(),
          ),
          GoRoute(
            name: MyAppRoutes.domesticStaffPage,
            path: "/domestic-staff",
            builder: (context, state) => const DomesticStaffPage(),
          ),
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
        redirect: (context, state) {
          if (!isAuth) {
            return "/login-page";
          } else {}
          return null;
        });
    return router;
  }
}
