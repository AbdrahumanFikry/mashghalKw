class CommissionModel {
  Data data;
  String message;
  int code;

  CommissionModel({this.data, this.message, this.code});

  CommissionModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
    code = json['code'];
  }
}

class Data {
  Commission commission;

  Data({this.commission});

  Data.fromJson(Map<String, dynamic> json) {
    commission = json['commission'] != null
        ? new Commission.fromJson(json['commission'])
        : null;
  }
}

class Commission {
  String total;
  double commissions;
  int userId;
  String updatedAt;
  String createdAt;
  int id;

  Commission(
      {this.total,
      this.commissions,
      this.userId,
      this.updatedAt,
      this.createdAt,
      this.id});

  Commission.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    commissions = double.tryParse(json['commissions'].toString());
    userId = json['user_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }
}
