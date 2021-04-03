import 'package:blusalt_mini_app/views/screens/authentication/authentication_fragment.dart';
import 'package:blusalt_mini_app/views/screens/authentication/widgets/login_card.dart';
import 'package:blusalt_mini_app/views/screens/authentication/widgets/signup_card.dart';
import 'package:blusalt_mini_app/views/screens/homepage/home_page.dart';
import 'package:blusalt_mini_app/views/screens/profile/profile_page.dart';
import 'package:blusalt_mini_app/views/screens/question/question_detail.dart';
import 'package:flutter/cupertino.dart';

class Routes {
  Routes._();

  static const homePage = '/homePage';
  static const profilePage = '/profilePage';
  static const authenticationPageLogin = '/authenticationPageLogin';
  static const authenticationPageSignUp = '/authenticationPageSignUp';
  static const questionDetailPage = '/questionDetailPage';

  static final routes = <String, WidgetBuilder>{
    homePage: (_) => HomePage(),
    profilePage: (_) => ProfilePage(),
    authenticationPageLogin: (_) => AuthenticationPage(child: LoginCard()),
    authenticationPageSignUp: (_) => AuthenticationPage(child: SignUpCard()),
    questionDetailPage: (_) => QuestionDetailPage(),
  };
}
