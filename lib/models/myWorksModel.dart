class MyWorksModel {
  Data data;
  String message;
  int code;

  MyWorksModel({this.data, this.message, this.code});

  MyWorksModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
    code = json['code'];
  }
}

class Data {
  List<Works> works;

  Data({this.works});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['works'] != null) {
      works = new List<Works>();
      json['works'].forEach((v) {
        works.add(new Works.fromJson(v));
      });
    }
  }
}

class Works {
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
