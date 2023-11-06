import 'package:app2/src/Pages/listadoProducts/Bloc/listadoProductsBloc.dart';
import 'package:app2/src/Pages/listadoProducts/Models/listadoProductM.dart';
import 'package:app2/src/Preferences/preferences.dart';
import 'package:app2/src/widget/classGeneral.dart';
import 'package:app2/src/widget/colum_builder.dart';
import 'package:app2/src/widget/drawer.dart';
import 'package:app2/src/widget/widgets.dart';
import 'package:flutter/material.dart';

TextEditingController citaController = TextEditingController();
int animated = 1;
String? dropdownLugar;
String? dropdownnombre;
ListadoProductBloc listaProductBlocs = ListadoProductBloc();

final prefs = PreferenciasUsuario();

class ListadoProductsView extends StatefulWidget {
  static const String name = "ListadoProductsView";

  const ListadoProductsView({Key? key}) : super(key: key);

  @override
  _ListadoProductsViewState createState() => _ListadoProductsViewState();
}

class _ListadoProductsViewState extends State<ListadoProductsView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    inicio();
    super.initState();
  }

  void inicio() async {
    citaController.text = prefs.nombreUsuario;
    await listaProductBlocs.requestListProducts(context);
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
          // Agregar un ícono de menú al AppBar

          leading: IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.black,
            ),
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
                      "PRODUCTOS DISPONIBLES",
                      style: TextStyle(color: Colors.white),
                    )),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  height: size.height * 0.9,
                  width: size.width,
                  child: Column(
                    children: [
                      // Row(
                      //   children: [
                      //     Expanded(
                      //       child: WidgetsRepetidos().inputLogin(
                      //           active: false,
                      //           seleccione: "Nombre:",
                      //           oculto: false,
                      //           controlador: citaController),
                      //     ),
                      //   ],
                      // ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
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
                                  height: size.height * 0.6,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        ColumnBuilder(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            itemCount: snapshot.data!.length,
                                            itemBuilder: (context, i) {
                                              return Column(children: [
                                                tarjetConsultarHorario(
                                                  size,
                                                  snapshot.data![i].code,
                                                  snapshot.data![i].name,
                                                  snapshot.data![i].warehouse,
                                                  snapshot.data![i].qty,
                                                  snapshot.data![i].priceBuying,
                                                  snapshot
                                                      .data![i].priceSelling,
                                                ),
                                                Divider()
                                              ]);
                                            })
                                      ],
                                    ),
                                  ),
                                );
                              }
                            } else {
                              return Center(
                                  child: CircularProgressIndicator(
                                color: Colors.black,
                              ));
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

  Container tarjetConsultarHorario(
      Size size,
      String? codigo,
      String? nombre,
      String? almacen,
      String? cantidad,
      String? precioCompra,
      String? precioVenta) {
    return Container(
      height: size.height * 0.1,
      width: size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
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
                        "Precio compra: $precioCompra",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.black // Color del texto
                            ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Nombre: $nombre",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: General.grissApp),
                      ),
                      Expanded(
                        child: SizedBox(),
                      ),
                      Text(
                        "Precio venta: $precioVenta",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.black // Color del texto
                            ),
                      ),
                    ],
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
