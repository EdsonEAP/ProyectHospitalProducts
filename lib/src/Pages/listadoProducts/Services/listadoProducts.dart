import 'package:app2/src/Utils/ineternet.dart';

class ListoProductService {
  Future listadoProductS() async {
    var response =
        await Internet.httpGet(url: "http://10.0.2.2:8000/products", body: "");
    print("Request....");
    print("Result....$response");
    return response;
  }
}
