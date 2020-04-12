import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:mashghal_co/models/aboutAppModel.dart';
import 'package:mashghal_co/models/commisionModel.dart';
import 'package:mashghal_co/models/favouritesModel.dart';
import 'package:mashghal_co/models/profileModel.dart';
import 'package:mashghal_co/models/questionsModel.dart';
import 'package:mashghal_co/models/termsModel.dart';
import 'package:mashghal_co/models/userProfileModel.dart';
import '../models/httpException.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'dart:io';

class More with ChangeNotifier {
  var dio = Dio();
  File img;

  String _token;
  String _userId;
  AboutApp _aboutApp;
  CommissionModel _commissionModel;
  AdvertiserProfile _advertiserProfile;
  UserProfile _userProfile;
  double com = 0.0;
  QuestionModel _question;
  TermsModel _terms;
  FavouritesModel _favourites;

  CommissionModel get commissionModel {
    return _commissionModel;
  }

  FavouritesModel get favourites {
    return _favourites;
  }

  TermsModel get terms {
    return _terms;
  }

  QuestionModel get question {
    return _question;
  }

  AboutApp get aboutApp {
    return _aboutApp;
  }

  AdvertiserProfile get advertiserProfile {
    return _advertiserProfile;
  }

  UserProfile get userProfile {
    return _userProfile;
  }

