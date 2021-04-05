import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:blusalt_mini_app/data/network/model/question.dart';
import 'package:blusalt_mini_app/data/network/model/server_error_model.dart';
import 'package:blusalt_mini_app/data/network/model/state.dart';
import 'package:blusalt_mini_app/data/network/model/user_response.dart';
import 'package:blusalt_mini_app/data/network/repository/question_repository_impl.dart';
import 'package:blusalt_mini_app/models/state_changes_model/loading_ui_model.dart';
import 'package:equatable/equatable.dart';

part 'question_event.dart';
part 'question_state.dart';

class QuestionBloc extends Bloc<QuestionEvent, QuestionState> {
  final QuestionRepositoryImpl repository;
  QuestionBloc({required this.repository}) : super(QuestionInitial());
  final LoadingUIModel model = LoadingUIModel();
  final List<Question> questions = [];

  @override
  Stream<QuestionState> mapEventToState(
    QuestionEvent event,
  ) async* {
    if (event is LoadQuestionList) {
      yield* _mapLoadQuestionListToEvent(event);
    } else if (event is VoteQuestion) {
      yield* _mapVoteQuestionToEvent(event);
    } else if (event is QuestionOpenProfilePage)
      yield QuestionOpenProfilePageState(user: event.user);
  }

  Stream<QuestionState> _mapLoadQuestionListToEvent(
      LoadQuestionList event) async* {
    yield QuestionListLoadingState();
    model.setLoadingStatus(true);
    RequestState requestState = await _makeQuestionListRequest(event);
    if (requestState is SuccessState) {
      questions.addAll(List<Question>.from(requestState.value));
      yield QuestionsListLoadedState(
          questions: List<Question>.from(requestState.value),
          isSearch: event.searchQuery != null);
    } else if (requestState is ErrorState)
      yield QuestionListErrorState(errorModel: requestState.value);
    model.setLoadingStatus(false);
    yield QuestionInitial();
  }

  Future<RequestState> _makeQuestionListRequest(LoadQuestionList event) async {
    late RequestState requestState;
    if (event.searchQuery == null)
      requestState = await repository.getQuestions();
    else
      requestState = await repository.searchQuestions(event.searchQuery!);

    return requestState;
  }

  Stream<QuestionState> _mapVoteQuestionToEvent(VoteQuestion event) async* {
    RequestState requestState = await _makeRequestToVoteQuestion(event);

    if (requestState is SuccessState) {
      _updateQuestionBaseOnVote(event);
      questions[event.questionIndex] = event.question;
      yield VoteUpdated(index: event.questionIndex, question: event.question);
    } else if (requestState is ErrorState) {
      yield QuestionListErrorState(errorModel: requestState.value);
    }

    yield QuestionInitial();
  }

  Future<RequestState> _makeRequestToVoteQuestion(VoteQuestion event) async {
    return repository.voteQuestion(event.question.id, event.voteAction);
  }

  void _updateQuestionBaseOnVote(VoteQuestion event) {
    if (event.voteAction == 'down')
      event.question.votes =
          event.question.votes > 0 ? event.question.votes - 1 : 0;
    else if (event.voteAction == 'up')
      event.question.votes = event.question.votes + 1;
  }
}
