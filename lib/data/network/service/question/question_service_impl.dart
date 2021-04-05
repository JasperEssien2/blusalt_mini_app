import 'package:blusalt_mini_app/data/network/base/endpoints.dart';
import 'package:blusalt_mini_app/data/network/base/simplify_api_consuming.dart';
import 'package:blusalt_mini_app/data/network/model/question.dart';
import 'package:blusalt_mini_app/data/network/model/state.dart';
import 'package:blusalt_mini_app/data/network/service/question/question_service.dart';
import 'package:blusalt_mini_app/helpers/http/http.helper.dart';

class QuestionServiceImpl implements AbstractQuestionService {
  final HttpHelper helper;

  QuestionServiceImpl({required this.helper});

  @override
  Future<RequestState> getQuestions() {
    return SimplifyApiConsuming.simplifyEndpointConsumingReturn(
      () => helper.get(
        questionEnpoint.questionList,
      ),
      successResponse: (data) {
        return RequestState.success(data
            .map((json) => Question.fromJson(json))
            .toList()); // returns user's token
      },
    );
  }

  @override
  Future<RequestState> postQuestion(String question) {
    return SimplifyApiConsuming.simplifyEndpointConsumingReturn(
      () => helper.post(
        authenticationEndpoint.signIn,
        body: {
          'question': question,
        },
      ),
      successResponse: (data) {
        return RequestState.success(data); // returns user's token
      },
    );
  }

  @override
  Future<RequestState> searchQuestions(String query) {
    return SimplifyApiConsuming.simplifyEndpointConsumingReturn(
      () => helper.get(
        questionEnpoint.searchQuestion + '?keywords=$query',
      ),
      successResponse: (data) {
        return RequestState.success(data
            .map((json) => Question.fromJson(json))
            .toList()); // returns user's token
      },
    );
  }

  @override
  Future<RequestState> voteQuestion(String questionId, String voteAction) {
    print(
        'VOTE URL ------------ ${questionEnpoint.voteQuote + '?questionId=$questionId&vote=$voteAction'}');
    return SimplifyApiConsuming.simplifyEndpointConsumingReturn(
      () => helper.get(
        questionEnpoint.voteQuote + '?questionId=$questionId&vote=$voteAction',
      ),
      successResponse: (data) {
        return RequestState.success(data); // returns user's token
      },
    );
  }
}
