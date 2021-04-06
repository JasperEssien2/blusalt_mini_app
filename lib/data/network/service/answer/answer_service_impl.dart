import 'package:blusalt_mini_app/data/network/base/endpoints.dart';
import 'package:blusalt_mini_app/data/network/base/simplify_api_consuming.dart';
import 'package:blusalt_mini_app/data/network/model/answer_response.dart';
import 'package:blusalt_mini_app/data/network/model/state.dart';
import 'package:blusalt_mini_app/data/network/service/answer/answer_service.dart';
import 'package:blusalt_mini_app/helpers/http/http.helper.dart';

class AnswerServiceImpl implements AnswerService {
  final HttpHelper helper;

  AnswerServiceImpl({required this.helper});

  @override
  Future<RequestState> getAnswers() {
    return SimplifyApiConsuming.simplifyEndpointConsumingReturn(
      () => helper.get(
        answerEndpoint.answerList,
      ),
      successResponse: (data) {
        return RequestState.success(data
            .map((json) => AnswerResponse.fromJson(json))
            .toList()); // returns user's token
      },
    );
  }

  @override
  Future<RequestState> postAnswer(String questionId, String answer) {
    print('POST ANSWER URL ------------------------ ${answerEndpoint.answer}');
    return SimplifyApiConsuming.simplifyEndpointConsumingReturn(
      () => helper.post(
        answerEndpoint.answer,
        body: {
          'question': questionId,
          'answer': answer,
        },
      ),
      statusCodeSuccess: 201,
      successResponse: (data) {
        return RequestState.success(data); // returns user's token
      },
    );
  }

  @override
  Future<RequestState> searchAnswers(String query) {
    return SimplifyApiConsuming.simplifyEndpointConsumingReturn(
      () => helper.get(
        answerEndpoint.answerSearch + '?keywords=$query',
      ),
      successResponse: (data) {
        return RequestState.success(data
            .map((json) => AnswerResponse.fromJson(json))
            .toList()); // returns user's token
      },
    );
  }
}
