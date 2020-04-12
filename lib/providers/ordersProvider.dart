import 'package:flutter/material.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mashghal_co/models/updateStatusModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/httpException.dart';
import '../models/orderModel.dart';

class OrdersProvider with ChangeNotifier {
  String _token;
  OrdersModel _initOrders;

//  OrdersModel _paidOrders;
//  OrdersModel _finishedOrders;
  UpdateStatus _updateToPaid;
  UpdateStatus _updateToFinished;

  List initOrders;
  List finishedOrders;
  List paidOrders;

//  OrdersModel get initOrders {
//    return _initOrders;
//  }
//
//  OrdersModel get paidOrders {
//    return _paidOrders;
//  }
//
//  OrdersModel get finishedOrders {
//    return _finishedOrders;
//  }

  UpdateStatus get updateToPaid {
    return _updateToPaid;
  }

  UpdateStatus get updateToFinished {
    return _updateToFinished;
  }

  //----------------------------init orders Model-------------------------------
  Future<void> fetchAdvertiserInitOrders(DateTime date) async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;
    _token = extractedUserData['token'];
    String dateTime;
    if (date.toString().split(' ')[0] ==
        DateTime.now().toString().split(' ')[0]) {
      dateTime = '';
    } else {
      dateTime = date.toString().split(' ')[0];
    }
//    print(":::::::::::::::::::::::::::::::::::**********************:::" +
//        dateTime);
    const url = 'https://mashghllkw.com/api/v1/user/order/all';
    try {
      var body = json.encode({
        'all': dateTime,
      });

      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_token',
      };
      print(_token);
      final response = await http.post(url, headers: headers, body: body);
//      print('::::::::::::::::::::::::::::::::::::::' + response.body);
      final responseData = json.decode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        _initOrders = OrdersModel.fromJson(responseData);
        initOrders =
            _initOrders.data.orders.where((i) => i.status == 'init').toList();
        paidOrders =
            _initOrders.data.orders.where((i) => i.status == 'payed').toList();
        finishedOrders = _initOrders.data.orders
            .where((i) => i.status == 'finished')
            .toList();
        notifyListeners();
        return _initOrders;
      } else {
        throw HttpException(responseData['message']);
      }
    } catch (error) {
      throw error;
    }
  }

//  //----------------------------Paid orders Model-------------------------------
//  Future<void> fetchAdvertiserPaidOrders() async {
//    const url = 'https://mashghllkw.com/api/v1/user/order/payed_orders';
//    try {
//      final response = await http.get(url, headers: {
//        'Content-Type': 'application/json',
//        'Authorization': 'Bearer $_token',
//      });
//      final responseData = json.decode(response.body);
//      if (response.statusCode >= 200 && response.statusCode < 300) {
//        _paidOrders = OrdersModel.fromJson(responseData);
//        notifyListeners();
//        return _paidOrders;
//      } else {
//        throw HttpException(responseData['errors']);
//      }
//    } catch (error) {
//      throw error;
//    }
//  }
//
//  //--------------------------Finished orders Model-----------------------------
//  Future<void> fetchAdvertiserFinishedOrders() async {
//    const url = 'https://mashghllkw.com/api/v1/user/order/finished_orders';
//    try {
//      final response = await http.get(url, headers: {
//        'Content-Type': 'application/json',
//        'Authorization': 'Bearer $_token',
//      });
//      final responseData = json.decode(response.body);
//      if (response.statusCode >= 200 && response.statusCode < 300) {
//        _finishedOrders = OrdersModel.fromJson(responseData);
//        notifyListeners();
//        return _finishedOrders;
//      } else {
//        throw HttpException(responseData['errors']);
//      }
//    } catch (error) {
//      throw error;
//    }
//  }

  //----------------------------Update Init To Paid-----------------------------
  Future<void> updateStatusToPaid(int id) async {
    const url = 'https://mashghllkw.com/api/v1/user/order/updatestatus';
    var body = json.encode({
      'order_id': id,
    });

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $_token',
    };
    try {
      final response = await http.post(url, headers: headers, body: body);
      final responseData = json.decode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        _updateToPaid = UpdateStatus.fromJson(responseData);
        notifyListeners();
        return _updateToPaid;
      } else {
        throw HttpException(responseData['errors']);
      }
    } catch (error) {
      throw error;
    }
  }

  //--------------------------Update Paid To Finished---------------------------
  Future<void> updateStatusToFinished(int id) async {
    const url = 'https://mashghllkw.com/api/v1/user/order/statusTofinish';
    var body = json.encode({
      'order_id': id,
    });

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $_token',
    };
    try {
      final response = await http.post(url, headers: headers, body: body);
      final responseData = json.decode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        _updateToFinished = UpdateStatus.fromJson(responseData);
        notifyListeners();
        return _updateToFinished;
      } else {
        throw HttpException(responseData['errors']);
      }
    } catch (error) {
      throw error;
    }
  }

  //------------------------------Delete Order----------------------------------
  Future<void> delete(int id) async {
    const url = 'https://mashghllkw.com/api/v1/user/order/deleteorder?';
    var body = json.encode({
      'order_id': id,
    });

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $_token',
    };
    try {
      final response = await http.post(url, headers: headers, body: body);
      final responseData = json.decode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        notifyListeners();
      } else {
        throw HttpException(responseData['errors']);
      }
    } catch (error) {
      throw error;
    }
  }

  //-----------------------------DateFilter-------------------------------------
  Future<void> dateFilter(String date) async {
    const url = 'https://mashghllkw.com/api/v1/user/order/searchorder';
    var body = json.encode({
      'date': date,
    });

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $_token',
    };
    try {
      final response = await http.post(url, headers: headers, body: body);
      final responseData = json.decode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        notifyListeners();
      } else {
        throw HttpException(responseData['message']);
      }
    } catch (error) {
      throw error;
    }
  }
}
