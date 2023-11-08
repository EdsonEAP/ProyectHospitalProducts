import 'package:app2/src/Pages/SalidaProduct/Bloc/salidaProductBloc.dart';
import 'package:app2/src/Pages/listadoProducts/Bloc/listadoProductsBloc.dart';
import 'package:app2/src/Pages/listadoProducts/Models/listadoProductM.dart';
import 'package:app2/src/Pages/products/Bloc/productsBloc.dart';
import 'package:app2/src/Pages/products/productsView.dart';
import 'package:app2/src/Preferences/preferences.dart';
import 'package:app2/src/widget/classGeneral.dart';
import 'package:app2/src/widget/colum_builder.dart';
import 'package:app2/src/widget/drawer.dart';
import 'package:app2/src/widget/widgets.dart';
import 'package:flutter/material.dart';

TextEditingController codeController = TextEditingController();
TextEditingController nameController = TextEditingController();
TextEditingController warehouseController = TextEditingController();
TextEditingController qtyController = TextEditingController();
TextEditingController compraController = TextEditingController();
TextEditingController ventaController = TextEditingController();
TextEditingController usuarioRegisterController = TextEditingController();
ProductsBloc productsBloc = ProductsBloc();

final prefs = PreferenciasUsuario();
int animated = 1;

class ProductsView extends StatefulWidget {
  static const String name = "ProductsView";

  const ProductsView({Key? key}) : super(key: key);

  @override
  _ProductsViewState createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    inicio();
    super.initState();
  }

  void inicio() async {
    usuarioRegisterController.text = prefs.user;
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
        height: size.height * 1,
        width: size.width * 1,
        child: ListView(
          children: [
            SizedBox(
              height: size.height * 0.03,
            ),
            Container(
              height: size.height * 0.15,
              width: size.width * 0.25,
              child: Image.asset(
                'assets/icon/logofarmacia.png', // Ajusta la ruta de tu imagen
                fit: BoxFit.contain, // Ajusta el ajuste según tus necesidades
              ),
            ),
            SizedBox(height: size.height * 0.03),

            Row(
              children: [
                Expanded(
                  child: WidgetsRepetidos().inputLogin(
                      active: true,
                      seleccione: "Code",
                      oculto: false,
                      controlador: codeController),
                ),
                Expanded(
                  child: WidgetsRepetidos().inputLogin(
                      active: true,
                      seleccione: "Name",
                      oculto: false,
                      controlador: nameController),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: WidgetsRepetidos().inputLogin(
                      active: true,
                      seleccione: "Warehouse",
                      oculto: false,
                      controlador: warehouseController),
                ),
                Expanded(
                  child: WidgetsRepetidos().inputLogin(
                      active: true,
                      seleccione: "Cantidad",
                      oculto: false,
                      controlador: qtyController),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: WidgetsRepetidos().inputLogin(
                      active: true,
                      seleccione: "Precio de Compra",
                      oculto: false,
                      controlador: compraController),
                ),
                Expanded(
                  child: WidgetsRepetidos().inputLogin(
                      active: true,
                      seleccione: "Precio de Venta",
                      oculto: false,
                      controlador: ventaController),
                ),
              ],
            ),
            WidgetsRepetidos().inputLogin(
                active: true,
                seleccione: "Usuario",
                oculto: false,
                controlador: usuarioRegisterController),
            SizedBox(height: size.height * 0.01),

            streamBotonReactive(context),

            SizedBox(
              height: 20,
            ),
            // Añade aquí otros widgets como textos o elementos adicionales
          ],
        ),
      ),
    );
  }

  streamBotonReactive(context) {
    final size = MediaQuery.of(context).size;
    return StreamBuilder<String>(
      initialData: "REGISTRAR",
      stream: productsBloc.botonProductsS,
      builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
        if (snapshot.data == "REGISTRAR") {
          animated = 1;
        } else if (snapshot.data == "ERROR") {
          animated = 2;
        }
        return AnimatedContainer(
          width: size.width * 0.5 / animated,
          curve: Curves.fastOutSlowIn,
          duration: const Duration(seconds: 2),
          child: InkWell(
            onTap: () => {
              productsBloc.requestProductSet(context,
                  code: codeController.text,
                  name: nameController.text,
                  warehouse: warehouseController.text,
                  qty: qtyController.text,
                  price_buying: compraController.text,
                  price_selling: ventaController.text,
                  user: usuarioRegisterController.text),
              codeController.clear(),
              nameController.clear(),
              warehouseController.clear(),
              qtyController.clear(),
              compraController.clear(),
              ventaController.clear(),
              usuarioRegisterController.clear(),
            },
            child: Container(
              margin: const EdgeInsets.only(left: 70, right: 70, bottom: 0),
              padding: const EdgeInsets.symmetric(vertical: 10),
              width: size.width * 0.5,
              decoration: BoxDecoration(
                color: General.colorApp,
                borderRadius: BorderRadius.circular(30),
              ),
              child: snapshot.data == "REGISTRAR"
                  ? Center(
                      child: Text(
                        snapshot.data ?? '',
                        style: TextStyle(
                          color: Colors.black, // Cambia el color a blanco
                          fontSize:
                              12, // Cambia el tamaño del texto según tus necesidades
                        ),
                      ),
                    )
                  : Center(
                      child: const CircularProgressIndicator(
                        color: Colors.black,
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }
}
