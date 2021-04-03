import 'package:blusalt_mini_app/data/network/model/request_models/signup_body.dart';
import 'package:blusalt_mini_app/data/network/model/state.dart';
import 'package:blusalt_mini_app/data/network/service/authentication/authentication_service.dart';
import 'package:blusalt_mini_app/data/network/service/authentication/authentication_service_impl.dart';

class AuthenticationRepositoryImpl extends AuthenticationService {
  final AuthenticationServiceImpl authenticationService;

  AuthenticationRepositoryImpl({required this.authenticationService});

  @override
  Future<RequestState> signIn(String email, String password) {
    return authenticationService.signIn(email, password);
  }

  @override
  Future<RequestState> signUp(SignupBody body) {
    return authenticationService.signUp(body);
  }
}
