import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopapp/models/http_exception.dart';

//remember to change to with
class Auth extends ChangeNotifier {
  // String _token;
  // DateTime _expiryDate;
  // String _userId;
  final String _api_key =
      "AIzaSyBOCeSkckZZoldHaJMkRXwP0tfrWHy4MI0"; //enter your firebase api key here

  Future<void> _authenticated(
      String email, String password, String urlPath) async {
    final url = urlPath;

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

  Future<void> signUp(String email, String password) async {
    final url =
        "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_api_key";
    return _authenticated(email, password, url);
  }

  Future<void> login(String email, String password) async {
    final url =
        "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_api_key";
    return _authenticated(email, password, url);
  }
}
