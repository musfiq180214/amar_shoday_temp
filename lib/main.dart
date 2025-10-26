import 'package:amar_shoday/features/language/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'core/routes/app_router.dart';
import 'core/routes/route_names.dart';
import 'features/theme/theme_provider.dart';
import 'core/logger/app_logger.dart';
import 'core/logger/app_route_observer.dart';

final AppRouteObserver _routeObserver = AppRouteObserver();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  AppLogger.init(isProduction: false);
  final logger = AppLogger.getLogger('AppInit');
  logger.i('🚀 Amar Shoday App started');

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en', 'US'), Locale('bn', 'BD')],
      path: 'assets/lang',
      fallbackLocale: const Locale('en', 'US'),
      child: const ProviderScope(child: MyApp()),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final themeMode = ref.watch(themeNotifierProvider);
    final locale = ref.watch(languageNotifierProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      //themeMode: themeMode,
      locale: locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      onGenerateRoute: AppRouter.generateRoute,
      navigatorObservers: [_routeObserver],
    );
  }
}
