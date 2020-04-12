import 'package:flutter/material.dart';

class UserProfile {
  Data data;
  String message;
  int code;

  UserProfile({this.data, this.message, this.code});

  UserProfile.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
    code = json['code'];
  }
}

class Data {
  UserData user;

  Data({this.user});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new UserData.fromJson(json['user']) : null;
  }
}

class UserData with ChangeNotifier{
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
  String createdAt;
  String updatedAt;
  int rate;

  UserData(
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
        this.createdAt,
        this.updatedAt,
        this.rate});

  UserData.fromJson(Map<String, dynamic> json) {
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
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    rate = json['rate'];
  }
}