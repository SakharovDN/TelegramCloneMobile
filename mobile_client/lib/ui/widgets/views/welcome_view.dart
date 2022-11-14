import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:telegram_clone/resources/resources.dart';
import 'package:telegram_clone/ui/routes/app_router.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Spacer(flex: 2),
            Image.asset(Images.telegram),
            const SizedBox(height: 15),
            Text(
              'Telegram',
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineSmall,
            ),
            const SizedBox(height: 5),
            Text(
              AppLocalizations.of(context)!.appDescription,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey),
            ),
            const Spacer(flex: 3),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: Shimmer(
                  duration: const Duration(seconds: 3),
                  interval: const Duration(seconds: 1),
                  colorOpacity: 0.2,
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pushReplacementNamed(AppRouter.authView),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.primaryColor,
                    ),
                    child: Text(AppLocalizations.of(context)!.startMessaging),
                  ),
                ),
              ),
            ),
            const Spacer(flex: 1),
          ],
        ),
      ),
    );
  }
}
