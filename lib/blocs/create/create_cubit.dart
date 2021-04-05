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
    createUIModel.text = text;
    emit(UpdateUIState());
    emit(CreateInitial());
  }

  void create(String questionId, bool isAnswer) async {
    emit(CreateLoadingState());
    createUIModel.setLoadingStatus(true);
    RequestState requestState =
        await _makeRequestToCreate(questionId, isAnswer);
    if (requestState is SuccessState) {
      emit(UploadedSuccessfully());
      _updateUIOnRequestSuccess();
    } else if (requestState is ErrorState) {
      emit(CreateErrorState(errorModel: requestState.value));
      createUIModel.setLoadingStatus(false);
    }
    emit(CreateInitial());
  }

  Future<RequestState> _makeRequestToCreate(
      String questionId, bool isAnswer) async {
    RequestState requestState;
    if (isAnswer)
      requestState =
          await answerRepository.postAnswer(questionId, createUIModel.text);
    else
      requestState = await questionRepository.postQuestion(createUIModel.text);
    return requestState;
  }

  void _updateUIOnRequestSuccess() {
    createUIModel.setLoadingStatus(false);
    createUIModel.text = '';
    emit(UpdateUIState());
    emit(CreateInitial());
  }
}
