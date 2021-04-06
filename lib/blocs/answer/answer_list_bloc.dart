import 'dart:async';

import 'package:bezier_chart/bezier_chart.dart';
import 'package:bloc/bloc.dart';
import 'package:blusalt_mini_app/data/network/model/answer_response.dart';
import 'package:blusalt_mini_app/data/network/model/server_error_model.dart';
import 'package:blusalt_mini_app/data/network/model/state.dart';
import 'package:blusalt_mini_app/data/network/model/user_response.dart';
import 'package:blusalt_mini_app/data/network/repository/answer_repository_impl.dart';
import 'package:blusalt_mini_app/models/state_changes_model/loading_ui_model.dart';
import 'package:equatable/equatable.dart';

part 'answer_list_event.dart';
part 'answer_list_state.dart';

class AnswerListBloc extends Bloc<AnswerListEvent, AnswerListState> {
  final AnswerRepository answerRepository;
  final LoadingUIModel model = LoadingUIModel();

  final List<AnswerResponse> answers = [];
  final List<DataPoint<DateTime>> dataPoint = [];
  AnswerListBloc({required this.answerRepository}) : super(AnswerListInitial());

  @override
  Stream<AnswerListState> mapEventToState(
    AnswerListEvent event,
  ) async* {
    if (event is LoadAnswerList) {
      yield* _mapLoadAnswerListToState(event);
    } else if (event is AnswerOpenProfilePage) {
      yield AnswerOpenProfilePageState(user: event.user);
      yield AnswerListInitial();
    }
  }

  Stream<AnswerListState> _mapLoadAnswerListToState(
      LoadAnswerList event) async* {
    dataPoint.clear();
    yield AnswerListLoadingState();
    model.setLoadingStatus(true);
    RequestState requestState = await _makeLoadAnswersRequest(event);
    if (requestState is SuccessState) {
      var filteredList = filterAnswerList(
          List<AnswerResponse>.from(requestState.value), event);
      _addAnswersToList(filteredList);
      _insertDataPoint();
      yield AnswerListLoadedState(answers: filteredList);
    } else if (requestState is ErrorState)
      yield AnswerListErrorState(errorModel: requestState.value);
    model.setLoadingStatus(false);
    yield AnswerListInitial();
  }

  Future<RequestState> _makeLoadAnswersRequest(LoadAnswerList event) async {
    late RequestState requestState;
    if (event.searchQuery != null)
      requestState = await answerRepository.searchAnswers(event.searchQuery!);
    else
      requestState = await answerRepository.getAnswers();

    return requestState;
  }

  List<AnswerResponse> filterAnswerList(
      List<AnswerResponse> list, LoadAnswerList event) {
    List<AnswerResponse> filteredList = [];
    list.forEach((element) {
      _filterByQuestionId(event, element, filteredList);
      _filterByUserId(event, element, filteredList);
    });

    return filteredList;
  }

  void _filterByQuestionId(LoadAnswerList event, AnswerResponse element,
      List<AnswerResponse> filteredList) {
    if (event.questionId != null) if (element.question.id == event.questionId) {
      filteredList.add(element);
    }
  }

  void _filterByUserId(LoadAnswerList event, AnswerResponse element,
      List<AnswerResponse> filteredList) {
    if (event.userId != null) {
      if (event.userId == element.user.id) filteredList.add(element);
    }
  }

  void _addAnswersToList(List<AnswerResponse> filteredList) {
    answers.clear();
    answers.addAll(filteredList);
  }

  void _insertDataPoint() {
    dataPoint.clear();
    dataPoint.addAll(_getAxisPoint(answers));
  }

  List<DataPoint<DateTime>> _getAxisPoint(List<AnswerResponse> answers) {
    Map<DateTime, List<AnswerResponse>> dateToAnswerMap = {};
    answers.forEach((element) {
      _insertDateTimeToMap(element, dateToAnswerMap);
    });
    return _insertDataPointsFromDateToQuestionListMap(dateToAnswerMap);
  }

  void _insertDateTimeToMap(AnswerResponse element,
      Map<DateTime, List<AnswerResponse>> dateToAnswerMap) {
    var dateTime = DateTime.now();
    //THIS IS JUST TO SIMULATE A GRAPH DATA POINT SINCE DATE THE ANSWER WAS CREATED ISNT RETURNED
    if (answers.indexOf(element) == 0)
      dateTime = DateTime.now().subtract(Duration(days: 5));
    else if (answers.indexOf(element) == 2)
      dateTime = DateTime.now().subtract(Duration(days: 3));

    if (dateToAnswerMap.containsKey(dateTime))
      dateToAnswerMap[dateTime]!.add(element);
    else
      dateToAnswerMap[dateTime] = [element];
  }

  List<DataPoint<DateTime>> _insertDataPointsFromDateToQuestionListMap(
      Map<DateTime, List<AnswerResponse>> dateToAnswerMap) {
    List<DataPoint<DateTime>> points = [];
    dateToAnswerMap.forEach((key, value) {
      points
          .add(DataPoint<DateTime>(value: value.length.toDouble(), xAxis: key));
    });
    return points;
  }
}
