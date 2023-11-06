import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class FileService {
  Future fileService({required File file}) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse("http://10.0.2.2:8000/api/products/massive"),
    );

    var fileStream = file.openRead();
    var length = await file.length();

    request.files.add(
      http.MultipartFile(
        'file',
        fileStream.cast(),
        length,
        filename: file.path.split('/').last,
      ),
    );

    var response = await request.send();
    String responseString;

    if (response.statusCode == 200) {
      responseString = await response.stream.bytesToString();
      print("Response: $responseString");
    } else {
      print("Error en la solicitud HTTP: ${response.statusCode}");
      throw Exception('Error en la solicitud HTTP');
    }

    return responseString;
  }
}


// import 'dart:io';

// import 'package:app2/src/Utils/ineternet.dart';

// class FileService {
//   Future fileService({required File file}) async {
//     var fileBytes = await file.readAsBytes();
//     var base64File = base64Encode(fileBytes);

//     Map<String, dynamic> body = {
//       "file": base64File,
//     };
//     Map<String, dynamic> body = {
//       "file": file.path,
//     };
//     print("Send data Service-->loginS--> body$body");
//     var response = await Internet.httpPostcook(
//         url: "http://10.0.2.2:8000/api/products/massive", body: body);
//     print("Request....");
//     print("Result....$response");

//     return response;
//   }
// }
