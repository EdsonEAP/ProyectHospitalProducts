///Import Flutter

import 'dart:async';
import 'package:app2/src/Mixins/alerts.dart';
import 'package:app2/src/Pages/products/Services/productsService.dart';
import 'package:app2/src/Preferences/preferences.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class ProductsBloc with Alerts {
  ProductsService productsService = ProductsService();

  StreamController<String> botonProducts = StreamController<String>.broadcast();
  Stream<String> get botonProductsS => botonProducts.stream;

  final prefs = PreferenciasUsuario();

  static final ProductsBloc _instance = ProductsBloc._internal();
  factory ProductsBloc() {
    return _instance;
  }

  requestProductSet(
    context, {
    String? code,
    String? name,
    String? warehouse,
    String? qty,
    String? price_buying,
    String? price_selling,
    String? user,
  }) async {
    botonProducts.sink.add("ERROR");
    dynamic response = await productsService.producServices(
        code: code ?? "",
        name: name ?? "",
        warehouse: warehouse ?? "",
        qty: qty ?? "",
        price_buying: price_buying ?? "",
        price_selling: price_selling ?? "",
        user: user ?? "");

    if (response == null || response["status"] == false) {
      botonProducts.sink.add("REGISTRAR");
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

      botonProducts.sink.add("REGISTRAR");
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => HomeView(),
      //     ));
    }
    showErrorDialog(
        context: context, textContent: response["message"] ?? "Error");
  }

  dispose() {
    botonProducts.close();
  }

  ProductsBloc._internal();
}
