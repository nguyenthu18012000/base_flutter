import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';

import 'configs/app_config.dart';
import 'constants/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await AppConfig.instance.configApp(env: Env.dev);
  final startLocale = await LocaleHelper.instance.getDefaultLocale();
  runApp(
    EasyLocalization(
        supportedLocales: LocaleHelper.instance.supportedLocales,
        path: 'assets/translations',
        fallbackLocale: LocaleHelper.instance.fallbackLocale,
        startLocale: startLocale,
        child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: 'App',
      theme: ThemeConstants.get(context),
      onGenerateRoute: RouteConfig.instance.routes,
      onGenerateInitialRoutes: (_) => [
        RouteConfig.instance.routeWithName(
          routeName: RouteConstants.employee,
        ),
      ],
      builder: EasyLoading.init(),
    );
  }
}
