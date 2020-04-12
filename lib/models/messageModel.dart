class MessagesModel {
  List<Message> data;
  String message;
  int code;

  MessagesModel({this.data, this.message, this.code});

  MessagesModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Message>();
      json['data'].forEach((v) {
        data.add(new Message.fromJson(v));
      });
    }
    message = json['message'];
    code = json['code'];
  }
}

class Message {
  int id;
  String message;
  int senderId;
  String senderName;
  int receiverId;
  String receiverName;
  String msgDate;

  Message(
      {this.id,
        this.message,
        this.senderId,
        this.senderName,
        this.receiverId,
        this.receiverName,
        this.msgDate});

  Message.fromJson(Map<String, dynamic> json) {
    id = int.tryParse(json['id'].toString());
    message = json['message'];
    senderId = int.tryParse(json['sender_id'].toString());
    senderName = json['sendername'];
    receiverId = int.tryParse(json['receiver_id'].toString());
    receiverName = json['receivername'];
    msgDate = json['msg_date'];
  }
}