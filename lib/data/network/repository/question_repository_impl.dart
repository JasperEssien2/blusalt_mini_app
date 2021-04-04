import 'package:blusalt_mini_app/data/network/model/state.dart';
import 'package:blusalt_mini_app/data/network/service/question/question_service.dart';
import 'package:blusalt_mini_app/data/network/service/question/question_service_impl.dart';

class QuestionRepositoryImpl extends AbstractQuestionService {
  final AbstractQuestionService questionService;

  QuestionRepositoryImpl({required this.questionService});

  @override
  Future<RequestState> getQuestions() {
    return questionService.getQuestions();
  }

  @override
  Future<RequestState> postQuestion(String question) {
    return questionService.postQuestion(question);
  }

  @override
  Future<RequestState> searchQuestions(String query) {
    return questionService.searchQuestions(query);
  }

  @override
  Future<RequestState> voteQuestion(String questionId, String voteAction) {
    return questionService.voteQuestion(questionId, voteAction);
  }
}
