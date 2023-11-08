import 'package:app2/src/Pages/FileView/fileView.dart';
import 'package:app2/src/Pages/SalidaProduct/salidaProductView.dart';
import 'package:app2/src/Pages/listadoProducts/listadoProducts.dart';
import 'package:app2/src/Pages/products/productsView.dart';
import 'package:app2/src/Pages/registro/registro.dart';
import 'package:app2/src/widget/classGeneral.dart';
import 'package:app2/src/widget/drawer.dart';
import 'package:flutter/material.dart';

TextEditingController userController = TextEditingController();
TextEditingController passController = TextEditingController();
int animated = 1;

class HomeView extends StatefulWidget {
  static const String name = "HomeView";

  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
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
            icon: Icon(Icons.menu, color: Colors.black),
            onPressed: () {
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    cardHome(
                      size,
                      "REGISTRO PRODUCTO",
                      Icons.date_range,
                      "assets/icon/images.jpeg",
                      () {
                        Navigator.pushNamed(context, ProductsView.name);
                      },
                    ),
                    cardHome(size, "REGISTRO MASIVO", Icons.search,
                        "assets/icon/excel.jpeg", () {
                      Navigator.pushNamed(context, FilView.name);
                    })
                  ],
                ),
                Row(
                  children: [
                    cardHome(size, "REGISTRAR SALIDA ", Icons.calendar_today,
                        "assets/icon/registroUnico.jpeg", () {
                      Navigator.pushNamed(context, ProductsSalidaView.name);
                    }),
                    cardHome(size, "PRODUCTOS DISPONIBLES",
                        Icons.calendar_today, "assets/icon/disponible.png", () {
                      Navigator.pushNamed(context, ListadoProductsView.name);
                    }),
                  ],
                )
              ],
            ),
          ),
        ));
  }

  InkWell cardHome(
    Size size,
    String titulo,
    IconData iconoName,
    String urlImage,
    Function() onTapFunction,
  ) {
    return InkWell(
      onTap: onTapFunction, // Asigna la función onTap
      child: Container(
        margin: EdgeInsets.only(top: 10, left: size.width * 0.02),
        height: size.height * 0.4,
        width: size.width * 0.47,
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  height: size.height * 0.4,
                  width: size.width * 0.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    image: DecorationImage(
                      image: AssetImage(urlImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Opacity(
                  opacity: 0.8,
                  child: Container(
                    height: size.height * 0.05,
                    width: size.width * 0.5,
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(10.0)),
                      color: General.grissApp,
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            iconoName,
                            color: Colors.white,
                          ),
                          Text(
                            '  ${titulo}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