  //-------------------------advertiserProfile Model----------------------------
  Future<void> fetchAdvertiserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;
    _token = extractedUserData['token'];
    _userId = extractedUserData['userId'];
    const url = 'https://mashghllkw.com/api/v1/advertiser/profile';
    try {
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_token',
      });
      final responseData = json.decode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        _advertiserProfile = AdvertiserProfile.fromJson(responseData);
        notifyListeners();
        return _advertiserProfile;
      } else {
        throw HttpException(responseData['errors']);
      }
    } catch (error) {
      throw error;
    }
  }

  //---------------------------aboutApp Model-----------------------------------
  Future<void> fetchAboutApp() async {
    const url = 'https://mashghllkw.com/api/v1/info';
    try {
      final response = await http.get(url);
      final responseData = json.decode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        _aboutApp = AboutApp.fromJson(responseData);
        notifyListeners();
        return _aboutApp;
      } else {
        throw HttpException(responseData['errors']);
      }
    } catch (error) {
      throw error;
    }
  }

  //------------------------------Edit Profile----------------------------------
  Future<void> editProfile(
    String name,
    String email,
    String phone,
    String serviceType,
    File image,
//    String days,
    String password,
    String lat,
    String long,
    String address,
  ) async {
    const url = 'https://mashghllkw.com/api/v1/user/updateadvertiser';
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;
    _token = extractedUserData['token'];
    _userId = extractedUserData['userId'];
    try {
      print(':::::' + name);
      print(':::::' + email);
      print(':::::' + phone);
      print(':::::' + lat);
      print(':::::' + long);
      print(':::::' + address);
      print(':::::' + serviceType);
      print(':::::' + image.toString());
      print(':::::' + password);
      print(':::::' + _userId);
      var formData = FormData();
      formData.fields..add(MapEntry('api_token', _token));
      formData.fields..add(MapEntry('name', name));
      formData.fields..add(MapEntry('email', email));
      formData.fields..add(MapEntry('phone', phone));
      formData.fields..add(MapEntry('lat', lat));
      formData.fields..add(MapEntry('long', long));
      formData.fields..add(MapEntry('address', address));
      formData.fields..add(MapEntry('service_type', serviceType));
      if (image != null)
        formData.files.add(MapEntry(
          'image',
          await MultipartFile.fromFile(image.path,
              filename: image.path.split("/").last),
        ));
//      formData.fields..add(MapEntry('days', days));
      formData.fields..add(MapEntry('password', password));
      formData.fields..add(MapEntry('user_id', _userId));
      var response = await dio.post(
        url,
        data: formData,

//        options: Options(
//            followRedirects: false,
//            validateStatus: (status) {
//              return status == 500;
//            }),
      );
      print(':::::::::::::::' + response.toString());
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  //----------------------------Fetch commission--------------------------------
  Future<void> commissions(commission, File image) async {
    const url = 'https://mashghllkw.com/api/v1/advertiser/commission';
    try {
      var formData = FormData();
      formData.fields..add(MapEntry('api_token', _token));
      formData.fields..add(MapEntry('total', commission));
      if (image != null)
        formData.files.add(MapEntry(
          'image',
          await MultipartFile.fromFile(image.path,
              filename: image.path.split("/").last),
        ));
      var response = await dio.post(
        url,
        data: formData,
      );
      Map responseBody = response.data;
      _commissionModel = CommissionModel.fromJson(responseBody);
      com = _commissionModel.data.commission.commissions;
      notifyListeners();
      return com;
    } catch (error) {
      throw error;
    }
  }

  //------------------------------rareQuestionModel-----------------------------
  Future<void> fetchQuestions() async {
    const url = 'https://mashghllkw.com/api/v1/questions';
    try {
      final response = await http.get(url);

      final responseData = json.decode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        _question = QuestionModel.fromJson(responseData);
        notifyListeners();
        return _question;
      } else {
        throw HttpException(responseData['errors']);
      }
    } catch (error) {
      throw error;
    }
  }

  //----------------------------User Profile Model------------------------------
  Future<void> fetchUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;
    _token = extractedUserData['token'];
    _userId = extractedUserData['userId'];
    const url = 'https://mashghllkw.com/api/v1/user/profile';
    try {
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_token',
      });
      final responseData = json.decode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        _userProfile = UserProfile.fromJson(responseData);
        notifyListeners();
        return _userProfile;
      } else {
        throw HttpException(responseData['errors']);
      }
    } catch (error) {
      throw error;
    }
  }

  //---------------------------edit User Profile--------------------------------
  Future<void> editUserProfile(
    String name,
    String email,
    String phone,
    File image,
    String password,
  ) async {
    const url = 'https://mashghllkw.com/api/v1/user/updateuser';
    try {
      var formData = FormData();
      formData.fields..add(MapEntry('api_token', _token));
      formData.fields..add(MapEntry('name', name));
      formData.fields..add(MapEntry('phone', phone));
      formData.fields..add(MapEntry('email', email));
      formData.fields..add(MapEntry('password', password));
      formData.fields..add(MapEntry('lat', '0'));
      formData.fields..add(MapEntry('long', '0'));
      formData.fields..add(MapEntry('service_type', 'home'));
      if (image != null)
        formData.files.add(MapEntry(
          'image',
          await MultipartFile.fromFile(image.path,
              filename: image.path.split("/").last),
        ));
      formData.fields..add(MapEntry('address', 'ddd'));
      formData.fields..add(MapEntry('user_id', _userId));
      var response = await dio.post(
        url,
        data: formData,
//        options: Options(
//            followRedirects: false,
//            validateStatus: (status) {
//              return status == 500;
//            }),
      );
      print(':::::::::::::' + response.toString());
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  //------------------------------rareQuestionModel-----------------------------
  Future<void> fetchTerms(String type) async {
    const url = 'https://mashghllkw.com/api/v1/roles';
    try {
      final response = await http.post(url, body: {
        'type': type,
      });
      final responseData = json.decode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
//        print('::::::::::::::::::::::::::::::::::::::::::::::' + response.body);
        _terms = TermsModel.fromJson(responseData);
        notifyListeners();
        return _terms;
      } else {
        throw HttpException(responseData['errors']);
      }
    } catch (error) {
      throw error;
    }
  }

  //-----------------------------Fetch favourite--------------------------------
  Future<void> fetchFavourite() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;
    _token = extractedUserData['token'];
    const url = 'https://mashghllkw.com/api/v1/user/favourites';
    try {
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_token',
      });
      final responseData = json.decode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        _favourites = FavouritesModel.fromJson(responseData);
        notifyListeners();
        return _favourites;
      } else {
        throw HttpException(responseData['errors']);
      }
    } catch (error) {
      throw error;
    }
  }

  //------------------------------Delete fav------------------------------------
  Future<void> deleteFav(int id) async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;
    _token = extractedUserData['token'];
    const url = 'https://mashghllkw.com/api/v1/user/deletefav';
    var body = json.encode({
      'fav_id': id,
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

  //-------------------------Notifications clear--------------------------------
  Future<void> notificationsStatus(int userId, int status) async {
    const url = 'https://mashghllkw.com/api/v1/user/updatenotify';
    try {
      var body = json.encode({
        'user_id': userId,
        'notification': status,
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
        throw HttpException(responseData['message']);
      }
    } catch (error) {
      throw error;
    }
  }
}
