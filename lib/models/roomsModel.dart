class RoomsModel {
  List<Data> data;
  String message;
  int code;

  RoomsModel({this.data, this.message, this.code});

  RoomsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    message = json['message'];
    code = json['code'];
  }
}

class Data {
  int id;
  int chatId;
  String name;
  String image;
  String lastMessage;
  String createdAt;

  Data({this.id,this.chatId, this.name, this.image, this.lastMessage, this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    chatId = json['chat_id'];
    name = json['name'];
    image = json['image'];
    lastMessage = json['last_message'];
    createdAt = json['created_at'];
  }
}