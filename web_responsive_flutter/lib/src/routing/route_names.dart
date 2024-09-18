enum AppRoute {
  splash,
  login,
  mainScreen,
  requests,
  locations,
  editrequest
}

extension AppRouteExt on AppRoute {
  String get getPath {
    switch (this) {
      case AppRoute.splash:
        return '/';
      case AppRoute.login:
        return '/login';
      case AppRoute.mainScreen:
        return '/mainScreen';
      case AppRoute.requests:
        return '/requests';
      case AppRoute.locations:
        return '/locations';
      case AppRoute.editrequest:
        return '/editrequest';
      default:
        return '/login';
    }
  }

  String get getName {
    switch (this) {
      case AppRoute.splash:
        return 'splash';
      case AppRoute.login:
        return 'login';
      case AppRoute.mainScreen:
        return 'mainScreen';
      case AppRoute.requests:
        return 'requests';
      case AppRoute.locations:
        return 'locations';
      case AppRoute.editrequest:
        return '/editrequest';
      default:
        return 'login';
    }
  }
}
