import 'package:flutter/material.dart';
import 'package:mashghal_co/models/closersModel.dart';
import 'package:mashghal_co/models/notificationsModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Notifications with ChangeNotifier {
  String _token;
  String _userId;

  List closers = [];
  ClosersModel _closersModel;
  List notifications = [];
  NotificationsModel _notificationsModel;

  NotificationsModel get notificationsModel {
    return _notificationsModel;
  }

  //----------------------------Notifications Model-------------------------------
  Future<void> fetchNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;
    _token = extractedUserData['token'];
    _userId = extractedUserData['userId'];
    const url = 'https://mashghllkw.com/api/v1/notifications';
    try {
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_token',
      });
      final responseData = json.decode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        _notificationsModel = NotificationsModel.fromJson(responseData);
        notifications = _notificationsModel.data;
        notifyListeners();
        return _notificationsModel;
      } else {
        throw HttpException(responseData['messages']);
      }
    } catch (error) {
      throw error;
    }
  }

  //---------------------------delete Notifications-----------------------------
  Future<void> deleteNotifications(int id) async {
    const url = 'https://mashghllkw.com/api/v1/notifications/delnotification';
    try {
      var body = json.encode({
        'notification_id': id,
      });

      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_token'
      };
      final response = await http.post(url, headers: headers, body: body);
      final responseData = json.decode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
//        print(":::::::::::::::::::::::::::::::::::::::::" + response.body);
        notifyListeners();
      } else {
        throw HttpException(responseData['messages']);
      }
    } catch (error) {
      throw error;
    }
  }

  //-------------------------------add rate-------------------------------------
  Future<void> addRate(int id, double rate) async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData =
    json.decode(prefs.getString('userData')) as Map<String, Object>;
    _token = extractedUserData['token'];
    const url = 'https://mashghllkw.com/api/v1/user/rate';
    try {
      var body = json.encode({
        'order_id': id,
        'rate': rate,
      });
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_token'
      };
      final response = await http.post(url, headers: headers, body: body);
      final responseData = json.decode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        notifyListeners();
      } else {
        throw HttpException(responseData['messages']);
      }
    } catch (error) {
      throw error;
    }
  }

  //----------------------------fetchClosers------------------------------------
  Future<void> fetchClosers(String address) async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;
    _token = extractedUserData['token'];
    _userId = extractedUserData['userId'];
    const url = 'https://mashghllkw.com/api/v1/closers?';
    try {
      final response = await http.post(url, body: {
        'address': address,
      });
      final responseData = json.decode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        print(":::::::::::::::::::::::::::::::::::::::::" + response.body);
        _closersModel = ClosersModel.fromJson(responseData);
        closers = _closersModel.data.users;
        notifyListeners();
        return _closersModel;
      } else {
        throw HttpException(responseData['messages']);
      }
    } catch (error) {
      throw error;
    }
  }
}
