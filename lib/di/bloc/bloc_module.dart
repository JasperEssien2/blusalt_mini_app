import 'package:blusalt_mini_app/blocs/answer/answer_list_bloc.dart';
import 'package:blusalt_mini_app/blocs/authentication/login_cubit.dart';
import 'package:blusalt_mini_app/blocs/authentication/sign_up_cubit.dart';
import 'package:blusalt_mini_app/blocs/question/question_bloc.dart';
import 'package:get_it/get_it.dart';

Future<void> init(GetIt injector) async {
  injector.registerLazySingleton(
      () => AnswerListBloc(answerRepository: injector.get()));

  injector
      .registerLazySingleton(() => QuestionBloc(repository: injector.get()));

  injector.registerLazySingleton(() => LoginCubit(repository: injector.get()));

  injector.registerLazySingleton(() => SignUpCubit(repository: injector.get()));
}
