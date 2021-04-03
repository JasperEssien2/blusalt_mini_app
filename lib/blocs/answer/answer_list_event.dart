part of 'answer_list_bloc.dart';

abstract class AnswerListEvent extends Equatable {
  const AnswerListEvent();
}

class LoadAnswerList extends AnswerListEvent {
  final String questionId;
  final String? searchQuery;

  LoadAnswerList({required this.questionId, this.searchQuery});

  @override
  List<Object?> get props => [questionId];
}

class AnswerOpenProfilePage extends AnswerListEvent {
  final UserResponse user;

  AnswerOpenProfilePage({required this.user});
  @override
  List<Object?> get props => [];
}
