import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:telegram_clone/ui/routes/app_router.dart';
import 'package:telegram_clone/ui/widgets/views/welcome_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final _router = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Telegram Clone',
      theme: ThemeData(primaryColor: const Color(0xff6877ae)),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: const [
        Locale('en', ''),
        Locale('ru', ''),
      ],
      home: const WelcomeView(),
      onGenerateRoute: _router.onGenerateRoute,
      initialRoute: AppRouter.welcomeView,
    );
  }
}
