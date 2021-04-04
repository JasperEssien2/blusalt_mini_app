import 'package:blusalt_mini_app/data/network/service/answer/answer_service.dart';
import 'package:blusalt_mini_app/data/network/service/answer/answer_service_impl.dart';
import 'package:blusalt_mini_app/data/network/service/authentication/authentication_service.dart';
import 'package:blusalt_mini_app/data/network/service/authentication/authentication_service_impl.dart';
import 'package:blusalt_mini_app/data/network/service/question/question_service.dart';
import 'package:blusalt_mini_app/data/network/service/question/question_service_impl.dart';
import 'package:blusalt_mini_app/data/network/service/user/user_service.dart';
import 'package:blusalt_mini_app/data/network/service/user/user_service_impl.dart';
import 'package:get_it/get_it.dart';

Future<void> init(GetIt injector) async {
  injector.registerLazySingleton<AbstractUserService>(
      () => UserServiceImpl(helper: injector.get()));

  injector.registerLazySingleton<AuthenticationService>(
      () => AuthenticationServiceImpl(helper: injector.get()));

  injector.registerLazySingleton<AbstractQuestionService>(
      () => QuestionServiceImpl(helper: injector.get()));

  injector.registerLazySingleton<AnswerService>(
      () => AnswerServiceImpl(helper: injector.get()));
}
