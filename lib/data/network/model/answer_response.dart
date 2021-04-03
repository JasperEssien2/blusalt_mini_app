import 'package:blusalt_mini_app/data/network/model/question.dart';
import 'package:blusalt_mini_app/data/network/model/user_response.dart';
import 'package:equatable/equatable.dart';

class AnswerResponse extends Equatable {
  late final String id;
  late final Question question;
  late final String answer;
  late final UserResponse user;

  AnswerResponse({
    required this.id,
    required this.question,
    required this.answer,
    required this.user,
  });

  AnswerResponse.fromJson(dynamic json) {
    id = json["_id"];
    question = json["question"] != null
        ? Question.fromJson(json["question"])
        : getDummyQuestion();
    answer = json["answer"];
    user = json["user"] != null
        ? UserResponse.fromJson(json["user"])
        : getDummyUser();
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["_id"] = id;
    if (question != null) {
      map["question"] = question.toJson();
    }
    map["answer"] = answer;
    if (user != null) {
      map["user"] = user.toJson();
    }
    return map;
  }

  @override
  List<Object?> get props => [];

  AnswerResponse copyWith({
    String? id,
    Question? question,
    String? answer,
    UserResponse? user,
  }) {
    if ((id == null || identical(id, this.id)) &&
        (question == null || identical(question, this.question)) &&
        (answer == null || identical(answer, this.answer)) &&
        (user == null || identical(user, this.user))) {
      return this;
    }

    return new AnswerResponse(
      id: id ?? this.id,
      question: question ?? this.question,
      answer: answer ?? this.answer,
      user: user ?? this.user,
    );
  }
}
