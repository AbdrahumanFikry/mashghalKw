class AdsModel {
  Data data;
  String message;
  int code;

  AdsModel({this.data, this.message, this.code});

  AdsModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
    code = json['code'];
  }
}

class Data {
  List<Ads> ads;

  Data({this.ads});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['ads'] != null) {
      ads = new List<Ads>();
      json['ads'].forEach((v) {
        ads.add(new Ads.fromJson(v));
      });
    }
  }
}

class Ads {
  int id;
  String image;

  Ads({this.id, this.image});

  Ads.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'] != null ? json['image'] : '846221351571559270.jpg';
  }
}
