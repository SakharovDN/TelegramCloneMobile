import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:telegram_clone/domain/exceptions/api_exception.dart';
import 'package:telegram_clone/domain/services/auth_service.dart';
import 'package:telegram_clone/ui/widgets/main/shake_widget.dart';

class SignUpModel extends ChangeNotifier {
  final BuildContext context;
  late final NavigatorState _navigator;
  final _authService = AuthService();

  final nameController = TextEditingController();
  final nameKey = GlobalKey<ShakeWidgetState>();
  String? _nameError;
  String? get nameError => _nameError;

  final surnameController = TextEditingController();

  bool _isSignUpInProgress = false;
  bool get canStartSigningUp => !_isSignUpInProgress;
  bool get isSignUpInProgress => _isSignUpInProgress;

  SignUpModel({required this.context}) : super() {
    _navigator = Navigator.of(context);
  }

  factory SignUpModel.create(BuildContext context) => SignUpModel(context: context);

  Future<bool?> signUp() async {
    if (!_fieldsAreFilled()) {
      return null;
    }

    _nameError = null;
    _isSignUpInProgress = true;
    notifyListeners();

    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final email = args['email'];
    final password = args['password'];
    final name = nameController.text.trim();
    final surname = surnameController.text.trim();

    try {
      await _authService.signUp(email, password, name, surname);
    } on ApiException catch (ex) {
      switch (ex.type) {
        case ApiExceptionType.network:
          _nameError = AppLocalizations.of(context)!.lostConnection;
          break;
        default:
          _nameError = AppLocalizations.of(context)!.oops;
          break;
      }
    }

    _isSignUpInProgress = false;
    notifyListeners();
    bool success = _nameError == null;
    return success;
  }

  bool _fieldsAreFilled() {
    final email = nameController.text.trim();

    if (email.isEmpty) {
      _nameError = AppLocalizations.of(context)!.requiredField;
      nameKey.currentState?.shake();
    } else {
      _nameError = null;
    }

    notifyListeners();
    return _nameError == null;
  }
}
