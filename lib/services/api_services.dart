import 'dart:convert';
import 'package:cinepass_user/models/user_model.dart';
import 'package:http/http.dart' as http;

class APIServices {
  final String baseUrl = 'https://bookmyscreen.onrender.com/';

  Future<http.Response> validateSignUpGetOtp(UserModel userModel) async {
    final http.Response response;
    response = await http.post(Uri.parse('${baseUrl}getOtp'), body: {
      "signName": userModel.userName,
      "signEmail": userModel.email,
      "signPhone": userModel.phoneNumber,
      "signPassword": userModel.password,
      "signCPassword": userModel.confirmPassword
    });
    return response;
  }

  Future<http.Response> otpSubmitAPI(
      String enteredOtp, UserModel userModel) async {
    final http.Response response;
    response = await http.post(Uri.parse('${baseUrl}signUp'),
        headers: {
          'Content-type': 'application/json;charset=utf-8',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          "userSignup": {
            "signName": userModel.userName,
            "signEmail": userModel.email,
            "signPhone": userModel.phoneNumber,
            "signPassword": userModel.password,
            "signCPassword": userModel.confirmPassword
          },
          "otp": enteredOtp
        }),
        encoding: Encoding.getByName('utf-8'));
    return response;
  }

  Future<http.Response> signInAPI(String email, String password) async {
    final http.Response response;
    response = await http.post(Uri.parse('${baseUrl}signIn'),
        headers: {
          'Content-type': 'application/json;charset=utf-8',
          'Accept': 'application/json',
        },
        body: jsonEncode({"loginEmail": email, "loginPassword": password}),
        encoding: Encoding.getByName('utf-8'));
    return response;
  }

  Future<http.Response> resendOTP(String mail) async {
    http.Response response = await http.post(Uri.parse('${baseUrl}resendOtp'),
        headers: {
          'Content-type': 'application/json;charset=utf-8',
          'Accept': 'application/json',
        },
        body: jsonEncode({"signEmail": mail}),
        encoding: Encoding.getByName('utf-8'));
    return response;
  }
}
