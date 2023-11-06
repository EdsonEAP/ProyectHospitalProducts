import 'package:app2/src/Pages/SalidaProduct/Bloc/salidaProductBloc.dart';
import 'package:app2/src/Pages/listadoProducts/Bloc/listadoProductsBloc.dart';
import 'package:app2/src/Pages/listadoProducts/Models/listadoProductM.dart';
import 'package:app2/src/Pages/products/productsView.dart';
import 'package:app2/src/Preferences/preferences.dart';
import 'package:app2/src/widget/classGeneral.dart';
import 'package:app2/src/widget/colum_builder.dart';
import 'package:app2/src/widget/drawer.dart';
import 'package:app2/src/widget/widgets.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

int animated = 1;
String? dropdownProduct;
String? dropdownnombre;
ProductSalidaBloc listaProductBlocs = ProductSalidaBloc();
List<String> listProduct = [];
final prefs = PreferenciasUsuario();
List<dynamic> listItems = [];
TextEditingController warehouseControllers = TextEditingController();
TextEditingController nombreProductController = TextEditingController();
TextEditingController cantidadController = TextEditingController();
TextEditingController precioSalidaController = TextEditingController();
List<Map<String, dynamic>>? mapProduct;
Uuid uuid = Uuid();

class ProductsSalidaView extends StatefulWidget {
  static const String name = "ProductsSalidaView";

  const ProductsSalidaView({Key? key}) : super(key: key);

  @override
  _ProductsSalidaViewState createState() => _ProductsSalidaViewState();
}

class _ProductsSalidaViewState extends State<ProductsSalidaView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    inicio();
    super.initState();
  }

  void inicio() async {
    mapProduct?.clear();
    searachListProduct();
    await listaProductBlocs.requestListProducts(context);
  }

  void searachListProduct() async {
    listItems = await listaProductBlocs.requestListProducts(context);

    listProduct.clear();

    for (var item in listItems) {
      if (item is Map<String, dynamic> && item.containsKey("code")) {
        listProduct.add(item["code"]);
      }
    }
    print(listItems);
  }

  Future<Map<String, dynamic>?> searchListProduct(String code) async {
    print(listItems);
    for (var item in listItems) {
      if (item is Map<String, dynamic> &&
          item.containsKey("code") &&
          item["code"] == code) {
        warehouseControllers.text = item["warehouse"];
        nombreProductController.text = item["name"];
        cantidadController.text = item["qty"];
        precioSalidaController.text = item["price_selling"];
        return item;
      }
    }

    return null;
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
          height: size.height * 0.9,
          width: size.width,
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Opacity(
                  opacity: 0.5,
                  child: Container(
                    color: General.grissApp,
                    height: size.height * 0.05,
                    width: size.width,
                    child: Center(
                        child: Text(
                      "REGISTRO SALIDA",
                      style: TextStyle(color: Colors.white),
                    )),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 1),
                  height: size.height * 0.9,
                  width: size.width,
                  child: Column(
                    children: [
                      StreamBuilder<List<ListProductM>>(
                          stream: listaProductBlocs.listProductS,
                          builder: (context, snapshot) {
                            if (snapshot.data != null) {
                              if (snapshot.data!.isEmpty) {
                                return const Center(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 200),
                                    child: Text(
                                      "No hay Registros",
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 112, 107, 107)),
                                    ),
                                  ),
                                );
                              } else {
                                return Container(
                                  width: size.width,
                                  height: size.height * 0.8,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        WidgetsRepetidos().cajaSelect(
                                            context,
                                            "Seleccione",
                                            size.height * 0.08,
                                            size.width * 1,
                                            listProduct,
                                            "",
                                            dropdownProduct, (v) {
                                          setState(() {
                                            dropdownProduct = v;
                                            print(v);
                                            var resultado =
                                                searchListProduct(v);
                                            print(resultado);
                                          });
                                        }),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: WidgetsRepetidos()
                                                  .inputLogin(
                                                      active: false,
                                                      seleccione: "Almacen",
                                                      oculto: false,
                                                      controlador:
                                                          warehouseControllers),
                                            ),
                                            Expanded(
                                              child: WidgetsRepetidos().inputLogin(
                                                  active: false,
                                                  seleccione: "Nombre",
                                                  oculto: false,
                                                  controlador:
                                                      nombreProductController),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: WidgetsRepetidos()
                                                  .inputLogin(
                                                      active: true,
                                                      seleccione: "Cantidad",
                                                      oculto: false,
                                                      controlador:
                                                          cantidadController),
                                            ),
                                            Expanded(
                                              child: WidgetsRepetidos()
                                                  .inputLogin(
                                                      active: false,
                                                      seleccione:
                                                          "Precio salida",
                                                      oculto: false,
                                                      controlador:
                                                          precioSalidaController),
                                            ),
                                          ],
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            if (dropdownProduct == null ||
                                                dropdownProduct == "") {
                                              return;
                                            }
                                            Map<String, dynamic> productAdd = {
                                              "code": dropdownProduct,
                                              "name":
                                                  nombreProductController.text,
                                              "warehouse":
                                                  warehouseControllers.text,
                                              "qty": cantidadController.text,
                                              "price_selling":
                                                  precioSalidaController.text,
                                              "id": uuid.v4(),
                                            };

                                            mapProduct ??= [];

                                            mapProduct!.add(productAdd);
                                            await listaProductBlocs
                                                .carritoGenerate(context,
                                                    listProducts: mapProduct!);
                                          },
                                          child: Container(
                                              margin: EdgeInsets.only(
                                                  bottom: size.height * 0.01),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 14),
                                              width: size.width,
                                              decoration: BoxDecoration(
                                                color: General.colorApp,
                                                borderRadius:
                                                    BorderRadius.circular(7),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  'Añadir salida de producto',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              )),
                                        ),
                                        StreamBuilder<
                                            List<Map<String, dynamic>>>(
                                          stream: listaProductBlocs
                                              .generateCartProductS,
                                          builder: (context,
                                              AsyncSnapshot<
                                                      List<
                                                          Map<String, dynamic>>>
                                                  snapshot) {
                                            if (snapshot.hasData) {
                                              return Container(
                                                height: size.height * 0.4,
                                                child: SingleChildScrollView(
                                                  child: ColumnBuilder(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    itemCount:
                                                        snapshot.data!.length,
                                                    itemBuilder: (context, i) {
                                                      return Column(
                                                        children: [
                                                          tarjetConsultarHorario(
                                                              size,
                                                              snapshot.data![i]
                                                                  ["code"],
                                                              snapshot.data![i]
                                                                  ["name"],
                                                              snapshot.data![i]
                                                                  ["warehouse"],
                                                              snapshot.data![i]
                                                                  ["qty"],
                                                              snapshot.data![i][
                                                                  "price_selling"],
                                                              () async {
                                                            mapProduct?.removeWhere(
                                                                (item) =>
                                                                    item[
                                                                        "id"] ==
                                                                    snapshot.data![
                                                                            i]
                                                                        ["id"]);
                                                            await listaProductBlocs
                                                                .carritoGenerate(
                                                                    context,
                                                                    listProducts:
                                                                        mapProduct!);
                                                            print(mapProduct);
                                                          }),
                                                          Divider(),
                                                        ],
                                                      );
                                                    },
                                                  ),
                                                ),
                                              );
                                            } else {
                                              return Center(
                                                child: Container(
                                                  height: size.height * 0.4,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        "No hay productos agregados",
                                                        style: TextStyle(
                                                            fontSize: 20),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }
                                          },
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            print(mapProduct);
                                            if (mapProduct?.isEmpty == true ||
                                                mapProduct == null) {
                                            } else {
                                              await listaProductBlocs
                                                  .registerCarrito(context,
                                                      listProducts:
                                                          mapProduct!);
                                            }
                                          },
                                          child: Container(
                                              margin: EdgeInsets.only(
                                                  bottom: size.height * 0.01,
                                                  top: size.height * 0.01),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 14),
                                              width: size.width,
                                              decoration: BoxDecoration(
                                                color: General.colorApp,
                                                borderRadius:
                                                    BorderRadius.circular(7),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  'Registar Salida',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              )),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }
                            } else {
                              return Container(
                                height: size.height * 0.7,
                                child: Center(
                                    child: CircularProgressIndicator(
                                  color: Colors.black,
                                )),
                              );
                            }
                          })
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Container tarjetConsultarHorario(Size size, String? codigo, String? nombre,
      String? almacen, String? cantidad, String? precioCompra, Function onTap) {
    return Container(
      height: size.height * 0.2,
      width: size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: size.height * 0.12,
            width: size.width,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        codigo ?? "",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                        child: SizedBox(),
                      ),
                      Text(
                        "Precio salida: $precioCompra",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.black // Color del texto
                            ),
                      ),
                    ],
                  ),
                  Text(
                    "Nombre: $nombre",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: General.grissApp),
                  ),
                  Text(
                    "Almacen: $almacen",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: General.grissApp,
                    ),
                  ),
                  Text(
                    "Cantidad: $cantidad",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: General.grissApp,
                    ),
                  ),
                ]),
          ),
          InkWell(
            onTap: onTap as void Function()?,
            child: Container(
                margin: EdgeInsets.only(bottom: size.height * 0.01),
                padding: const EdgeInsets.symmetric(vertical: 14),
                width: size.width,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 218, 129, 122),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Center(
                  child: Text(
                    'Eliminar Producto',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                    ),
                  ),
                )),
          )
        ],
      ),
    );
  }
}

