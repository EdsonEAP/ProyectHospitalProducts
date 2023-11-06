import 'package:shared_preferences/shared_preferences.dart';

import '../Pages/login/vistalongin.dart';

class PreferenciasUsuario {
  static final PreferenciasUsuario _instancia = PreferenciasUsuario._internal();

  factory PreferenciasUsuario() {
    return _instancia;
  }
  SharedPreferences? _prefs;
  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  //Ed

  bool get guardadoUserAndPassword {
    return _prefs?.getBool('guardadoUserAndPassword') ?? false;
  }

  set guardadoUserAndPassword(bool value) {
    _prefs?.setBool('guardadoUserAndPassword', value);
  }

  String get linkpdf {
    return _prefs?.getString('linkpdf') ?? '';
  }

  set linkpdf(String value) {
    _prefs?.setString('linkpdf', value);
  }

  String get documentoDni {
    return _prefs?.getString('documentoDni') ?? '';
  }

  set documentoDni(String value) {
    _prefs?.setString('documentoDni', value);
  }

  String get correo {
    return _prefs?.getString('correo') ?? '';
  }

  set correo(String value) {
    _prefs?.setString('correo', value);
  }

////////

  int get genero {
    return _prefs?.getInt('genero') ?? 1;
  }

  set genero(int value) {
    _prefs?.setInt('genero', value);
  }

  bool get colorSecundario {
    return _prefs?.getBool('colorSecundario') ?? false;
  }

  set colorSecundario(bool value) {
    _prefs?.setBool('colorSecundario', value);
  }

  String get nombreUsuario {
    return _prefs?.getString('nombreUsuario') ?? '';
  }

  set nombreUsuario(String value) {
    _prefs?.setString('nombreUsuario', value);
  }

  String get ultimaPagina {
    return _prefs?.getString('ultimaPagina') ?? LoginView.name;
  }

  set ultimaPagina(String value) {
    _prefs?.setString('ultimaPagina', value);
  }

  String get emailSave {
    return _prefs?.getString('emailSave') ?? "";
  }

  set emailSave(String value) {
    _prefs?.setString('emailSave', value);
  }

  String get user {
    return _prefs?.getString('user') ?? "";
  }

  set user(String value) {
    _prefs?.setString('user', value);
  }

  String get password {
    return _prefs?.getString('password') ?? "";
  }

  set password(String value) {
    _prefs?.setString('password', value);
  }

  String get cookie {
    return _prefs?.getString('cookie') ?? "";
  }

  set cookie(String value) {
    _prefs?.setString('cookie', value);
  }

  PreferenciasUsuario._internal();
}
