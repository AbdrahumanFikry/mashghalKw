class TermsModel {
  Data data;
  String message;
  int code;

  TermsModel({this.data, this.message, this.code});

  TermsModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
    code = json['code'];
  }
}

class Data {
  String role;

  Data({this.role});

  Data.fromJson(Map<String, dynamic> json) {
    role = json['role'];
  }
}