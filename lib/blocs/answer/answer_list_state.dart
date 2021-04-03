part of 'answer_list_bloc.dart';

abstract class AnswerListState extends Equatable {
  const AnswerListState();
}

class AnswerListInitial extends AnswerListState {
  @override
  List<Object> get props => [];
}

class AnswerListLoadingState extends AnswerListState {
  @override
  List<Object?> get props => [];
}

class AnswerListLoadedState extends AnswerListState {
  final List<AnswerResponse> answers;

  AnswerListLoadedState({required this.answers});
  @override
  List<Object?> get props => [];
}

class AnswerListErrorState extends AnswerListState {
  final ServerErrorModel errorModel;

  AnswerListErrorState({required this.errorModel});

  @override
  List<Object?> get props => [];
}

class AnswerOpenProfilePageState extends AnswerListState {
  final UserResponse user;

  AnswerOpenProfilePageState({required this.user});

  @override
  List<Object?> get props => [user];
}
