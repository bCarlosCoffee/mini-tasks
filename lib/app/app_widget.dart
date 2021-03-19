import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

import 'package:todo_list/app/routes/app_pages.dart';

import 'app_bindings.dart';
import 'routes/app_routes.dart';
import 'theme/app_theme.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.black,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mini Lista de Tarefas',
      locale: const Locale('pt', 'BR'),
      localizationsDelegates: [
        //AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: <Locale>[
        const Locale('en', 'US'),
        const Locale('pt', 'BR')
      ],
      initialBinding: AppBindings(),
      getPages: getPages,
      initialRoute: AppRoutes.INITIAL_ROUTE,
      defaultTransition: Transition.leftToRightWithFade,
      darkTheme: appThemeData,
      themeMode: ThemeMode.dark,
    );
  }
}
