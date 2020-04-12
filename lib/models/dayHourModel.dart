class DaysHourModel {
  List<Days> days;
  String message;
  int code;

  DaysHourModel({this.days, this.message, this.code});

  DaysHourModel.fromJson(Map<String, dynamic> json) {
    if (json['days'] != null) {
      days = new List<Days>();
      json['days'].forEach((v) {
        days.add(new Days.fromJson(v));
      });
    }
    message = json['message'];
    code = json['code'];
  }
}

class Days {
  int id;
  int userId;
  String day;
  String startTime;
  String endTime;
  int status;
  String createdAt;
  String updatedAt;

  Days(
      {this.id,
        this.userId,
        this.day,
        this.startTime,
        this.endTime,
        this.status,
        this.createdAt,
        this.updatedAt});

  Days.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    day = json['day'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}