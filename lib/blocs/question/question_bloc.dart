import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:blusalt_mini_app/data/network/model/question.dart';
import 'package:blusalt_mini_app/data/network/model/server_error_model.dart';
import 'package:blusalt_mini_app/data/network/model/state.dart';
import 'package:blusalt_mini_app/data/network/model/user_response.dart';
import 'package:blusalt_mini_app/data/network/repository/question_repository_impl.dart';
import 'package:equatable/equatable.dart';

part 'question_event.dart';
part 'question_state.dart';

class QuestionBloc extends Bloc<QuestionEvent, QuestionState> {
  final QuestionRepositoryImpl repository;
  QuestionBloc({required this.repository}) : super(QuestionInitial());

  @override
  Stream<QuestionState> mapEventToState(
    QuestionEvent event,
  ) async* {
    if (event is LoadQuestionList) {
      yield* _mapLoadQuestionListToEvent(event);
    }
  }

  Stream<QuestionState> _mapLoadQuestionListToEvent(
      LoadQuestionList event) async* {
    late RequestState requestState;
    if (event.searchQuery == null)
      requestState = await repository.getQuestions();
    else
      requestState = await repository.getQuestions();
  }
}
