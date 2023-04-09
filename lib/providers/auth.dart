import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopapp/models/http_exception.dart';

//remember to change to with
class Auth extends ChangeNotifier {
  // String _token;
  // DateTime _expiryDate;
  // String _userId;
  final String _api_key = ""; //enter your firebase api key here

  Future<void> signUp(String email, String password) async {
    final url =
        "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_api_key";

    try {
      final response = await http.post(Uri.parse(url),
          body: json.encode({
            "email": email,
            "password": password,
            "returnSecureToken": true,
          }));

      print(response.body);
    } catch (error) {
      throw HttpException("An error occured");
    }
  }
}
