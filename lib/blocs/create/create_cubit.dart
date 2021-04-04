import 'package:bloc/bloc.dart';
import 'package:blusalt_mini_app/data/network/model/server_error_model.dart';
import 'package:blusalt_mini_app/data/network/model/state.dart';
import 'package:blusalt_mini_app/data/network/repository/answer_repository_impl.dart';
import 'package:blusalt_mini_app/data/network/repository/question_repository_impl.dart';
import 'package:blusalt_mini_app/models/state_changes_model/create_ui_model.dart';
import 'package:equatable/equatable.dart';

part 'create_state.dart';

class CreateCubit extends Cubit<CreateState> {
  final CreateUIModel createUIModel = CreateUIModel();

  final AnswerRepository answerRepository;
  final QuestionRepositoryImpl questionRepository;
  CreateCubit(
      {required this.answerRepository, required this.questionRepository})
      : super(CreateInitial());

  void updateText(String text) {
    createUIModel.setText(text);
  }

  void create(String questionId, bool isAnswer) async {
    emit(CreateLoadingState());
    createUIModel.toggleLoadingStatus(true);
    RequestState requestState =
        await _makeRequestToCreate(questionId, isAnswer);
    if (requestState is SuccessState) {
      emit(UploadedSuccessfully());
      _updateUIOnRequestSuccess();
    } else if (requestState is ErrorState) {
      emit(CreateErrorState(errorModel: requestState.value));
      createUIModel.toggleLoadingStatus(false);
    }
    emit(CreateInitial());
  }

  Future<RequestState> _makeRequestToCreate(
      String questionId, bool isAnswer) async {
    RequestState requestState;
    if (isAnswer)
      requestState =
          await answerRepository.postAnswer(questionId, createUIModel.getText);
    else
      requestState =
          await questionRepository.postQuestion(createUIModel.getText);
    return requestState;
  }

  void _updateUIOnRequestSuccess() {
    createUIModel.toggleLoadingStatus(false);
    createUIModel.setText('');
  }
}