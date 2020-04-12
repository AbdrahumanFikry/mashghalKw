class Login {
  Data _data;
  String _message;
  int _code;

  Login({Data data, String message, int code}) {
    this._data = data;
    this._message = message;
    this._code = code;
  }

  Data get data => _data;

  String get message => _message;

  int get code => _code;

  Login.fromJson(Map<String, dynamic> json) {
    _data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    _message = json['message'];
    _code = json['code'];
  }
}

class Data {
  User _user;

  Data({User user}) {
    this._user = user;
  }

  User get user => _user;

  Data.fromJson(Map<String, dynamic> json) {
    _user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }
}

class User {
  int _id;
  String _name;
  String _email;
  String _phone;
  String _apiToken;
  double _lat;
  double _long;
  String _address;
  String _image;
  String _role;
  String _serviceType;
  String _createdAt;
  String _updatedAt;
  double _rate;

  User(
      {int id,
      String name,
      String email,
      String phone,
      String apiToken,
      double lat,
      double long,
      String address,
      String image,
      String role,
      String serviceType,
      String createdAt,
      String updatedAt,
      double rate}) {
    this._id = id;
    this._name = name;
    this._email = email;
    this._phone = phone;
    this._apiToken = apiToken;
    this._lat = lat;
    this._long = long;
    this._address = address;
    this._image = image;
    this._role = role;
    this._serviceType = serviceType;
    this._createdAt = createdAt;
    this._updatedAt = updatedAt;
    this._rate = rate;
  }

  int get id => _id;

  String get name => _name;

  String get email => _email;

  String get phone => _phone;

  String get apiToken => _apiToken;

  double get lat => _lat;

  double get long => _long;

  String get address => _address;

  String get image => _image;

  String get role => _role;

  String get serviceType => _serviceType;

  String get createdAt => _createdAt;

  String get updatedAt => _updatedAt;

  double get rate => _rate;

  User.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _email = json['email'];
    _phone = json['phone'];
    _apiToken = json['api_token'];
    _lat = double.tryParse(json['lat'].toString());
    _long = double.tryParse(json['long'].toString());
    _address = json['address'];
    _image = json['image'];
    _role = json['role'];
    _serviceType = json['service_type'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _rate = double.tryParse(json['rate'].toString());
  }
}
