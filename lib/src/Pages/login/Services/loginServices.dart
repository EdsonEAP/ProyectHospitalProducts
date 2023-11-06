import 'package:app2/src/Utils/ineternet.dart';

class LoginService {
  Future loginS({required String user, required String pass}) async {
    Map<String, dynamic> body = {"user": user, "password": pass};
    print("Send data Service-->loginS--> body$body");
    var response = await Internet.httpPostcook(
        url: "http://10.0.2.2:8000/api/users2/verify", body: body);
    print("Request....");
    print("Result....$response");

    return response;
  }
}
