import 'package:feriavirtual/screens/authScreen.dart';
import 'package:feriavirtual/screens/homePage.dart';
import 'package:feriavirtual/screens/mainPage.dart';
import 'package:feriavirtual/screens/mainPageLogged.dart';
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

    case MainPageLogged.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const MainPageLogged(),
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
