import 'dart:async';

import 'package:bezier_chart/bezier_chart.dart';
import 'package:bloc/bloc.dart';
import 'package:blusalt_mini_app/data/network/model/question.dart';
import 'package:blusalt_mini_app/data/network/model/server_error_model.dart';
import 'package:blusalt_mini_app/data/network/model/state.dart';
import 'package:blusalt_mini_app/data/network/model/user_response.dart';
import 'package:blusalt_mini_app/data/network/repository/question_repository_impl.dart';
import 'package:blusalt_mini_app/models/state_changes_model/loading_ui_model.dart';
import 'package:blusalt_mini_app/utils/time_date_formatter.dart';
import 'package:equatable/equatable.dart';

part 'question_event.dart';
part 'question_state.dart';

class QuestionBloc extends Bloc<QuestionEvent, QuestionState> {
  final QuestionRepositoryImpl repository;
  QuestionBloc({required this.repository}) : super(QuestionInitial());
  final LoadingUIModel model = LoadingUIModel();
  final List<Question> questions = [];
  final List<DataPoint<DateTime>> dataPoint = [];

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
      _addQuestionsToList(event, requestState);
      _insertDataPoint();
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

  void _addQuestionsToList(LoadQuestionList event, SuccessState requestState) {
    questions.clear();
    if (event.filterByUserId != null) {
      _filterListByUserId(requestState, event);
    } else
      questions.addAll(List<Question>.from(requestState.value));
  }

  void _filterListByUserId(SuccessState requestState, LoadQuestionList event) {
    var filteredList = _filterByUserId(
        List<Question>.from(requestState.value), event.filterByUserId);
    questions.addAll(filteredList);
  }

  List<Question> _filterByUserId(List<Question> list, String? userId) {
    List<Question> filteredList = [];
    list.forEach((element) {
      if (userId != null) if (element.user == userId) filteredList.add(element);
    });

    return filteredList;
  }

  void _insertDataPoint() {
    dataPoint.clear();
    dataPoint.addAll(_getAxisPoint(questions));
  }

  List<DataPoint<DateTime>> _getAxisPoint(List<Question> questions) {
    Map<DateTime, List<Question>> dateToQuestionMap = {};
    questions.forEach((element) {
      _insertDateTimeToMap(element, dateToQuestionMap);
    });
    return _insertDataPointsFromDateToQuestionListMap(dateToQuestionMap);
  }

  void _insertDateTimeToMap(
      Question element, Map<DateTime, List<Question>> dateToQuestionMap) {
    var dateTime = TimeDateFormatter.parseStringDateOnly(element.createdAt);
    if (dateToQuestionMap.containsKey(dateTime))
      dateToQuestionMap[dateTime]!.add(element);
    else
      dateToQuestionMap[dateTime] = [element];
  }

  List<DataPoint<DateTime>> _insertDataPointsFromDateToQuestionListMap(
      Map<DateTime, List<Question>> dateToQuestionMap) {
    List<DataPoint<DateTime>> points = [];
    dateToQuestionMap.forEach((key, value) {
      points
          .add(DataPoint<DateTime>(value: value.length.toDouble(), xAxis: key));
    });
    return points;
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
