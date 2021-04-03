import 'package:blusalt_mini_app/data/network/model/state.dart';

abstract class AnswerService {
  Future<RequestState> postAnswer(String questionId, String answer);

  Future<RequestState> getAnswers();

  Future<RequestState> searchAnswers(String query);
}
