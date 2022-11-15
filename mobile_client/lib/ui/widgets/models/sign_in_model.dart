import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:telegram_clone/domain/exceptions/api_exception.dart';
import 'package:telegram_clone/domain/services/auth_service.dart';
import 'package:telegram_clone/ui/routes/app_router.dart';
import 'package:telegram_clone/ui/widgets/main/shake_widget.dart';

class SignInModel extends ChangeNotifier {
  final BuildContext context;
  final _authService = AuthService();

  final emailController = TextEditingController();
  final emailKey = GlobalKey<ShakeWidgetState>();
  String? _emailError;
  String? get emailError => _emailError;

  final passwordController = TextEditingController();
  final passwordKey = GlobalKey<ShakeWidgetState>();
  String? _passwordError;
  String? get passwordError => _passwordError;

  bool _isAuthInProgress = false;
  bool get canStartAuth => !_isAuthInProgress;
  bool get isAuthInProgress => _isAuthInProgress;

  SignInModel({required this.context}) : super();

  factory SignInModel.create(BuildContext context) => SignInModel(context: context);

  Future<void> signIn() async {
    if (!_fieldsAreFilled()) {
      return;
    }

    _emailError = null;
    _passwordError = null;
    _isAuthInProgress = true;
    notifyListeners();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    try {
      final token = await _authService.signIn(email, password);
    } on ApiException catch (ex) {
      switch (ex.type) {
        case ApiExceptionType.network:
          _emailError = AppLocalizations.of(context)!.lostConnection;
          break;
        case ApiExceptionType.notVerified:
          // TODO: send email
          break;
        case ApiExceptionType.notFound:
          Navigator.of(context).pushReplacementNamed(
            AppRouter.signUpView,
            arguments: {
              'email': email,
              'password': password,
            },
          );
          return;
        case ApiExceptionType.wrongPassword:
          _passwordError = 'Неверный пароль';
          passwordKey.currentState?.shake();
          break;
        case ApiExceptionType.validationError:
        case ApiExceptionType.other:
          _emailError = AppLocalizations.of(context)!.oops;
          break;
        default:
          break;
      }
    }
    _isAuthInProgress = false;
    notifyListeners();
  }

  bool _fieldsAreFilled() {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty) {
      _emailError = AppLocalizations.of(context)!.requiredField;
      emailKey.currentState?.shake();
    } else if (!EmailValidator.validate(email)) {
      _emailError = AppLocalizations.of(context)!.enterTheCorrectEmail;
      emailKey.currentState?.shake();
    } else {
      _emailError = null;
    }

    if (password.isEmpty) {
      _passwordError = AppLocalizations.of(context)!.requiredField;
      passwordKey.currentState?.shake();
    } else if (password.length < 8) {
      _passwordError = AppLocalizations.of(context)!.passwordLength;
      passwordKey.currentState?.shake();
    } else {
      _passwordError = null;
    }
    notifyListeners();
    return _emailError == null && _passwordError == null;
  }
}
