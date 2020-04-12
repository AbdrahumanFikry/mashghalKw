import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:mashghal_co/models/SignupModel.dart';
import 'package:mashghal_co/models/forgetPasswordModel.dart';
import 'package:mashghal_co/models/httpException.dart';
import 'package:mashghal_co/models/userSignUpModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/loginModel.dart';

class Auth with ChangeNotifier {
  String _token;
  Login _login;
  SignUpModel _signUp;
  UserSignUpModel _userSignUpModel;
  ForgetPassword _forgetPassword;
  String _userId;
  String _type;

  bool get isAuth {
    return _token != null;
  }

  String get type {
    return _type;
  }

  String get token {
    if (_token != null) {
      return _token;
    }
    return null;
  }

  ForgetPassword get forgetPass {
    return _forgetPassword;
  }

  //------------------------------User Sign Up----------------------------------
  Future userSignUp(
    String name,
    String email,
    String role,
    String phone,
    String password,
  ) async {
    _type = role;
    const url = 'https://mashghllkw.com/api/v1/user/signup';
    try {
      var body = ({
        'name': name,
        'email': email,
        'phone': '+966' + phone,
        'password': password,
        'lat': '10.300000000000000710542735760100185871124267578125',
        'long': '11.300000000000000710542735760100185871124267578125',
        'address': 'maka',
        'role': role,
        'service_type': 'home',
      });
      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };
      final response = await http.post(
        url,
        body: body,
//        headers: headers
      );
      final Map responseData = json.decode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        print(responseData);
        if (responseData.containsKey('validation')) {
          List validation = [];
          validation = responseData['validation'];
          print(':::::::::validation::::::::::' + validation[0].toString());
          throw HttpException(validation[0]);
        }
        _userSignUpModel = UserSignUpModel.fromJson(responseData);
        print('success');

        _token = _userSignUpModel.data.user.apiToken.toString();
        print('$_token from sign up');
        _userId = _userSignUpModel.data.user.id.toString();
        notifyListeners();
        final prefs = await SharedPreferences.getInstance();
        final userData = {
          'token': _token,
          'userId': _userId,
          'type': _type,
        };
        print('success');

        prefs.setString('userData', json.encode(userData));

        return _userSignUpModel;
      } else {
        List validation = [];
        validation = responseData['validation'];
        print(':::::::::validation::::::::::' + validation[0].toString());
        throw HttpException(validation[0]);
      }
    } catch (error) {
      print(error);
      throw error;
    }
  }

  //------------------------advertiser Sign Up----------------------------------
  Future<void> sPSignUp(
    String lat,
    String long,
    String address,
    String name,
    String email,
    String serviceType,
    String role,
    String phone,
    String password,
    String days,
  ) async {
    _type = role;
    const url = 'https://mashghllkw.com/api/v1/user/signup?';
    try {
      final response = await http.post(
        url,
        body: {
          'name': name,
          'email': email,
          'phone': '+966' + phone,
          'password': password,
          'lat': lat,
          'long': long,
          'address': address,
          'role': role,
          'service_type': serviceType,
          'services': 'شعر - قص',
          'days': days,
        },
      );
      final responseData = json.decode(response.body);
      print(responseData);
      if (responseData.containsKey('validation')) {
        List validation = [];
        validation = responseData['validation'];
        print(':::::::::validation::::::::::' + validation[0].toString());
        throw HttpException(validation[0]);
      }
      if (response.statusCode >= 200 && response.statusCode < 300) {
        _signUp = SignUpModel.fromJson(responseData);
        _token = _signUp.data.user.apiToken;
        _userId = _signUp.data.user.id.toString();
        print(_signUp.data.verification);
        print(_signUp.data.code);
        notifyListeners();
        final prefs = await SharedPreferences.getInstance();
        final userData = json.encode(
          {
            'token': _token,
            'userId': _userId,
            'type': _type,
          },
        );
        prefs.setString('userData', userData);
        return _signUp;
      } else {
        throw HttpException(responseData['message']);
      }
    } catch (error) {
      throw error;
    }
  }

  //-----------------------------Login-----------------------------------------
  Future<void> logIn(String phone, String password, String type) async {
    _type = type;
    const url = 'https://mashghllkw.com/api/v1/user/signin';
    try {
      final response = await http.post(
        url,
        body: {
          'phone': '966' + phone,
          'password': password,
          'type': type,
        },
      );
      final responseData = json.decode(response.body);
      print('::::::::::::::::::::::::::' + response.body);
      if (responseData.containsKey('validation')) {
        String validation = responseData['validation'];
        print(':::::::::validation::::::::::' + validation.toString());
        throw HttpException(validation);
      }
      if (response.statusCode >= 200 && response.statusCode < 300) {
        _login = Login.fromJson(responseData);
        _token = _login.data.user.apiToken;
        _userId = _login.data.user.id.toString();
        notifyListeners();
        final prefs = await SharedPreferences.getInstance();
        final userData = json.encode(
          {
            'token': _token,
            'userId': _userId,
            'type': _type,
          },
        );
        prefs.setString('userData', userData);
        return _login;
      } else {
        throw HttpException(responseData['message']);
      }
    } catch (error) {
      throw error;
    }
  }

  //-----------------------------AutoLogin--------------------------------------
  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;
    _token = extractedUserData['token'];
    _userId = extractedUserData['userId'];
    _type = extractedUserData['type'];
    notifyListeners();
    return true;
  }

  //-----------------------------logout-----------------------------------------
  Future<void> logout() async {
    _token = null;
    _userId = null;
    _type = null;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  //--------------------------ForgetPassword------------------------------------
  Future<void> forgetPassword(String phone) async {
    _type = type;
    const url = 'https://mashghllkw.com/api/v1/user/send-forget-password';
    try {
      final response = await http.post(
        url,
        body: {
          'phone': phone,
        },
      );
      final responseData = json.decode(response.body);
      if (responseData.containsKey('validation')) {
        List validation = [];
        validation = responseData['validation'];
        print(':::::::::validation::::::::::' + validation[0].toString());
        throw HttpException(validation[0]);
      }
      if (response.statusCode >= 200 && response.statusCode < 300) {
        _forgetPassword = ForgetPassword.fromJson(responseData);
        notifyListeners();
        return _forgetPassword;
      } else {
        throw HttpException(responseData['message']);
      }
    } catch (error) {
      throw error;
    }
  }

  //-----------------------------VerifyNumber-----------------------------------
  Future<void> verifyNumber(String phone, String code) async {
    _type = type;
    const url = 'https://mashghllkw.com/api/v1/user/verify-forget-password';
    try {
      final response = await http.post(
        url,
        body: {
          'phone': phone,
          'code': code,
        },
      );
      final responseData = json.decode(response.body);
      if (responseData.containsKey('validation')) {
        List validation = [];
        validation = responseData['validation'];
        print(':::::::::validation::::::::::' + validation[0].toString());
        throw HttpException(validation[0]);
      }
      if (response.statusCode >= 200 && response.statusCode < 300) {
        notifyListeners();
      } else {
        throw HttpException(responseData['message']);
      }
    } catch (error) {
      throw error;
    }
  }

  Future verifyCode(String code) async {
    final pref = await SharedPreferences.getInstance();
    final x = json.decode(pref.getString('userData'))['token'];
    _type = type;

    const url = 'https://mashghllkw.com/api/v1/user/phone-verify';
    print(code);
    try {
      final response = await http.post(url, body: {
        'code': code,
      }, headers: {
        'Authorization': 'Bearer $x',
      });
      final responseData = json.decode(response.body);
      print(responseData);
      if (responseData.containsKey('validation')) {
        List validation = [];
        validation = responseData['validation'];
        print(':::::::::validation::::::::::' + validation[0].toString());
        throw HttpException(validation[0]);
      }
      if (response.statusCode >= 200 && response.statusCode < 300) {
        print(responseData);
        notifyListeners();
        print(responseData['data'] != null && responseData['data'].isNotEmpty);
        if (responseData['data'] != null && responseData['data'].isNotEmpty)
          return true;
      } else {
        print('obj $responseData');
        throw HttpException(responseData['message']);
      }
    } catch (error) {
      print(_token);
      throw error;
    }
    return false;
  }

  //-----------------------------VerifyNumber-----------------------------------
  Future<void> changePass(String newPassword, String confirmPassword) async {
    _type = type;
    const url = 'https://mashghllkw.com/api/v1/user/rechangepass';
    try {
      var body = json.encode(
        {
          'new_pass': newPassword,
          'confirm_pass': confirmPassword,
        },
      );

      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_token',
      };
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );
      final responseData = json.decode(response.body);
      if (responseData.containsKey('validation')) {
        List validation = [];
        validation = responseData['validation'];
        print(':::::::::validation::::::::::' + validation[0].toString());
        throw HttpException(validation[0]);
      }
      if (response.statusCode >= 200 && response.statusCode < 300) {
        notifyListeners();
      } else {
        throw HttpException(responseData['message']);
      }
    } catch (error) {
      throw error;
    }
  }
  //----------------------------------------------------------------------------
}
