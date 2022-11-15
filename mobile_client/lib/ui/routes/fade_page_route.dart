import 'package:flutter/cupertino.dart';

class FadePageRoute extends PageRouteBuilder {
  final Widget child;
  final RouteSettings? routeSettings;
  FadePageRoute({required this.child, this.routeSettings})
      : super(
          settings: routeSettings,
          transitionDuration: const Duration(milliseconds: 500),
          pageBuilder: (context, animation, secondaryAnimation) => child,
        );

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}
