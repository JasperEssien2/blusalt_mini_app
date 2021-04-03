import 'package:blusalt_mini_app/data/network/model/request_models/signup_body.dart';
import 'package:blusalt_mini_app/data/network/model/state.dart';

abstract class AuthenticationService {
  Future<RequestState> signUp(SignupBody body);

  Future<RequestState> signIn(String email, String password);
}
