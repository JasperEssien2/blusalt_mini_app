import 'package:blusalt_mini_app/data/network/base/endpoints.dart';
import 'package:blusalt_mini_app/data/network/base/simplify_api_consuming.dart';
import 'package:blusalt_mini_app/data/network/model/request_models/signup_body.dart';
import 'package:blusalt_mini_app/data/network/model/state.dart';
import 'package:blusalt_mini_app/helpers/http/http.helper.dart';

import 'authentication_service.dart';

class AuthenticationServiceImpl implements AuthenticationService {
  final HttpHelper helper;

  AuthenticationServiceImpl({required this.helper});
  @override
  Future<RequestState> signIn(String email, String password) {
    return SimplifyApiConsuming.simplifyEndpointConsumingReturn(
      () => helper.post(
        authenticationEndpoint.signIn,
        body: {
          'password': password,
          'email': email,
        },
      ),
      successResponse: (data) {
        return RequestState.success(data); // returns user's token
      },
    );
  }

  @override
  Future<RequestState> signUp(SignupBody body) {
    return SimplifyApiConsuming.simplifyEndpointConsumingReturn(
      () => helper.post(
        authenticationEndpoint.signUp,
        body: body.toJson(),
      ),
      statusCodeSuccess: 201,
      successResponse: (data) {
        return RequestState.success(data); // returns user's token
      },
    );
  }
}
