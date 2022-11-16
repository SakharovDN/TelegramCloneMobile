import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:telegram_clone/ui/routes/app_router.dart';
import 'package:telegram_clone/ui/widgets/main/app_text_field.dart';
import 'package:telegram_clone/ui/widgets/models/sign_in_model.dart';

class SignInView extends StatefulWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  SignInViewState createState() => SignInViewState();
}

class SignInViewState extends State<SignInView> {
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  void _signIn(bool canStartAuth) {
    if (canStartAuth) {
      context.read<SignInModel>().signIn().then((success) {
        if (success == true) {
          Navigator.of(context).pushReplacementNamed(RouteNames.chatListView);
        }
      });
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
    final emailError = context.watch<SignInModel>().emailError;
    final emailKey = context.watch<SignInModel>().emailKey;
    final passwordError = context.watch<SignInModel>().passwordError;
    final passwordKey = context.watch<SignInModel>().passwordKey;
    final isAuthInProgress = context.watch<SignInModel>().isAuthInProgress;
    final canStartAuth = context.watch<SignInModel>().canStartAuth;

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
                controller: context.read<SignInModel>().emailController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                labelText: 'E-mail',
                errorText: emailError,
              ),
              const SizedBox(height: 30),
              AppTextField(
                globalKey: passwordKey,
                controller: context.read<SignInModel>().passwordController,
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
