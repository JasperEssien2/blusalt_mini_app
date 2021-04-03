part of 'question_bloc.dart';

abstract class QuestionEvent extends Equatable {
  const QuestionEvent();
}

class LoadQuestionList extends QuestionEvent {
  final String? searchQuery;

  LoadQuestionList({this.searchQuery});

  @override
  List<Object?> get props => [searchQuery];
}

class QuestionOpenProfilePage extends QuestionEvent {
  final UserResponse user;

  QuestionOpenProfilePage({required this.user});
  @override
  List<Object?> get props => [];
}

class VoteQuestion extends QuestionEvent {
  final int questionIndex;
  final Question question;
  final String voteAction;

  VoteQuestion(
      {required this.question,
      required this.voteAction,
      required this.questionIndex});

  @override
  List<Object?> get props => [question];
}
