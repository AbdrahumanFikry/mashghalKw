class QuestionModel {
  Data data;
  String message;
  int code;

  QuestionModel({this.data, this.message, this.code});

  QuestionModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
    code = json['code'];
  }
}

class Data {
  List<Questions> questions;

  Data({this.questions});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['questions'] != null) {
      questions = new List<Questions>();
      json['questions'].forEach((v) {
        questions.add(new Questions.fromJson(v));
      });
    }
  }
}

class Questions {
  int id;
  String question;
  String answer;
  String createdAt;
  String updatedAt;

  Questions(
      {this.id, this.question, this.answer, this.createdAt, this.updatedAt});

  Questions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    answer = json['answer'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}