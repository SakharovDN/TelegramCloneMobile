import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telegram_clone/ui/routes/fade_page_route.dart';
import 'package:telegram_clone/ui/widgets/models/sign_in_model.dart';
import 'package:telegram_clone/ui/widgets/models/sign_up_model.dart';
import 'package:telegram_clone/ui/widgets/views/sign_in_view.dart';
import 'package:telegram_clone/ui/widgets/views/sign_up_view.dart';
import 'package:telegram_clone/ui/widgets/views/welcome_view.dart';

class AppRouter {
  static const String welcomeView = 'welcome';
  static const String signInView = 'signIn';
  static const String signUpView = 'signUp';

  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case welcomeView:
        return MaterialPageRoute(builder: (context) => const WelcomeView());
      case signInView:
        return FadePageRoute(child: ChangeNotifierProvider<SignInModel>(create: SignInModel.create, child: const SignInView()));
      case signUpView:
        return FadePageRoute(
            child: ChangeNotifierProvider<SignUpModel>(create: SignUpModel.create, child: const SignUpView()), routeSettings: settings);
      default:
        throw ('This route name does not exists');
    }
  }
}
