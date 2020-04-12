class NotificationsModel {
  List<Notifications> data;
  String message;
  int code;

  NotificationsModel({this.data, this.message, this.code});

  NotificationsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Notifications>();
      json['data'].forEach((v) {
        data.add(new Notifications.fromJson(v));
      });
    }
    message = json['message'];
    code = json['code'];
  }
}

class Notifications {
  int id;
  Notification notification;

  Notifications({this.id, this.notification});

  Notifications.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    notification = json['data'] != null ? new Notification.fromJson(json['data']) : null;
  }
}

class Notification {
  String title;
  String content;

  Notification({this.title, this.content});

  Notification.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    content = json['content'];
  }
}