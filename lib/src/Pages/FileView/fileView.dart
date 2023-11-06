import 'dart:io';

import 'package:app2/src/Pages/FileView/Bloc/fileBloc.dart';
import 'package:app2/src/widget/classGeneral.dart';
import 'package:app2/src/widget/drawer.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

TextEditingController userController = TextEditingController();
TextEditingController passController = TextEditingController();
int animated = 1;
FileBloc fileBloc = FileBloc();

class FilView extends StatefulWidget {
  static const String name = "FilView";

  const FilView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<FilView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String? selectedFileName;
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
          // Agregar un ícono de menú al AppBar

          leading: IconButton(
            icon: Icon(Icons.menu, color: Colors.black),
            onPressed: () {
              // Abre el Drawer al hacer clic en el ícono de menú
              _scaffoldKey.currentState!.openDrawer();
            },
          ),
          actions: [Row(children: [])],
        ),
        drawer: Drawer(
          backgroundColor: General.colorApp,
          child: DrawerGeneral().drawerGeneral(size, context),
        ),
        body: Container(
            height: size.height,
            width: size.width,
            color: Colors.white,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Opacity(
                    opacity: 0.5,
                    child: Container(
                      color: General.grissApp,
                      height: size.height * 0.05,
                      width: size.width,
                      child: Center(
                          child: Text(
                        "REGISTRO MASIVO DE PRODUCTOS",
                        style: TextStyle(color: Colors.white),
                      )),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    color: Color.fromARGB(255, 216, 164, 161),
                    padding: EdgeInsets.all(30),
                    child: Center(
                      child: Text(
                        "RECORDAR QUE DEBE DE SEGUIR LA ESTRUCTURA DEL EXCEL BRINDADO, DE LO CONTRARIO NO SE SUBIRÁ LA INFORMACIÓN",
                        style: TextStyle(color: Colors.black, fontSize: 22),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.1,
                  ),
                  if (selectedFileName != null)
                    Text(
                      'Archivo seleccionado: $selectedFileName',
                      style: TextStyle(fontSize: 18),
                    ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(General.colorApp),
                    ),
                    onPressed: () async {
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles(
                        type: FileType.custom,
                        allowedExtensions: ['xlsx'],
                      );

                      if (result != null) {
                        PlatformFile platformFile = result.files.first;
                        File file = File(platformFile.path ?? "");

                        setState(() {
                          selectedFileName = platformFile.name;
                          fileBloc.requestFile(context, file: file);
                        });
                      }
                    },
                    child: Text(
                      'Seleccionar Archivo Excel',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            )));
  }
}
