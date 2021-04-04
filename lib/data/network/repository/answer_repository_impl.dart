import 'package:blusalt_mini_app/data/network/model/state.dart';
import 'package:blusalt_mini_app/data/network/service/answer/answer_service.dart';

class AnswerRepository implements AnswerService {
  final AnswerService answerService;

  AnswerRepository({required this.answerService});
  @override
  Future<RequestState> getAnswers() {
    return answerService.getAnswers();
  }

  @override
  Future<RequestState> postAnswer(String questionId, String answer) {
    return answerService.postAnswer(questionId, answer);
  }

  @override
  Future<RequestState> searchAnswers(String query) {
    return answerService.searchAnswers(query);
  }
}
