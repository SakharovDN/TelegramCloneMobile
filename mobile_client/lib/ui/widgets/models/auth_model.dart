import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:telegram_clone/domain/exceptions/api_exception.dart';
import 'package:telegram_clone/domain/services/auth_service.dart';
import 'package:telegram_clone/ui/routes/app_router.dart';
import 'package:telegram_clone/ui/widgets/main/shake_widget.dart';

class AuthModel extends ChangeNotifier {
  BuildContext context;
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

  AuthModel({required this.context}) : super();

  factory AuthModel.create(BuildContext context) => AuthModel(context: context);

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
          _emailError = 'Потеряно интернет-соединие';
          break;
        case ApiExceptionType.notVerified:
          // TODO: send email
          break;
        case ApiExceptionType.notFound:
          // TODO: change route to sign up
          Navigator.of(context).pushReplacementNamed(
            AppRouter.welcomeView,
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
          _emailError = 'Упс.. что-то пошло не так. Попробуйте ещё раз.';
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
      _emailError = 'Обязательное поле';
      emailKey.currentState?.shake();
    } else if (!EmailValidator.validate(email)) {
      _emailError = 'Введите корректный e-mail';
      emailKey.currentState?.shake();
    } else {
      _emailError = null;
    }

    if (password.isEmpty) {
      _passwordError = 'Обязательное поле';
      passwordKey.currentState?.shake();
    } else if (password.length < 8) {
      _passwordError = 'Длина пароля должна быть не менее 8 символов';
      passwordKey.currentState?.shake();
    } else {
      _passwordError = null;
    }
    notifyListeners();
    return _emailError == null && _passwordError == null;
  }
}
