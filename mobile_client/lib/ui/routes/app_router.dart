import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telegram_clone/ui/routes/fade_page_route.dart';
import 'package:telegram_clone/ui/widgets/models/sign_in_model.dart';
import 'package:telegram_clone/ui/widgets/models/sign_up_model.dart';
import 'package:telegram_clone/ui/widgets/views/chat_list_view.dart';
import 'package:telegram_clone/ui/widgets/views/sign_in_view.dart';
import 'package:telegram_clone/ui/widgets/views/sign_up_view.dart';
import 'package:telegram_clone/ui/widgets/views/welcome_view.dart';

abstract class RouteNames {
  static const String welcomeView = 'welcome';
  static const String signInView = 'signIn';
  static const String signUpView = 'signIn/signUp';
  static const String chatListView = '/';
}

class AppRouter {
  String initialRoute(bool isAuth) => isAuth ? RouteNames.chatListView : RouteNames.welcomeView;

  final routes = <String, Widget Function(BuildContext)>{
    RouteNames.welcomeView: (context) => const WelcomeView(),
    RouteNames.chatListView: (context) => const ChatListView(),
  };
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.signInView:
        return FadePageRoute(child: ChangeNotifierProvider<SignInModel>(create: SignInModel.create, child: const SignInView()));
      case RouteNames.signUpView:
        return FadePageRoute(
            child: ChangeNotifierProvider<SignUpModel>(create: SignUpModel.create, child: const SignUpView()), routeSettings: settings);
      default:
        throw ('This route name does not exists');
    }
  }
}
