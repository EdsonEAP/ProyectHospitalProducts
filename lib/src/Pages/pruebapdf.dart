import 'dart:io';

import 'package:app2/src/Pages/SalidaProduct/Bloc/salidaProductBloc.dart';
import 'package:app2/src/Preferences/preferences.dart';
import 'package:app2/src/widget/classGeneral.dart';
import 'package:app2/src/widget/desing_text.dart';
import 'package:app2/src/widget/drawer.dart';
import 'package:flutter/material.dart';
import 'package:internet_file/internet_file.dart';
import 'package:pdfx/pdfx.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

List<String> listProduct = [];
late PdfControllerPinch _pdfControllerPinch;
ProductSalidaBloc listaProductBlocs = ProductSalidaBloc();
final prefs = PreferenciasUsuario();
String linkpdf = prefs.linkpdf;

class PDFPRUEBA extends StatefulWidget {
  static const String name = "PDFPRUEBA";

  const PDFPRUEBA({Key? key}) : super(key: key);

  @override
  _PDFPRUEBAState createState() => _PDFPRUEBAState();
}

class _PDFPRUEBAState extends State<PDFPRUEBA> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    linkpdf = prefs.linkpdf;
    print(linkpdf);
    pdf();
    super.initState();
  }

  void pdf() {
    String? dataReceived;
    _pdfControllerPinch = PdfControllerPinch(
      document: PdfDocument.openData(
        InternetFile.get(
          'http://10.0.2.2:8000$linkpdf',
        ),
      ),
      //initialPage: _initialPage,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: General.colorApp,
        title: Center(
          child: Container(
            margin: EdgeInsets.only(right: 50),
            child: Image.asset(
              'assets/icon/logofarmacia.png',
              width: 200,
            ),
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.black,
          ),
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.file_download,
                color: Colors.black,
              ),
              onPressed: () {
                launch('http://10.0.2.2:8000$linkpdf');
              })
        ],
      ),
      drawer: Drawer(
        backgroundColor: General.colorApp,
        child: DrawerGeneral().drawerGeneral(size, context),
      ),
      body: Container(
        color: Color.fromARGB(255, 206, 206, 206),
        child: Column(
          children: [Flexible(flex: 10, child: pdfViewer())],
        ),
      ),
    );
  }

  Widget pdfViewer() {
    return PdfViewPinch(
      builders: PdfViewPinchBuilders<DefaultBuilderOptions>(
        options: const DefaultBuilderOptions(),
        documentLoaderBuilder: (_) =>
            const Center(child: CircularProgressIndicator(color: Colors.red)),
        pageLoaderBuilder: (_) =>
            const Center(child: CircularProgressIndicator(color: Colors.white)),
        errorBuilder: (_, error) => Center(
            child: Text(
          "No Disponible",
          style: DesingText.regularBoldText(null, Colors.grey),
        )),
      ),
      controller: _pdfControllerPinch,
    );
  }
}
