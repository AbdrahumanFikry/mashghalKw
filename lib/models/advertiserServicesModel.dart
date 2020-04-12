import 'package:flutter/cupertino.dart';

class AdvertiserServices {
  Data data;
  String message;
  int code;

  AdvertiserServices({this.data, this.message, this.code});

  AdvertiserServices.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
    code = json['code'];
  }
}

class Data {
  List<Service> services;

  Data({this.services});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['services'] != null) {
      services = new List<Service>();
      json['services'].forEach((v) {
        services.add(new Service.fromJson(v));
      });
    }
  }
}

class Service with ChangeNotifier {
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

  Service(
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

  Service.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    serviceId = json['service_id'];
    adId = json['ad_id'] == null ? 0 : json['ad_id'];
    desc = json['desc'];
    price = json['price'];
    type = json['type'];
    status = json['status'];
    offer = json['offer'];
    availableTime = json['available_time'];
    hours = int.tryParse(json['hours']);
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
