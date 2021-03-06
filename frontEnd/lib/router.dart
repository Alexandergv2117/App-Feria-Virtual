import 'package:feriavirtual/screens/screens.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AuthScreen(),
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

    case University.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const University(),
      );

    case Formulario.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Formulario(),
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