// streamBotonReactive(context) {
//   final size = MediaQuery.of(context).size;
//   return StreamBuilder<String>(
//     initialData: "INGRESAR",
//     stream: loginBloc.botonLoginS,
//     builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
//       if (snapshot.data == "INGRESAR") {
//         animated = 1;
//       } else if (snapshot.data == "ERROR") {
//         animated = 2;
//       }
//       return AnimatedContainer(
//         padding: const EdgeInsets.symmetric(vertical: 10),
//         width: size.width * 0.5 / animated,
//         curve: Curves.fastOutSlowIn,
//         duration: const Duration(seconds: 2),
//         child: InkWell(
//           onTap: () => {
//             // prefs.emailSave = userController.text,
//             // loginM.userEmail = prefs.emailSave,
//             // prefs.user = userController.text,
//             // prefs.password = passController.text,
//             // loginBloc.botonLoginC.sink.add("ERROR"),
//             // loginBloc.requestLogin(context,
//             //     user: userController.text, pass: passController.text),
//           },
//           child: Container(
//             padding: const EdgeInsets.symmetric(vertical: 10),
//             width: size.width * 0.5,
//             decoration: BoxDecoration(
//               color: General.colorApp,
//               borderRadius: BorderRadius.circular(30),
//             ),
//             child: snapshot.data == "INGRESAR"
//                 ? Center(
//                     child: Text(
//                       snapshot.data ?? '',
//                       style: TextStyle(
//                         color: Colors.white, // Cambia el color a blanco
//                         fontSize:
//                             12, // Cambia el tamaño del texto según tus necesidades
//                       ),
//                     ),
//                   )
//                 : Center(
//                     child: const CircularProgressIndicator(
//                       color: Colors.white,
//                     ),
//                   ),
//           ),
//         ),
//       );
//     },
//   );
// }
