class UpdateStatus {
  Data data;
  String message;
  int code;

  UpdateStatus({this.data, this.message, this.code});

  UpdateStatus.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
    code = json['code'];
  }
}

class Data {
  Order order;

  Data({this.order});

  Data.fromJson(Map<String, dynamic> json) {
    order = json['order'] != null ? new Order.fromJson(json['order']) : null;
  }
}

class Order {
  int id;
  int userId;
  int advertId;
  int serviceId;
  String status;
  String availableTime;
  String hours;
  String totalPrice;
  String createdAt;
  String updatedAt;

  Order(
      {this.id,
      this.userId,
      this.advertId,
      this.serviceId,
      this.status,
      this.availableTime,
      this.hours,
      this.totalPrice,
      this.createdAt,
      this.updatedAt});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    advertId = json['advert_id'];
    serviceId = json['service_id'];
    status = json['status'];
    availableTime = json['available_time'];
    hours = json['hours'];
    totalPrice = json['total_price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
