import 'package:blusalt_mini_app/data/network/model/state.dart';

abstract class AbstractQuestionService {
  Future<RequestState> postQuestion(String question);

  Future<RequestState> getQuestions();

  Future<RequestState> searchQuestions(String query);

  Future<RequestState> voteQuestion(String questionId, String voteAction);
}
