class Days {
  String day;
  int status;
  int startTime;
  int endTime;

  Days({this.day, this.status, this.startTime, this.endTime});

  Days.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    status = json['status'];
    startTime = json['start_time'];
    endTime = json['end_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day'] = this.day;
    data['status'] = this.status;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    return data;
  }
}