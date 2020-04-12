class FavouritesModel {
  Data data;
  String message;
  int code;

  FavouritesModel({this.data, this.message, this.code});

  FavouritesModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
    code = json['code'];
  }
}

class Data {
  List<Advertisers> advertisers;

  Data({this.advertisers});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['advertisers'] != null) {
      advertisers = new List<Advertisers>();
      json['advertisers'].forEach((v) {
        advertisers.add(new Advertisers.fromJson(v));
      });
    }
  }
}

class Advertisers {
  int id;
  int userId;
  int advertiserId;
  int advertId;
  String createdAt;
  String updatedAt;
  Advertiser advertiser;

  Advertisers(
      {this.id,
        this.userId,
        this.advertiserId,
        this.advertId,
        this.createdAt,
        this.updatedAt,
        this.advertiser});

  Advertisers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    advertiserId = json['advertiser_id'];
    advertId = json['advert_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    advertiser = json['advertiser'] != null
        ? new Advertiser.fromJson(json['advertiser'])
        : null;
  }
}

class Advertiser {
  int id;
  String name;
  String email;
  String phone;
  String apiToken;
  double lat;
  double long;
  String address;
  String image;
  String role;
  String serviceType;
  int notification;
  String createdAt;
  String updatedAt;
  double rate;

  Advertiser(
      {this.id,
        this.name,
        this.email,
        this.phone,
        this.apiToken,
        this.lat,
        this.long,
        this.address,
        this.image,
        this.role,
        this.serviceType,
        this.notification,
        this.createdAt,
        this.updatedAt,
        this.rate});

  Advertiser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    apiToken = json['api_token'];
    lat = json['lat'];
    long = json['long'];
    address = json['address'];
    image = json['image'];
    role = json['role'];
    serviceType = json['service_type'];
    notification = json['notification'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    rate = double.tryParse(json['rate'].toString());
  }
}