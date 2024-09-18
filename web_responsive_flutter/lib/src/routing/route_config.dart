import 'package:go_router/go_router.dart';
import 'package:web_responsive_flutter/src/features/authentication/login/login_screen.dart';
import 'package:web_responsive_flutter/src/features/edit_request/edit_request.dart';
import 'package:web_responsive_flutter/src/features/locations/location_screen.dart';
import 'package:web_responsive_flutter/src/features/splash/splash_screen.dart';
import 'package:web_responsive_flutter/src/features/tables/AddRequest.dart';
import 'package:web_responsive_flutter/src/routing/not_found_screen.dart';
import 'package:web_responsive_flutter/src/routing/route_names.dart';

import '../features/dashboard/dashboard.dart';

class AppRouter {
  late final GoRouter goRouter;

  AppRouter() {
    goRouter = GoRouter(
      initialLocation: AppRoute.splash.getPath,
      debugLogDiagnostics: true,
      routes: [
        GoRoute(
          path: AppRoute.splash.getPath,
          name: AppRoute.splash.getName,
          builder: (context, state) => const SplashScreen(),
        ),
        GoRoute(
          path: AppRoute.login.getPath,
          name: AppRoute.login.getName,
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: AppRoute.mainScreen.getPath,
          name: AppRoute.mainScreen.getName,
          builder: (context, state) => const Dashboard(),
        ),
        GoRoute(
          path: AppRoute.requests.getPath,
          name: AppRoute.requests.getName,
          builder: (context, state) => const AddRequest(),
        ),
        GoRoute(
          path: AppRoute.locations.getPath,
          name: AppRoute.locations.getName,
          builder: (context, state) => const LocationScreen(),
        ),
        GoRoute(
          path: AppRoute.editrequest.getPath,
          name: AppRoute.editrequest.getName,
          builder: (context, state) => const EditRequestScreen(),
        ),
      ],
      errorBuilder: (context, state) => const NotFoundScreen(),
    );
  }
}
