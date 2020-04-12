import 'package:flutter/material.dart';

class UserHomePageModel {
  Data data;
  String message;
  int code;

  UserHomePageModel({this.data, this.message, this.code});

  UserHomePageModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
    code = json['code'];
  }
}

class Data {
  List<CategoryModel> salons;
  List<CategoryModel> homes;
  List<Offers> offers;

  Data({this.salons, this.homes, this.offers});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['salons'] != null) {
      salons = new List<CategoryModel>();
      json['salons'].forEach((v) {
        salons.add(new CategoryModel.fromJson(v));
      });
    }
    if (json['homes'] != null) {
      homes = new List<CategoryModel>();
      json['homes'].forEach((v) {
        homes.add(new CategoryModel.fromJson(v));
      });
    }
    if (json['offers'] != null) {
      offers = new List<Offers>();
      json['offers'].forEach((v) {
        offers.add(new Offers.fromJson(v));
      });
    }
  }
}

class CategoryModel with ChangeNotifier {
  int id;
  String name;
  String email;
  String phone;
  String apiToken;
  double lat;
  double long;
  String address;
  String image;
  String role;
  String serviceType;
  int notification;
  String code;
  String createdAt;
  String updatedAt;
  double rate;

  CategoryModel(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.apiToken,
      this.lat,
      this.long,
      this.address,
      this.image,
      this.role,
      this.serviceType,
      this.notification,
      this.code,
      this.createdAt,
      this.updatedAt,
      this.rate});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    apiToken = json['api_token'];
    lat = double.tryParse(json['lat'].toString());
    long = double.tryParse(json['long'].toString());
    address = json['address'];
    image = json['image'];
    role = json['role'];
    serviceType = json['service_type'];
    notification = json['notification'];
    code = json['code'] == null ? ' ' : json['code'].toString();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    rate = double.tryParse(json['rate'].toString());
  }
}

class Offers with ChangeNotifier {
  int id;
  int userId;
  int serviceId;
  int adId;
  String desc;
  String price;
  String type;
  int status;
  String offer;
  String availableTime;
  int hours;
  String createdAt;
  String updatedAt;

  Offers(
      {this.id,
      this.userId,
      this.serviceId,
      this.adId,
      this.desc,
      this.price,
      this.type,
      this.status,
      this.offer,
      this.availableTime,
      this.hours,
      this.createdAt,
      this.updatedAt});

  Offers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    serviceId = json['service_id'];
    adId = json['ad_id'];
    desc = json['desc'];
    price = json['price'];
    type = json['type'];
    status = json['status'];
    offer = json['offer'];
    availableTime = json['available_time'];
    hours = json['hours'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
