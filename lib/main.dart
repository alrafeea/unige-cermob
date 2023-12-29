import 'package:certifyapp/app_theme.dart';
import 'package:certifyapp/core/viewModels/home_view_model.dart';
import 'package:certifyapp/pages/splash_screen_page.dart';
import 'package:certifyapp/uitl/translations_delegate_base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'core/viewModels/Auth_view_model.dart';
import 'core/viewModels/project_view_model.dart';
import 'locator.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            return MultiProvider(
              providers: [
                ChangeNotifierProvider<AuthViewModel>(
                  create: (context) => AuthViewModel(),
                ),
                ChangeNotifierProvider<ProjectViewModel>(
                  create: (context) => ProjectViewModel(),
                ),ChangeNotifierProvider<HomeViewModel>(
                  create: (context) => HomeViewModel(),
                ),
              ],
              child: Consumer<ProjectViewModel>(
                builder: (context, projectProvider, child) => MaterialApp(
                  showSemanticsDebugger: false,
                  title: 'Certify App',
                  locale: projectProvider.appLocal,
                  localizationsDelegates: [
                    TranslationBaseDelegate(),
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                  ],
                  supportedLocales: [
                    const Locale('ar', ''), // Arabic
                    const Locale('en', ''), // English
                  ],
                  theme: AppTheme.lightThemeData,
                  initialRoute: '/',
                  routes: {'/': (context) => SplashScreenPage()},
                  debugShowCheckedModeBanner: false,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
