///Import Flutter

import 'dart:async';
import 'dart:convert';
import 'package:app2/src/Mixins/alerts.dart';
import 'package:app2/src/Pages/FileView/Service/fileService.dart';
import 'package:app2/src/Preferences/preferences.dart';
import 'dart:io';

class FileBloc with Alerts {
  StreamController<String> botonFile = StreamController<String>.broadcast();
  Stream<String> get botonFileS => botonFile.stream;
  FileService fileService = FileService();
  final prefs = PreferenciasUsuario();

  static final FileBloc _instance = FileBloc._internal();
  factory FileBloc() {
    return _instance;
  }

  requestFile(
    context, {
    required File file,
  }) async {
    botonFile.sink.add("ERROR");
    dynamic jsonString = await fileService.fileService(file: file);
    Map<String, dynamic> response = json.decode(jsonString);

    if (response == null || response["status"] == false) {
      botonFile.sink.add("REGISTRAR");
      showErrorDialog(
          context: context, textContent: response["message"] ?? "Error");
      return;
    }

    if (response["status"] == true) {
      showErrorDialog(
          context: context, textContent: response["message"] ?? "Error");
      // prefs.nombreUsuario =
      //     (temps.firstName ?? "") + " " + (temps.surnames ?? "");
      // prefs.documentoDni = temps.document ?? "";
      // prefs.correo = temps.email ?? "";

      botonFile.sink.add("REGISTRAR");
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => HomeView(),
      //     ));
      return;
    }
    showErrorDialog(
        context: context, textContent: response["message"] ?? "Error");
  }

  dispose() {
    botonFile.close();
  }

  FileBloc._internal();
}
