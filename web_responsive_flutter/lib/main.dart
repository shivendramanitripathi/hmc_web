import 'package:catcher/catcher.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_responsive_flutter/firebase_options.dart';
import 'package:web_responsive_flutter/l10n/localixation.dart';
import 'package:web_responsive_flutter/src/common_widgets/datetime/datetime_provider.dart';
import 'package:web_responsive_flutter/src/features/authentication/login/provider/login_screen_provider.dart';
import 'package:web_responsive_flutter/src/features/dashboard/provider/dashboard_controller.dart';
import 'package:web_responsive_flutter/src/models/vistor_model.dart';
import 'package:web_responsive_flutter/src/routing/route_config.dart';
import 'package:web_responsive_flutter/src/services/service_locator.dart';
import 'package:web_responsive_flutter/src/themes/theme_provider.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

void main() async {
  setUrlStrategy(PathUrlStrategy());

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  analytics.setAnalyticsCollectionEnabled(true);

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  setupServiceLocator();
  await Hive.initFlutter();
  Hive.registerAdapter(VisitorAdapter());
  await Hive.openBox<Visitor>('visitors');
  SharedPreferences sp = await SharedPreferences.getInstance();
  final String languageCode = sp.getString('language_code') ?? 'en';

  CatcherOptions debugOptions = CatcherOptions(
    DialogReportMode(),
    [ConsoleHandler()],
  );

  CatcherOptions releaseOptions = CatcherOptions(
    SilentReportMode(),
    [
      ConsoleHandler(),
      EmailManualHandler(['shivendramanitripathi549@gmail.com'])
    ],
  );
  Catcher(
    rootWidget: MyApp(locale: Locale(languageCode)),
    debugConfig: debugOptions,
    releaseConfig: releaseOptions,
  );
}

class MyApp extends StatelessWidget {
  final Locale locale;

  const MyApp({super.key, required this.locale});

  @override
  Widget build(BuildContext context) {
    final routes = GetIt.I<AppRouter>().goRouter;
    return MultiBlocProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => LocalizationProvider()),
        ChangeNotifierProvider(create: (_) => DateTimeProvider()),
        ChangeNotifierProvider(create: (_) => DashBoardController()),
      ],
      child: Consumer2<ThemeProvider, LocalizationProvider>(
        builder: (context, themeProvider, localizationProvider, child) {
          return MaterialApp.router(
            routerConfig: routes,
            debugShowCheckedModeBanner: false,
            restorationScopeId: 'app',
            onGenerateTitle: (BuildContext context) => 'My Pro',
            themeMode: context.watch<ThemeProvider>().themeValue
                ? ThemeMode.dark
                : ThemeMode.light,
            darkTheme: ThemeData(brightness: Brightness.dark),
            theme: ThemeData(
                brightness: Brightness.light,
                colorScheme: ColorScheme.fromSeed(
                  seedColor: Colors.deepPurple,
                ),
                useMaterial3: true),
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            locale: context.watch<LocalizationProvider>().locale,
            supportedLocales: const [
              Locale('en', ''),
              Locale('hi', ''),
            ],
          );
        },
      ),
    );
  }
}
