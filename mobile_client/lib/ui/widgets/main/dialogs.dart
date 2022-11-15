import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:open_mail_app/open_mail_app.dart';

abstract class Dialogs {
  static Future<void> showConfirmEmailDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: ((context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.emailConfirmation),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(AppLocalizations.of(context)!.emailConfirmationDesc),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => _showSelectMailDialog(context),
              child: Text(
                AppLocalizations.of(context)!.confirmEmail,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Theme.of(context).primaryColor),
              ),
            ),
          ],
        );
      }),
    );
  }

  static Future<void> _showSelectMailDialog(BuildContext context) async {
    await OpenMailApp.openMailApp().then((result) {
      if (!result.didOpen && !result.canOpen) {
        _showNoMailAppsDialog(context);
      } else if (!result.didOpen && result.canOpen) {
        showDialog(context: context, builder: (_) => MailAppPickerDialog(mailApps: result.options));
      }
    });
  }

  static Future<void> _showNoMailAppsDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.emailConfirmation),
          content: Text(AppLocalizations.of(context)!.emailAppsNotFound),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
              child: TextButton(
                child: Text(AppLocalizations.of(context)!.ok),
                onPressed: () => Navigator.pop(context),
              ),
            )
          ],
        );
      },
    );
  }
}
