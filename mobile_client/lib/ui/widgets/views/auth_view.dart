import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AuthView extends StatefulWidget {
  const AuthView({Key? key}) : super(key: key);

  @override
  AuthViewState createState() => AuthViewState();
}

class AuthViewState extends State<AuthView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _passwordVisible = false;
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  void _changeTextVisibility() {
    setState(() => _passwordVisible = !_passwordVisible);
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
              SizedBox(
                height: 50,
                child: TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  enableSuggestions: false,
                  focusNode: _emailFocusNode,
                  style: const TextStyle(decoration: TextDecoration.none),
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: theme.primaryColor)),
                    labelText: 'E-mail',
                    labelStyle: _emailFocusNode.hasFocus ? theme.textTheme.titleMedium?.copyWith(color: theme.primaryColor) : null,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                height: 50,
                child: TextField(
                  controller: _passwordController,
                  focusNode: _passwordFocusNode,
                  obscureText: !_passwordVisible,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: theme.primaryColor)),
                    labelText: AppLocalizations.of(context)!.password,
                    labelStyle: _passwordFocusNode.hasFocus ? theme.textTheme.titleMedium?.copyWith(color: theme.primaryColor) : null,
                    suffixIcon: IconButton(
                        icon: Icon(
                          _passwordVisible ? Icons.visibility_off : Icons.visibility,
                          color: _passwordFocusNode.hasFocus ? theme.primaryColor : null,
                        ),
                        splashColor: Colors.transparent,
                        onPressed: _changeTextVisibility),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: theme.primaryColor,
        child: const Icon(Icons.arrow_forward),
        onPressed: () {},
      ),
    );
  }
}
