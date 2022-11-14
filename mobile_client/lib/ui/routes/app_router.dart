import 'package:flutter/material.dart';
import 'package:telegram_clone/ui/routes/fade_page_route.dart';
import 'package:telegram_clone/ui/widgets/views/auth_view.dart';
import 'package:telegram_clone/ui/widgets/views/welcome_view.dart';

class AppRouter {
  static const String welcomeView = 'welcome';
  static const String authView = 'auth';

  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case welcomeView:
        return MaterialPageRoute(builder: (context) => const WelcomeView());
      case authView:
        return FadePageRoute(child: const AuthView());
      default:
        throw ('This route name does not exists');
    }
  }
}
