class SignUpModel {
  Data data;
  String message;
  int code;

  SignUpModel({this.data, this.message, this.code});

  SignUpModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
    code = json['code'];
  }
}

class Data {
  User user;
  List<Days> days;
  String code;
  int verification;

  Data({this.user, this.days, this.code, this.verification});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    if (json['days'] != null) {
      days = new List<Days>();
      json['days'].forEach((v) {
        days.add(new Days.fromJson(v));
      });
    }
    code = json['code'];
    verification = json['verification'];
  }
}

class User {
  String name;
  String email;
  int phone;
  String apiToken;
  String role;
  String address;
  String lat;
  String long;
  String serviceType;
  String updatedAt;
  String createdAt;
  int id;
  double rate;

  User(
      {this.name,
        this.email,
        this.phone,
        this.apiToken,
        this.role,
        this.address,
        this.lat,
        this.long,
        this.serviceType,
        this.updatedAt,
        this.createdAt,
        this.id,
        this.rate});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    apiToken = json['api_token'];
    role = json['role'];
    address = json['address'];
    lat = json['lat'];
    long = json['long'];
    serviceType = json['service_type'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
    rate = double.tryParse(json['rate'].toString());
  }
}

class Days {
  int id;
  int userId;
  String day;
  String startTime;
  String endTime;
  int status;
  String createdAt;
  String updatedAt;

  Days(
      {this.id,
        this.userId,
        this.day,
        this.startTime,
        this.endTime,
        this.status,
        this.createdAt,
        this.updatedAt});

  Days.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    day = json['day'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}