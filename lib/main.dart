import 'dart:async';
import 'package:app2/src/Preferences/preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'src/Pages/homeView/home.dart';
import 'src/Pages/login/vistalongin.dart';
import 'src/Routes/routes.dart';

void main() async {
  //This Functions capture erorr (ZOne) erros sincronos
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    final prefs = new PreferenciasUsuario();
    await prefs.initPrefs();
    runApp(const MyApp());
  }, (Object error, StackTrace stack) async {});
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.red,
      debugShowCheckedModeBanner: false,
      title: 'Recursos Humanos',
      initialRoute: LoginView.name,
      routes: Routes.rutas,
    );
  }
}
