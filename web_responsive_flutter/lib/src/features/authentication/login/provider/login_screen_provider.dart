import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class AuthProvider extends ChangeNotifier {
  bool _loading = false;
  bool _isAuthenticated = false;

  bool get loading => _loading;

  bool get isAuthenticated => _isAuthenticated;

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    setLoading(true);
    try {
      http.Response response = await http.post(
        Uri.parse("https://reqres.in/api/login"),
        body: {
          "email": email,
          "password": password,
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        // Assuming a successful login will return a token or some user data
        if (responseData.containsKey('token')) {
          _isAuthenticated = true;
          if (kDebugMode) {
            print('Login successful');
          }
        } else {
          if (kDebugMode) {
            print('Login failed: Invalid response');
          }
        }
      } else {
        if (kDebugMode) {
          print('Login failed: ${response.body}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('An error occurred: ${e.toString()}');
      }
    } finally {
      setLoading(false);
      notifyListeners();
    }
  }

  void logout() {
    _isAuthenticated = false;
    notifyListeners();
  }
}

