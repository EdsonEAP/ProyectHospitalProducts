import 'package:app2/src/Preferences/preferences.dart';
import 'package:app2/src/Utils/ineternet.dart';
import 'package:url_launcher/url_launcher.dart';

class SalidaProductService {
  PreferenciasUsuario prefs = PreferenciasUsuario();
  Future salidaServices() async {
    var response =
        await Internet.httpGet(url: "http://10.0.2.2:8000/products", body: "");
    print("Request....");
    print("Result....$response");
    return response;
  }

  Future registerProducSalida(
      {required List<Map<String, dynamic>> dataRegisterProducts}) async {
    Map<String, dynamic> body = {
      "user": prefs.documentoDni,
      "name": prefs.nombreUsuario,
      "products": dataRegisterProducts
    };
    print("Envio al servicio-->registerProducSalida--> body$body");
    var response = await Internet.httpPostcookRow(
        url: "http://10.0.2.2:8000/api/products/salida", body: body);
    print("Resultado del servicio....$response");
    return response;
  }
}
