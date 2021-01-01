import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reflectly_clone/screens/register.dart';
import 'package:reflectly_clone/screens/splash_screen.dart';
import 'package:reflectly_clone/utils/theme.dart';

import 'notifiers/theme_notifier.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(ChangeNotifierProvider<ThemeNotifier>(
    create: (_) => ThemeNotifier(primaryTheme),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return MaterialApp(
      title: 'Reflectly Clone',
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: MyBehavior(),
          child: child,
        );
      },
      theme: themeNotifier.getTheme(),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
