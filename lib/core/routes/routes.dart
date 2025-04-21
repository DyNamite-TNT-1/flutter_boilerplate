import 'package:flutter/material.dart';
import 'package:test_three/features/auth/presentation/pages/sign_in_page.dart';
import 'package:test_three/features/auth/presentation/pages/sign_out_page.dart';

class AppRouter {
  static const String signIn = "/signIn";
  static const String signOut = "/signOut";

  static Route createRoot(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case signIn:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (context) {
            return SignInPage();
          },
        );
      case signOut:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (context) {
            return SignOutPage();
          },
        );
      default:
        return MaterialPageRoute(
          builder:
              (context) => Scaffold(
                appBar: AppBar(title: Text("404 Page")),
                body: Center(child: Text('No path for ${routeSettings.name}')),
              ),
        );
    }
  }

  ///Singleton factory
  static final AppRouter _instance = AppRouter._internal();

  factory AppRouter() {
    return _instance;
  }

  AppRouter._internal();
}
