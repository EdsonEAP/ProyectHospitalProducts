import 'package:app2/src/Pages/FileView/fileView.dart';
import 'package:app2/src/Pages/SalidaProduct/salidaProductView.dart';
import 'package:app2/src/Pages/homeView/home.dart';
import 'package:app2/src/Pages/listadoProducts/listadoProducts.dart';
import 'package:app2/src/Pages/login/vistalongin.dart';
import 'package:app2/src/Pages/mapa/ubicanos.dart';
import 'package:app2/src/Pages/products/productsView.dart';
import 'package:app2/src/Pages/pruebapdf.dart';
import 'package:app2/src/Pages/registro/registro.dart';

import 'package:flutter/material.dart';

abstract class Routes {
  static Map<String, WidgetBuilder> rutas = {
    LoginView.name: ((context) => const LoginView()),
    RegistroView.name: ((context) => const RegistroView()),
    HomeView.name: ((context) => const HomeView()),
    ProductsView.name: ((context) => const ProductsView()),
    FilView.name: ((context) => const FilView()),
    ListadoProductsView.name: ((context) => const ListadoProductsView()),
    ProductsSalidaView.name: ((context) => const ProductsSalidaView()),
    PDFPRUEBA.name: ((context) => const PDFPRUEBA()),
    UbicanosView.name: ((context) => const UbicanosView()),
  };
}
