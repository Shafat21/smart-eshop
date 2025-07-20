import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../utils/shared_prefs.dart';

class AuthProvider extends ChangeNotifier {
  String? _token;
  String? _username;
  String? _name;
  String? _email;
  String? _phone;
  String? _address;

  bool get isLoggedIn => _token != null;
  String? get token    => _token;
  String? get username => _username;
  String? get name     => _name;
  String? get email    => _email;
  String? get phone    => _phone;
  String? get address  => _address;

  AuthProvider() {
    _token    = SharedPrefs.getToken();
    _username = SharedPrefs.getUsername();
    _name     = SharedPrefs.getName();
    _email    = SharedPrefs.getEmail();
    _phone    = SharedPrefs.getPhone();
    _address  = SharedPrefs.getAddress();
  }

  Future<bool> login(String username, String password) async {
    final token = await AuthService.login(username, password);
    if (token != null) {
      _token    = token;
      _username = username;
      // Name/email/etc remain from previous register (or null)
      await SharedPrefs.setToken(token);
      await SharedPrefs.setUsername(username);
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> register({
    required String name,
    required String address,
    required String phone,
    required String email,
    required String username,
    required String password,
  }) async {
    final ok = await AuthService.register(
      name: name,
      address: address,
      phone: phone,
      email: email,
      username: username,
      password: password,
    );
    if (ok) {
      // persist all fields
      _name     = name;
      _address  = address;
      _phone    = phone;
      _email    = email;
      _username = username;
      await SharedPrefs.setName(name);
      await SharedPrefs.setAddress(address);
      await SharedPrefs.setPhone(phone);
      await SharedPrefs.setEmail(email);
      await SharedPrefs.setUsername(username);
      notifyListeners();
    }
    return ok;
  }

  Future<void> logout() async {
    _token = null;
    _username = null;
    _name     = null;
    _email    = null;
    _phone    = null;
    _address  = null;
    await SharedPrefs.clearToken();
    await SharedPrefs.clearUsername();
    await SharedPrefs.clearName();
    await SharedPrefs.clearEmail();
    await SharedPrefs.clearPhone();
    await SharedPrefs.clearAddress();
    notifyListeners();
  }
}
