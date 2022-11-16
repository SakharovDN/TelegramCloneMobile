import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:telegram_clone/domain/data_providers/storage_data_provider.dart';
import 'package:telegram_clone/ui/routes/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  final model = _AppModel();
  await model.checkAuth();
  final app = _App(model: model);
  runApp(app);
}

class _App extends StatelessWidget {
  final _AppModel model;
  final _router = AppRouter();
  _App({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Telegram Clone',
      theme: ThemeData(primaryColor: const Color(0xff66a9e0)),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: const [
        Locale('en', ''),
        Locale('ru', ''),
      ],
      initialRoute: _router.initialRoute(model.isAuth),
      routes: _router.routes,
      onGenerateRoute: _router.onGenerateRoute,
    );
  }
}

class _AppModel {
  final _dataProvider = StorageDataProvider();
  bool _isAuth = false;
  bool get isAuth => _isAuth;

  Future<void> checkAuth() async {
    final token = await _dataProvider.getToken();
    _isAuth = token != null;
  }
}
