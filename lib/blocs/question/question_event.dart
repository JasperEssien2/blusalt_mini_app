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
  final String questionId;
  final String voteAction;

  VoteQuestion({required this.questionId, required this.voteAction});

  @override
  List<Object?> get props => [questionId];
}
