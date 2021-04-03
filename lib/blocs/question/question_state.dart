part of 'question_bloc.dart';

abstract class QuestionState extends Equatable {
  const QuestionState();
}

class QuestionInitial extends QuestionState {
  @override
  List<Object> get props => [];
}

class QuestionListLoadingState extends QuestionState {
  @override
  List<Object?> get props => [];
}

class QuestionsListLoadedState extends QuestionState {
  final bool isSearch;
  final List<Question> questions;

  QuestionsListLoadedState({required this.questions, required this.isSearch});
  @override
  List<Object?> get props => [];
}

class QuestionListErrorState extends QuestionState {
  final ServerErrorModel errorModel;

  QuestionListErrorState({required this.errorModel});

  @override
  List<Object?> get props => [];
}

class QuestionOpenProfilePageState extends QuestionState {
  final UserResponse user;

  QuestionOpenProfilePageState({required this.user});

  @override
  List<Object?> get props => [user];
}

class VoteUpdated extends QuestionState {
  final int index;
  final Question question;

  VoteUpdated({required this.index, required this.question});

  @override
  List<Object?> get props => [question];
}
