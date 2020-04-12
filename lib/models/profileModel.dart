import 'package:flutter/material.dart';

class AdvertiserProfile {
  Data data;
  String message;
  int code;

  AdvertiserProfile({this.data, this.message, this.code});

  AdvertiserProfile.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
    code = json['code'];
  }
}

class Data {
  Advertiser advertiser;
  double rate;
  List<Adverts> adverts;
  List<Services> services;

  Data({this.advertiser, this.rate, this.adverts, this.services});

  Data.fromJson(Map<String, dynamic> json) {
    advertiser = json['advertiser'] != null
        ? new Advertiser.fromJson(json['advertiser'])
        : null;
    rate = double.tryParse(json['rate'].toString());
    if (json['adverts'] != null) {
      adverts = new List<Adverts>();
      json['adverts'].forEach((v) {
        adverts.add(new Adverts.fromJson(v));
      });
    }
    if (json['services'] != null) {
      services = new List<Services>();
      json['services'].forEach((v) {
        services.add(new Services.fromJson(v));
      });
    }
  }
}

class Advertiser with ChangeNotifier {
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
  double rate;

  Advertiser(
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

  Advertiser.fromJson(Map<String, dynamic> json) {
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
    rate = double.tryParse(json['rate'].toString());
  }
}

class Adverts {
  int id;
  int type;
  int userId;
  int serviceId;
  String image;
  String name;
  int price;
  int availableTime;
  int hours;
  String createdAt;
  String updatedAt;

  Adverts(
      {this.id,
      this.type,
      this.userId,
      this.serviceId,
      this.image,
      this.name,
      this.price,
      this.availableTime,
      this.hours,
      this.createdAt,
      this.updatedAt});

  Adverts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    userId = json['user_id'];
    serviceId = json['service_id'];
    image = json['image'];
    name = json['name'];
    price = json['price'];
    availableTime = json['available_time'];
    hours = json['hours'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

class Services {
  int id;
  String name;
  String createdAt;
  String updatedAt;

  Services({this.id, this.name, this.createdAt, this.updatedAt});

  Services.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
