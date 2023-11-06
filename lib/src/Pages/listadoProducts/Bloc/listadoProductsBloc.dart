import 'dart:async';

import 'package:app2/src/Mixins/alerts.dart';
import 'package:app2/src/Pages/listadoProducts/Models/listadoProductM.dart';
import 'package:app2/src/Pages/listadoProducts/Services/listadoProducts.dart';
import 'package:app2/src/Preferences/preferences.dart';

class ListadoProductBloc with Alerts {
  ListoProductService listoProductService = ListoProductService();
  final prefs = PreferenciasUsuario();

  StreamController<List<ListProductM>> listProductC =
      StreamController.broadcast();
  Stream<List<ListProductM>> get listProductS => listProductC.stream;

  static final ListadoProductBloc _instance = ListadoProductBloc._internal();
  factory ListadoProductBloc() {
    return _instance;
  }

  requestListProducts(context, {String? dni}) async {
    dynamic response = await listoProductService.listadoProductS();
    if (response == null || response["status"] == false) {
      showErrorDialog(
          context: context, textContent: response["message"] ?? "Error");

      listProductC.sink.add([]);

      return;
    }
    if (response["data"].isEmpty) {
      // showErrorDialog(context: context, textContent: "No se encontraron citas");
      listProductC.sink.add([]);
      return;
    }
    if (response["status"] == true && response["data"].isNotEmpty) {
      List<ListProductM> listItems = [];

      for (var item in response["data"]) {
        ListProductM temp = ListProductM.fromJson(item);
        listItems.add(temp);
      }

      listProductC.sink.add(listItems);
    }
  }

  dispose() {
    listProductC.close();
  }

  ListadoProductBloc._internal();
}
