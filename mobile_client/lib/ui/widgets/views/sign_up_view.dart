import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:telegram_clone/ui/widgets/main/app_text_field.dart';
import 'package:telegram_clone/ui/widgets/main/dialogs.dart';
import 'package:telegram_clone/ui/widgets/models/sign_up_model.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  SignUpViewState createState() => SignUpViewState();
}

class SignUpViewState extends State<SignUpView> {
  final _nameFocusNode = FocusNode();
  final _surnameFocusNode = FocusNode();

  void _signUp(bool canStartSigningUp) {
    if (canStartSigningUp) {
      context.read<SignUpModel>().signUp().then((success) {
        if (success == true) Dialogs.showConfirmEmailDialog(context);
      });
    }
  }

  @override
  void initState() {
    _nameFocusNode.addListener(() => setState(() {}));
    _surnameFocusNode.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final nameError = context.watch<SignUpModel>().nameError;
    final nameKey = context.watch<SignUpModel>().nameKey;
    final isSignUpInProgress = context.watch<SignUpModel>().isSignUpInProgress;
    final canStartSigningUp = context.watch<SignUpModel>().canStartSigningUp;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context)!.infoAboutYourself,
                textAlign: TextAlign.center,
                style: theme.textTheme.titleLarge,
              ),
              const SizedBox(height: 15),
              Text(
                AppLocalizations.of(context)!.enterYourName,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey),
              ),
              const SizedBox(height: 25),
              AppTextField(
                globalKey: nameKey,
                controller: context.read<SignUpModel>().nameController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                labelText: AppLocalizations.of(context)!.name,
                errorText: nameError,
              ),
              const SizedBox(height: 30),
              AppTextField(
                controller: context.read<SignUpModel>().surnameController,
                labelText: AppLocalizations.of(context)!.surname,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: theme.primaryColor,
        onPressed: () => _signUp(canStartSigningUp),
        child: isSignUpInProgress ? CircularProgressIndicator(color: theme.colorScheme.onPrimary) : const Icon(Icons.arrow_forward),
      ),
    );
  }
}
