class UserSignUpModel {
  Data data;
  String message;
  int code;

  UserSignUpModel({this.data, this.message, this.code});

  UserSignUpModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
    code = json['code'];
  }
}

class Data {
  User user;
  List days;
  String code;
  int verification;

  Data({this.user, this.days, this.code, this.verification});

  Data.fromJson(Map<dynamic, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
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