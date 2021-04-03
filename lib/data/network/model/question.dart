import 'package:equatable/equatable.dart';

class Question extends Equatable {
  late final int votes;
  late final String id;
  late final String question;
  late final String user;
  late final String createdAt;
  late final String updatedAt;

  Question({
    required this.votes,
    required this.id,
    required this.question,
    required this.user,
    required this.createdAt,
    required this.updatedAt,
  });

  Question.fromJson(dynamic json) {
    votes = json["votes"];
    id = json["_id"];
    question = json["question"];
    user = json["user"];
    createdAt = json["createdAt"];
    updatedAt = json["updatedAt"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["votes"] = votes;
    map["_id"] = id;
    map["question"] = question;
    map["user"] = user;
    map["createdAt"] = createdAt;
    map["updatedAt"] = updatedAt;
    return map;
  }

  @override
  List<Object?> get props => [id];

  Question copyWith({
    int? votes,
    String? id,
    String? question,
    String? user,
    String? createdAt,
    String? updatedAt,
  }) {
    if ((votes == null || identical(votes, this.votes)) &&
        (id == null || identical(id, this.id)) &&
        (question == null || identical(question, this.question)) &&
        (user == null || identical(user, this.user)) &&
        (createdAt == null || identical(createdAt, this.createdAt)) &&
        (updatedAt == null || identical(updatedAt, this.updatedAt))) {
      return this;
    }

    return new Question(
      votes: votes ?? this.votes,
      id: id ?? this.id,
      question: question ?? this.question,
      user: user ?? this.user,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

getDummyQuestion() {
  return Question(
      votes: 0,
      id: 'id',
      question: 'question',
      user: 'user',
      createdAt: '',
      updatedAt: '');
}
