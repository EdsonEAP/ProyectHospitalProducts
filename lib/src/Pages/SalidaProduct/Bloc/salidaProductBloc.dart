import 'dart:async';

import 'package:app2/src/Mixins/alerts.dart';
import 'package:app2/src/Pages/SalidaProduct/Services/salidaProductService.dart';
import 'package:app2/src/Pages/listadoProducts/Models/listadoProductM.dart';
import 'package:app2/src/Pages/pruebapdf.dart';
import 'package:app2/src/Preferences/preferences.dart';
import 'package:flutter/cupertino.dart';

class ProductSalidaBloc with Alerts {
  SalidaProductService listoProductService = SalidaProductService();
  final prefs = PreferenciasUsuario();

  StreamController<List<ListProductM>> listProductC =
      StreamController.broadcast();
  Stream<List<ListProductM>> get listProductS => listProductC.stream;

  StreamController<List<Map<String, dynamic>>> generateCartProductC =
      StreamController.broadcast();
  Stream<List<Map<String, dynamic>>> get generateCartProductS =>
      generateCartProductC.stream;

  static final ProductSalidaBloc _instance = ProductSalidaBloc._internal();
  factory ProductSalidaBloc() {
    return _instance;
  }

  requestListProducts(context) async {
    dynamic response = await listoProductService.salidaServices();
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
    return response["data"];
  }

  carritoGenerate(context, {required List<Map<String, dynamic>> listProducts}) {
    generateCartProductC.sink.add(listProducts);
    showErrorDialog(
        context: context, textContent: "Se agrego el producto a la lista");
  }

  registerCarrito(context,
      {required List<Map<String, dynamic>> listProducts}) async {
    listProducts.forEach((product) {
      product.remove("id");
    });
    dynamic response = await listoProductService.registerProducSalida(
        dataRegisterProducts: listProducts);
    if (response == null ||
        response["status"] == false ||
        response["url"] == null) {
      showErrorDialog(
          context: context, textContent: response["message"] ?? "Error");
      return;
    }
    prefs.linkpdf = response['url'];

    showErrorDialog(
        context: context, textContent: "Se descargó el pdf correctamente");
    Navigator.pushNamed(
      context,
      PDFPRUEBA.name,
    );
  }

  dispose() {
    listProductC.close();
    generateCartProductC.close();
  }

  ProductSalidaBloc._internal();
}
