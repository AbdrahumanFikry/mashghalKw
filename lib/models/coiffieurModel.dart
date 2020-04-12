import 'package:flutter/material.dart';

class CoiffeurDetailsModel {
  Data data;
  String message;
  int code;

  CoiffeurDetailsModel({this.data, this.message, this.code});

  CoiffeurDetailsModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
    code = json['code'];
  }
}

class Data with ChangeNotifier {
  String advertiserName;
  String advertiserImage;
  int fav;
  int favId;
  List<CoiffeurServices> services;
  List<CoiffeurServices> offers;
  List<Works> works;

  Data(
      {this.advertiserName,
      this.advertiserImage,
      this.fav,
      this.favId,
      this.services,
      this.offers,
      this.works});

  Data.fromJson(Map<String, dynamic> json) {
    advertiserName = json['advertiser_name'];
    advertiserImage = json['advertiser_image'] == null?'':json['advertiser_image'];
    fav = json['fav'] == null? 0 :json['fav'] ;
    favId = json['fav_id']==null? 0 : int.tryParse(json['fav_id'].toString());
    if (json['services'] != null) {
      services = new List<CoiffeurServices>();
      json['services'].forEach((v) {
        services.add(new CoiffeurServices.fromJson(v));
      });
    }
    if (json['offers'] != null) {
      offers = new List<CoiffeurServices>();
      json['offers'].forEach((v) {
        offers.add(new CoiffeurServices.fromJson(v));
      });
    }
    if (json['works'] != null) {
      works = new List<Works>();
      json['works'].forEach((v) {
        works.add(new Works.fromJson(v));
      });
    }
  }
}

class CoiffeurServices with ChangeNotifier {
  int serviceId;
  String serviceName;
  List<Details> details;
  int users;

  CoiffeurServices(
      {this.serviceId, this.serviceName, this.details, this.users});

  CoiffeurServices.fromJson(Map<String, dynamic> json) {
    serviceId = json['service_id'];
    serviceName = json['service_name'];
    if (json['details'] != null) {
      details = new List<Details>();
      json['details'].forEach((v) {
        details.add(new Details.fromJson(v));
      });
    }
    users = json['users'];
  }
}

class Details with ChangeNotifier {
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
  double rate;
  String createdAt;
  String updatedAt;

  Details(
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
      this.rate,
      this.createdAt,
      this.updatedAt});

  Details.fromJson(Map<String, dynamic> json) {
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
    rate = double.tryParse(json['rate'].toString());
    createdAt = json['create d_at'];
    updatedAt = json['updated_at'];
  }
}

class Works with ChangeNotifier {
  int id;
  int userId;
  String media;

  Works({this.id, this.userId, this.media});

  Works.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    media = json['media'];
  }
}
