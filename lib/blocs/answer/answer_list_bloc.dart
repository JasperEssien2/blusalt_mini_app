import 'dart:async';

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
    yield AnswerListLoadingState();
    model.setLoadingStatus(true);
    RequestState requestState = await _makeLoadAnswersRequest(event);
    if (requestState is SuccessState)
      yield AnswerListLoadedState(answers: requestState.value);
    else if (requestState is ErrorState)
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
}
