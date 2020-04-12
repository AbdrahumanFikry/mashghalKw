import 'package:flutter/material.dart';
import 'package:mashghal_co/models/coiffieurModel.dart';
import 'package:mashghal_co/models/dayHourModel.dart';
import 'package:mashghal_co/models/favModel.dart';
import 'package:mashghal_co/models/reservationModel.dart';
import 'package:mashghal_co/models/serviceModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/httpException.dart';

class Reservations with ChangeNotifier {
  String _token;

  ReservationsModel _reservationsModel;
  CoiffeurDetailsModel _coiffeurDetails;
  DaysHourModel _dayHourModel;
  FavModel favModel;
  List initOrders;
  List finishedOrders;
  List<ServicesIds> ordersId = [];
  ServiceModel services;
  List<Details> order = [];

  ReservationsModel get reservationsModel {
    return _reservationsModel;
  }

  CoiffeurDetailsModel get coiffeurDetails {
    return _coiffeurDetails;
  }

  DaysHourModel get dayHourModel {
    return _dayHourModel;
  }

  //----------------------------init orders Model-------------------------------
  Future<void> fetchReservations(String date) async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;
    _token = extractedUserData['token'];
    const url = 'https://mashghllkw.com/api/v1/user/order/all';
    try {
      var body = json.encode({
        'all': date,
      });

      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_token',
      };
      final response = await http.post(url, headers: headers, body: body);
      final responseData = json.decode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        _reservationsModel = ReservationsModel.fromJson(responseData);
        initOrders = _reservationsModel.data.orders
            .where((i) => i.status == 'init')
            .toList();
        finishedOrders = _reservationsModel.data.orders
            .where((i) => i.status == 'finished')
            .toList();
        notifyListeners();
        return _reservationsModel;
      } else {
        throw HttpException(responseData['errors']);
      }
    } catch (error) {
      throw error;
    }
  }

  //------------------------------Delete Order----------------------------------
  Future<void> deleteReservation(int id, String type) async {
    const url = 'https://mashghllkw.com/api/v1/user/order/deleteorder?';
    var body = json.encode({
      'order_id': id,
    });

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $_token',
    };
    try {
      if (type == 'init') {
        final index = initOrders.indexWhere((i) => i.id == id);
        final response = await http.post(url, headers: headers, body: body);
        final responseData = json.decode(response.body);
        if (response.statusCode >= 200 && response.statusCode < 300) {
          initOrders.removeAt(index);
          notifyListeners();
        } else {
          throw HttpException(responseData['errors']);
        }
      } else {
        final index = finishedOrders.indexWhere((i) => i.id == id);
        final response = await http.post(url, headers: headers, body: body);
        final responseData = json.decode(response.body);
        if (response.statusCode >= 200 && response.statusCode < 300) {
          finishedOrders.removeAt(index);
          notifyListeners();
        } else {
          throw HttpException(responseData['errors']);
        }
      }
    } catch (error) {
      throw error;
    }
  }

  //-----------------------------coiffeurDetails--------------------------------
  Future<void> fetchCoiffeurDetails(int id) async {
    print(':::::::id::::::::' + id.toString());
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('userData')) {
      final extractedUserData =
      json.decode(prefs.getString('userData')) as Map<String, Object>;
      _token = extractedUserData['token'];
    }

    const url = 'https://mashghllkw.com/api/userdetails';
//    var body = {
//      'user_id': id,
//    };

//    Map<String, String> headers = {
//      'Content-Type': 'application/json',
//      'Authorization': 'Bearer $_token',
//    };
    try {
      final response = await http.post(url, body: {
        'user_id': id.toString(),
      });
      final responseData = json.decode(response.body);
      print('::::::::::::::::::::::Coffier ::::::::::::::::::' + responseData.toString());
      if (response.statusCode >= 200 && response.statusCode < 300) {
        _coiffeurDetails = CoiffeurDetailsModel.fromJson(responseData);
        notifyListeners();
        return _coiffeurDetails;
      } else {
        throw HttpException(responseData['errors']);
      }
    } catch (error) {
      print(error);
      throw error;
    }
  }

  //-----------------------------make favourite --------------------------------
  Future<void> makeFav(int id) async {
    const url = 'https://mashghllkw.com/api/v1/user/favourite';
    var body = json.encode({
      'advertiser_id': id,
    });

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $_token',
    };
    try {
      final response = await http.post(url, headers: headers, body: body);
      final responseData = json.decode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        favModel = FavModel.fromJson(responseData);
        notifyListeners();
        return favModel;
      } else {
        throw HttpException(responseData['errors']);
      }
    } catch (error) {
      throw error;
    }
  }

  //-----------------------------make favourite --------------------------------
  Future<void> fetchDays(int id) async {
    const url = 'https://mashghllkw.com/api/v1/user/userdays';

    var body = json.encode({
      'advertiser_id': id,
    });
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $_token',
    };
    try {
      final response = await http.post(url, headers: headers, body: body);
      final responseData = json.decode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        _dayHourModel = DaysHourModel.fromJson(responseData);
        notifyListeners();
        return _dayHourModel;
      } else {
        throw HttpException(responseData['message']);
      }
    } catch (error) {
      throw error;
    }
  }

  //-------------------------------add order------------------------------------
  Future<void> addOrder(String services, int ownerId) async {
    const url = 'https://mashghllkw.com/api/v1/user/order/add';
    var body = json.encode({
      'services': services,
      'owner_id': ownerId,
    });

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $_token',
    };
    try {
      final response = await http.post(url, headers: headers, body: body);
      final responseData = json.decode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
//        print('::::::::::::::::::::::::::::bill:::::::::::::::::' +
//            response.body);
        notifyListeners();
      } else {
        throw HttpException(responseData['errors']);
      }
    } catch (error) {
      throw error;
    }
  }
}
