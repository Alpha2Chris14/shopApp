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
      String email, String password, String urlSegment) async {
    var url =
        "https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=$_api_key";

    try {
      final response = await http.post(Uri.parse(url),
          body: json.encode({
            "email": email,
            "password": password,
            "returnSecureToken": true,
          }));
      final responseData = json.decode(response.body);
      print(responseData);
      if (responseData["error"] != null) {
        throw HttpException(responseData['error']['message']);
      }
    } catch (error) {
      // print("something went wrong....check am out");
      throw error;
    }
  }

  Future<void> signUp(String email, String password) async {
    return _authenticated(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return _authenticated(email, password, 'signInWithPassword');
  }
}
