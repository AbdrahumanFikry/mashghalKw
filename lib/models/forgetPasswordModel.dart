class ForgetPassword {
  Data _data;
  String _message;
  int _code;

  ForgetPassword({Data data, String message, int code}) {
    this._data = data;
    this._message = message;
    this._code = code;
  }

  Data get data => _data;
  String get message => _message;
  int get code => _code;

  ForgetPassword.fromJson(Map<String, dynamic> json) {
    _data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    _message = json['message'];
    _code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._data != null) {
      data['data'] = this._data.toJson();
    }
    data['message'] = this._message;
    data['code'] = this._code;
    return data;
  }
}

class Data {
  String _userPhone;
  int _verifyNum;

  Data({String userPhone, int verifyNum}) {
    this._userPhone = userPhone;
    this._verifyNum = verifyNum;
  }

  String get userPhone => _userPhone;
  int get verifyNum => _verifyNum;

  Data.fromJson(Map<String, dynamic> json) {
    _userPhone = json['user_phone'];
    _verifyNum = json['verifyNum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_phone'] = this._userPhone;
    data['verifyNum'] = this._verifyNum;
    return data;
  }
}