import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/di/service_locator.dart';
import 'features/landing/presentation/landing_page.dart';
import 'global/design_system/app_colors.dart';

void main() {
  runZonedGuarded(_init, (error, stack) {
    FlutterError.reportError(
      FlutterErrorDetails(exception: error, stack: stack),
    );
  });
}

Future<void> _init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _configureOrientation();
  _configureSystemUI();
  runApp(const App());
}

Future<void> _configureOrientation() async {
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

void _configureSystemUI() {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rishabh Gupta Yocket',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: const ColorScheme.dark(
          surface: AppColors.surface,
          primary: AppColors.green,
        ),
      ),
      home: LandingPage(notifier: ServiceLocator.get()),
    );
  }
}
