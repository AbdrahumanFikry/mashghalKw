class AboutApp  {
  Data data;
  String message;
  int code;

  AboutApp({this.data, this.message, this.code});

  AboutApp.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['message'] = this.message;
    data['code'] = this.code;
    return data;
  }
}

class Data {
  Info info;

  Data({this.info});

  Data.fromJson(Map<String, dynamic> json) {
    info = json['info'] != null ? new Info.fromJson(json['info']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.info != null) {
      data['info'] = this.info.toJson();
    }
    return data;
  }
}

class Info {
  String phone;
  String email;
  String address;
  String about;
  String privacy;
  String role;

  Info(
      {this.phone,
      this.email,
      this.address,
      this.about,
      this.privacy,
      this.role});

  Info.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    email = json['email'];
    address = json['address'] == null ? 'data' : json['address'];
    about = json['about'];
    privacy = json['privacy'] == null ? 'data' : json['privacy'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['address'] = this.address;
    data['about'] = this.about;
    data['privacy'] = this.privacy;
    data['role'] = this.role;
    return data;
  }
}
