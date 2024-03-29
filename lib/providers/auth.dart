import 'dart:convert';
import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/http_exception.dart';

class Auth with ChangeNotifier {
  String _token;
  String _name;
  String _surname;
  DateTime _expiryDate;
  String _userId;
  Timer _authTimer;

  static const hostAddress = "192.168.0.31:8080";

  bool get isAuth {
    return _token != null;
  }

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  String get userId {
    return _userId;
  }

  Future<void> _authenticate(
      String nationalId, String password, String urlSegment) async {
    try {
      final response = await http.post(
        // If the backend and frontend codes run on the same Wi-Fi, then host machine ip can be used for physical phones
        // It is needed to change from 192.168.0.x to host machine ip.
        Uri.http(hostAddress, 'user/$urlSegment'),

        headers: {"Content-Type": "application/json"},
        body: json.encode({
          'nationalIdentityNo': nationalId,
          'password': password,
        }),
      );

      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData['idToken'];

      final decodedToken = JwtDecoder.decode(responseData['idToken']);

      _userId = decodedToken['sub'];
      _expiryDate = DateTime.now().add(
        Duration(
          milliseconds: decodedToken['exp'],
        ),
      );
      _autoLogout();
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode(
        {
          'token': _token,
          'userId': _userId,
          'expiryDate': _expiryDate.toIso8601String(),
          'name': decodedToken['name'],
          'surname': decodedToken['surname'],
        },
      );
      prefs.setString('userData', userData);
    } catch (error) {
      throw error;
    }
  }

  Future<void> signup(String nationalId, String password) async {
    return _authenticate(nationalId, password, 'signUp');
  }

  Future<void> login(String nationalId, String password) async {
    return _authenticate(nationalId, password, 'signIn');
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;
    final expiryDate = DateTime.parse(extractedUserData['expiryDate']);

    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }
    _token = extractedUserData['token'];
    _userId = extractedUserData['userId'];
    _expiryDate = expiryDate;
    _name = extractedUserData['name'];
    _surname = extractedUserData['surname'];

    notifyListeners();
    _autoLogout();
    return true;
  }

  Future<void> logout() async {
    _token = null;
    _userId = null;
    _expiryDate = null;
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer.cancel();
    }
    final timeToExpiry = _expiryDate.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }
}
