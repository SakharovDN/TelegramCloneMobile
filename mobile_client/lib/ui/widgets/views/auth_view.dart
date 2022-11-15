import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:telegram_clone/ui/widgets/main/app_text_field.dart';
import 'package:telegram_clone/ui/widgets/models/auth_model.dart';

class AuthView extends StatefulWidget {
  const AuthView({Key? key}) : super(key: key);

  @override
  AuthViewState createState() => AuthViewState();
}

class AuthViewState extends State<AuthView> {
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  void _signIn(bool canStartAuth) {
    if (canStartAuth) {
      context.read<AuthModel>().signIn();
    }
  }

  @override
  void initState() {
    _emailFocusNode.addListener(() => setState(() {}));
    _passwordFocusNode.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final emailError = context.watch<AuthModel>().emailError;
    final emailKey = context.watch<AuthModel>().emailKey;
    final passwordError = context.watch<AuthModel>().passwordError;
    final passwordKey = context.watch<AuthModel>().passwordKey;
    final isAuthInProgress = context.watch<AuthModel>().isAuthInProgress;
    final canStartAuth = context.watch<AuthModel>().canStartAuth;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context)!.email,
                textAlign: TextAlign.center,
                style: theme.textTheme.titleLarge,
              ),
              const SizedBox(height: 15),
              Text(
                AppLocalizations.of(context)!.enterYourEmailAndPassword,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey),
              ),
              const SizedBox(height: 25),
              AppTextField(
                globalKey: emailKey,
                controller: context.read<AuthModel>().emailController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                labelText: 'E-mail',
                errorText: emailError,
              ),
              const SizedBox(height: 30),
              AppTextField(
                globalKey: passwordKey,
                controller: context.read<AuthModel>().passwordController,
                obscureText: true,
                labelText: AppLocalizations.of(context)!.password,
                errorText: passwordError,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: theme.primaryColor,
        onPressed: () => _signIn(canStartAuth),
        child: isAuthInProgress ? CircularProgressIndicator(color: theme.colorScheme.onPrimary) : const Icon(Icons.arrow_forward),
      ),
    );
  }
}
