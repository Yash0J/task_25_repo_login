// ignore_for_file: avoid_print

// import 'dart:convert';
// import 'package:http/http.dart' as http;

class LoginModel {
  String email;
  String password;

  LoginModel({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }

  // void login(LoginModel loginModel) async {
  //   try {
  //     http.Response response = await http.post(
  //       Uri.parse('https://reqres.in/api/login'),
  //       body: loginModel.toJson(),
  //     );
  //     String body = response.body;
  //     if (response.statusCode == 200) {
  //       var data = jsonDecode(body);
  //       print("token for login is: ${data['token']}");
  //       print('login successfully');
  //     } else {
  //       print('Login failed, status_code => ${response.statusCode}');
  //     }
  //   } catch (error) {
  //     print(error.toString());
  //   }
  // }
}
