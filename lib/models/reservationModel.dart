class ReservationsModel {
  Data data;
  String message;
  int code;

  ReservationsModel({this.data, this.message, this.code});

  ReservationsModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
    code = json['code'];
  }
}

class Data {
  List<Orders> orders;

  Data({this.orders});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['orders'] != null) {
      orders = new List<Orders>();
      json['orders'].forEach((v) {
        orders.add(new Orders.fromJson(v));
      });
    }
  }
}

class Orders {
  int id;
  int userId;
  String username;
  String userImage;
  String status;
  String availableTime;
  String hours;
  String totalPrice;
  CreatedAt createdAt;
  CreatedAt updatedAt;
  List<Services> services;

  Orders(
      {this.id,
        this.userId,
        this.username,
        this.userImage,
        this.status,
        this.availableTime,
        this.hours,
        this.totalPrice,
        this.createdAt,
        this.updatedAt,
        this.services});

  Orders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    username = json['username'];
    userImage = json['userimage'];
    status = json['status'];
    availableTime = json['available_time'];
    hours = json['hours'];
    totalPrice = json['total_price'];
    createdAt = json['created_at'] != null
        ? new CreatedAt.fromJson(json['created_at'])
        : null;
    updatedAt = json['updated_at'] != null
        ? new CreatedAt.fromJson(json['updated_at'])
        : null;
    if (json['services'] != null) {
      services = new List<Services>();
      json['services'].forEach((v) {
        services.add(new Services.fromJson(v));
      });
    }
  }
}

class CreatedAt {
  String date;
  int timezoneType;
  String timezone;

  CreatedAt({this.date, this.timezoneType, this.timezone});

  CreatedAt.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    timezoneType = json['timezone_type'];
    timezone = json['timezone'];
  }
}

class Services {
  int id;
  int orderId;
  int userId;
  int serviceId;
  UserService userService;

  Services(
      {this.id, this.orderId, this.userId, this.serviceId, this.userService});

  Services.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    userId = json['user_id'];
    serviceId = json['service_id'];
    userService = json['user_service'] != null
        ? new UserService.fromJson(json['user_service'])
        : null;
  }
}

class UserService {
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

  UserService(
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

  UserService.fromJson(Map<String, dynamic> json) {
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