import 'package:blusalt_mini_app/data/network/model/request_models/signup_body.dart';
import 'package:blusalt_mini_app/models/base_ui_model.dart';

class AuthenticationUIModel extends BaseUIModel {
  SignupBody signupBody = SignupBody(
      email: '', password: '', cPassword: '', firstname: '', lastname: '');
  bool isButtonEnabled = false;
}
