import 'package:feriavirtual/features/auth/test_screens/tauth_screen.dart';
import 'package:feriavirtual/screens/homePage.dart';
import 'package:feriavirtual/screens/mainPage.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => AuthScreen(),
      );

    case MainPage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const MainPage(),
      );

    case homePage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const homePage(),
      );

    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('La pantalla no existe'),
          ),
        ),
      );
  }
}