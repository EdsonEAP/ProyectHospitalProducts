import 'package:app2/src/Pages/FileView/fileView.dart';
import 'package:app2/src/Pages/SalidaProduct/salidaProductView.dart';
import 'package:app2/src/Pages/homeView/home.dart';
import 'package:app2/src/Pages/listadoProducts/listadoProducts.dart';
import 'package:app2/src/Pages/login/vistalongin.dart';
import 'package:app2/src/Pages/mapa/ubicanos.dart';
import 'package:app2/src/Pages/products/productsView.dart';
import 'package:app2/src/Pages/pruebapdf.dart';
import 'package:app2/src/Preferences/preferences.dart';
import 'package:flutter/material.dart';

final prefs = PreferenciasUsuario();

class DrawerGeneral {
  ListView drawerGeneral(Size size, BuildContext context) {
    return ListView(
      children: [
        Container(
          height: 100,
          child: DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, 1),
              ),
              child: Container(
                child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  SizedBox(width: size.width * 0.15),
                  Container(
                    alignment: Alignment.center,
                    height: 100,
                    width: 200,
                    child: Text(
                      prefs.nombreUsuario,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13.0,
                        fontFamily: 'Roboto',
                        color: Color(0xFF212121),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ]),
              )),
        ),
        ListTile(
          leading: Icon(
            Icons.home, // Icono de una casa
            color: Colors.black, // Color del icono
          ),
          title: Text(
            'INICIO',
            style: TextStyle(
              color: Colors.black, // Color del texto
              fontWeight: FontWeight.bold, // Texto en negrita
            ),
          ),
          onTap: () {
            Navigator.pushReplacementNamed(context, HomeView.name);

            // Aquí puedes agregar acciones para la opción 1
          },
        ),
        ListTile(
          leading: Icon(
            Icons.add, // Icono de una casa
            color: Colors.black, // Color del icono
          ),
          title: Text(
            'REGISTRO PRODUCTOS',
            style: TextStyle(
              color: Colors.black, // Color del texto
              fontWeight: FontWeight.bold, // Texto en negrita
            ),
          ),
          onTap: () {
            Navigator.pushNamed(context, ProductsView.name);
            // Aquí puedes agregar acciones para la opción 1
          },
        ),
        ListTile(
          leading: Icon(
            Icons.cloud_download, //, Icono de una casa
            color: Colors.black, // Color del icono
          ),
          title: Text(
            'REGISTRO MASIVO DE PRODUCTOS',
            style: TextStyle(
              color: Colors.black, // Color del texto
              fontWeight: FontWeight.bold, // Texto en negrita
            ),
          ),
          onTap: () {
            Navigator.pushNamed(context, FilView.name);
            // Aquí puedes agregar acciones para la opción 1
          },
        ),
        ListTile(
          leading: Icon(
            Icons.list, // Icono de una casa
            color: Colors.black, // Color del icono
          ),
          title: Text(
            'PRODUCTOS DISPONIBLE',
            style: TextStyle(
              color: Colors.black, // Color del texto
              fontWeight: FontWeight.bold, // Texto en negrita
            ),
          ),
          onTap: () {
            Navigator.pushNamed(context, ListadoProductsView.name);
            // Aquí puedes agregar acciones para la opción 1
          },
        ),
        ListTile(
          leading: Icon(
            Icons.exit_to_app, // Icono de una casa
            color: Colors.black, // Color del icono
          ),
          title: Text(
            'REGISTRAR SALIDA',
            style: TextStyle(
              color: Colors.black, // Color del texto
              fontWeight: FontWeight.bold, // Texto en negrita
            ),
          ),
          onTap: () {
            Navigator.pushNamed(context, ProductsSalidaView.name);
          },
        ),
        ListTile(
          leading: Icon(
            Icons.location_on, // Icono de una casa
            color: Colors.black, // Color del icono
          ),
          title: Text(
            'UBICANOS',
            style: TextStyle(
              color: Colors.black, // Color del texto
              fontWeight: FontWeight.bold, // Texto en negrita
            ),
          ),
          onTap: () {
            Navigator.pushNamed(context, UbicanosView.name);
          },
        ),
        ListTile(
          leading: Icon(
            Icons.exit_to_app, // Icono de una casa
            color: Colors.black, // Color del icono
          ),
          title: Text(
            'CERRAR SESIÓN',
            style: TextStyle(
              color: Colors.black, // Color del texto
              fontWeight: FontWeight.bold, // Texto en negrita
            ),
          ),
          onTap: () {
            Navigator.pushReplacementNamed(context, LoginView.name);
            // Aquí puedes agregar acciones para la opción 1
          },
        ),
      ],
    );
  }
}
