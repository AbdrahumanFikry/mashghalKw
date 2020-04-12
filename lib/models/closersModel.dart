class ClosersModel {
  Data data;
  String message;
  int code;

  ClosersModel({this.data, this.message, this.code});

  ClosersModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
    code = json['code'];
  }
}

class Data {
  List<Users> users;

  Data({this.users});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['users'] != null) {
      users = new List<Users>();
      json['users'].forEach((v) {
        users.add(new Users.fromJson(v));
      });
    }
  }
}

class Users {
  int id;
  String name;
  double lat;
  double long;

  Users({this.id, this.name, this.lat, this.long});

  Users.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    lat = json['lat'];
    long = json['long'];
  }
}