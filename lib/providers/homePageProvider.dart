import 'package:flutter/material.dart';
import 'package:mashghal_co/models/adsModel.dart';
import 'package:mashghal_co/models/advertiserServicesModel.dart';
import 'package:http/http.dart' as http;
import 'package:mashghal_co/models/myWorksModel.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/httpException.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import '../models/allServicesDropListModel.dart';
import '../models/userHomePageModel.dart';

class HomePage with ChangeNotifier {
  AdvertiserServices _advertiserServices;
  AdvertiserServices _advertiserOffers;
  MyWorksModel _advertiserWorks;
  List<Services> dropList = [];
  ServicesDropList _servicesDropList;
  UserHomePageModel _userHomePageModel;
  AdsModel _ads;
  var dio = Dio();
  String process = '100';
  String _token;

  UserHomePageModel get userHomePageModel {
    return _userHomePageModel;
  }

  ServicesDropList get servicesDropList {
    return _servicesDropList;
  }

  AdvertiserServices get advertiserOffers {
    return _advertiserOffers;
  }

  AdvertiserServices get advertiserServices {
    return _advertiserServices;
  }

  MyWorksModel get advertiserWorks {
    return _advertiserWorks;
  }

  AdsModel get ads {
    return _ads;
  }

  //-------------------------My Services Model----------------------------
  Future<void> fetchAdvertiserServices() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;
    _token = extractedUserData['token'];
    String userId = extractedUserData['userId'];
    print(':::::::::::' + _token);
    print(':::::::::::' + userId);

    const url = 'https://mashghllkw.com/api/v1/advertiser/myservices';
    try {
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_token',
      });
      final responseData = json.decode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        print(':::::::::::' + _token);

        print(':::::::::::' + response.body);
        _advertiserServices = AdvertiserServices.fromJson(responseData);
        notifyListeners();
        return _advertiserServices;
      } else {
        throw HttpException(responseData['errors']);
      }
    } catch (error) {
      throw error;
    }
  }

  //-------------------------My offers Model----------------------------
  Future<void> fetchAdvertiserOffers() async {
    const url = 'https://mashghllkw.com/api/v1/advertiser/myoffers';
    try {
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_token',
      });
      final responseData = json.decode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        _advertiserOffers = AdvertiserServices.fromJson(responseData);
        notifyListeners();
        return _advertiserOffers;
      } else {
        throw HttpException(responseData['errors']);
      }
    } catch (error) {
      throw error;
    }
  }

  //--------------------------------My Works Model------------------------------
  Future<void> fetchAdvertiserWorks() async {
    const url = 'https://mashghllkw.com/api/v1/user/userworks';
    try {
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_token',
      });
      final responseData = json.decode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        _advertiserWorks = MyWorksModel.fromJson(responseData);
        notifyListeners();
        return _advertiserWorks;
      } else {
        throw HttpException(responseData['errors']);
      }
    } catch (error) {
      throw error;
    }
  }

  //---------------------------add service--------------------------------------
  Future<void> addService(String serviceId, String desc, String type,
      String price, String status, String offer, String availableTime) async {
    const url = 'https://mashghllkw.com/api/v1/advertiser/addservice';
    var body = json.encode({
      'service_id': serviceId,
      'desc': desc,
      'type': type,
      'price': price,
      'status': status,
      'offer': offer,
      'available_time': availableTime,
    });

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $_token',
    };
    try {
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );
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

  //------------------------delete service--------------------------------------
  Future<void> deleteService(int serviceId) async {
    const url = 'https://mashghllkw.com/api/v1/advertiser/deleteservice';
    var body = json.encode({
      'UserService_id': serviceId,
    });

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $_token',
    };
    try {
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );
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

  //---------------------------update service-----------------------------------
  Future<void> updateService(int serviceId, String serviceType, String desc,
      String type, String price, String status, String offer) async {
    const url = 'https://mashghllkw.com/api/v1/advertiser/updateservice';
    var body = json.encode({
      'UserService_id': serviceId,
      'service_id': serviceType,
      'desc': desc,
      'type': type,
      'price': price,
      'status': status,
      'offer': offer,
      'available_time': '11pm to 11am',
    });

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $_token',
    };
    try {
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );
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

  //------------------------------add Work--------------------------------------
  Future<void> addWork(List<Asset> media) async {
    const url = 'https://mashghllkw.com/api/v1/advertiser/addwork';
    var formData = FormData();
    formData.fields..add(MapEntry("ad_id", "133"));
    formData.fields..add(MapEntry("api_token", "$_token"));

    for (var rrr in media) {
      //arr.add(await MultipartFile.fromFile(await rrr.filePath,filename: rrr.name));
      formData.files.add(MapEntry(
        "media[]",
        await MultipartFile.fromFile(await rrr.filePath, filename: rrr.name),
      ));
    }
    var response = await dio.post(
      url,
      data: formData,
      onSendProgress: (int sent, int total) {
        process = (sent / total * 100).toStringAsFixed(0);
        notifyListeners();
//        print(process);
        return process;
      },
    );
  }

  //------------------------------add Video--------------------------------------
  Future<void> addVideo(File media) async {
    const url = 'https://mashghllkw.com/api/v1/advertiser/addwork';
    var formData = FormData();
    formData.fields..add(MapEntry("ad_id", "133"));
    formData.fields..add(MapEntry("api_token", "$_token"));
    formData.files.add(MapEntry(
      "media[]",
      await MultipartFile.fromFile(media.path,
          filename: media.path.split("/").last),
    ));
    var response = await dio.post(
      url,
      data: formData,
      onSendProgress: (int sent, int total) {
        process = (sent / total * 100).toStringAsFixed(0);
        notifyListeners();
        return process;
      },
    );
  }

  //---------------------------Ads Model----------------------------------------
  Future<void> fetchAds() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
    } else {
      final extractedUserData =
          json.decode(prefs.getString('userData')) as Map<String, Object>;
      _token = extractedUserData['token'];
    }
    const url = 'https://mashghllkw.com/api/v1/ads';
    try {
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_token',
      });
      final responseData = json.decode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        _ads = AdsModel.fromJson(responseData);
        notifyListeners();
        return _ads;
      } else {
        throw HttpException(responseData['errors']);
      }
    } catch (error) {
      throw error;
    }
  }

  //--------------------------Fetch dropList------------------------------------
  Future<void> fetchServicesDropList() async {
    const url = 'https://mashghllkw.com/api/v1/allservices';
    try {
      final response = await http.get(url);
      final responseData = json.decode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        _servicesDropList = ServicesDropList.fromJson(responseData);
        dropList = _servicesDropList.data.services;
        notifyListeners();
        return _servicesDropList;
      } else {
        throw HttpException(responseData['errors']);
      }
    } catch (error) {
      throw error;
    }
  }

  //-------------------------Fetch HomePage Model-------------------------------
  Future<void> fetchUserHomePage() async {
    const url = 'https://mashghllkw.com/api/v1/home';
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('userData')) {
      final extractedUserData =
          json.decode(prefs.getString('userData')) as Map<String, Object>;
      _token = extractedUserData['token'];
    }
    try {
      final response = await http.get(url);
      final responseData = json.decode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        print('::::::::::::::::::::::::::::' + response.body);
        _userHomePageModel = UserHomePageModel.fromJson(responseData);
        notifyListeners();
        return _userHomePageModel;
      } else {
        throw HttpException(responseData['errors']);
      }
    } catch (error) {
      throw error;
    }
  }
}
