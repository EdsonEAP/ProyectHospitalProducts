import 'package:app2/src/Utils/ineternet.dart';

class ProductsService {
  Future producServices(
      {required String code,
      required String name,
      required String warehouse,
      required String qty,
      required String price_buying,
      required String price_selling,
      required String user}) async {
    Map<String, dynamic> body = {
      "code": code,
      "name": name,
      "warehouse": warehouse,
      "qty": qty,
      "price_buying": price_buying,
      "price_selling": price_selling,
      "user": user
    };
    print("Send data Service-->loginS--> body$body");
    var response = await Internet.httpPostcook(
        url: "http://10.0.2.2:8000/products", body: body);
    print("Request....");
    print("Result....$response");

    return response;
  }
}
