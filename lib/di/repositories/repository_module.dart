import 'package:blusalt_mini_app/data/network/repository/answer_repository_impl.dart';
import 'package:blusalt_mini_app/data/network/repository/authentication_repository_impl.dart';
import 'package:blusalt_mini_app/data/network/repository/question_repository_impl.dart';
import 'package:blusalt_mini_app/data/network/repository/user_repository_impl.dart';
import 'package:get_it/get_it.dart';

Future<void> init(GetIt injector) async {
  injector.registerLazySingleton(
      () => AnswerRepository(answerService: injector.get()));

  injector.registerLazySingleton(
      () => QuestionRepositoryImpl(questionService: injector.get()));

  injector.registerLazySingleton(
      () => UserRepositoryImpl(userService: injector.get()));

  injector.registerLazySingleton(() =>
      AuthenticationRepositoryImpl(authenticationService: injector.get()));
}
