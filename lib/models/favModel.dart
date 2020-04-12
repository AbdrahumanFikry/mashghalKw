class FavModel {
  Data data;
  String message;
  int code;

  FavModel({this.data, this.message, this.code});

  FavModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
    code = json['code'];
  }
}

class Data {
  int userId;
  int status;
  int advertiserId;
  String updatedAt;
  String createdAt;
  int id;

  Data(
      {this.userId,
        this.status,
        this.advertiserId,
        this.updatedAt,
        this.createdAt,
        this.id});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    status = json['status'];
    advertiserId = int.tryParse(json['advertiser_id'].toString());
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }
}