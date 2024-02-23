// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/login_model.dart';

class UserRepository {
  Future<void> loginUser(LoginModel loginModel) async {
    try {
      http.Response response = await http.post(
        Uri.parse('https://reqres.in/api/login'),
        //[login api integraded]
        body: loginModel.toJson(),
      );
      String body = response.body;
      // [assigning body as body response]
      if (response.statusCode == 200) {
        //[200 status code is for success]
        // print('Account created successfully');
        var data = jsonDecode(body.toString());
        //[getting body data from api and decodeing it from json to dart and storing it to  variable 'data']
        print("token for login is: ${data['token']}");
        //[printing token in json data ]
        print('login successfully');
        //
      } else {
        print('Login failed, status_code => ${response.statusCode}');
        //[printing ststus-code for checking if it getting another one except 200, if it is getting one!]
      }
    } catch (catchError) {
      print(catchError.toString());
      //[printing error, if it is getting one!]
    }
  }
}
