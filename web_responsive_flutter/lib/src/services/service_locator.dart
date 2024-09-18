import 'package:get_it/get_it.dart';
import 'package:web_responsive_flutter/src/common_widgets/provider/theme_provider.dart';
import 'package:web_responsive_flutter/src/routing/route_config.dart';
import 'package:web_responsive_flutter/src/services/api_service.dart';
import 'package:web_responsive_flutter/src/services/http_interceptor.dart';
import 'package:web_responsive_flutter/src/services/logger.dart';
import 'package:web_responsive_flutter/src/services/token_service.dart';

import '../features/dashboard/provider/dashboard_controller.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  // Register the HttpInterceptor and ApiService
  getIt.registerSingleton<HttpInterceptor>(HttpInterceptor());
  getIt.registerSingleton<ApiService>(ApiService(getIt<HttpInterceptor>()));
  getIt.registerSingleton<TokenService>(TokenService());
  getIt.registerSingleton<AppRouter>(AppRouter());
  getIt.registerSingleton<AppLogger>(AppLogger());

  // Register Theme provider
  getIt.registerLazySingleton(() => ThemeProvider());
  getIt.registerLazySingleton(() => DashBoardController());
}
