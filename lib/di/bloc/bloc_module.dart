import 'package:blusalt_mini_app/blocs/answer/answer_list_bloc.dart';
import 'package:blusalt_mini_app/blocs/authentication/login_cubit.dart';
import 'package:blusalt_mini_app/blocs/authentication/sign_up_cubit.dart';
import 'package:blusalt_mini_app/blocs/create/create_cubit.dart';
import 'package:blusalt_mini_app/blocs/question/question_bloc.dart';
import 'package:blusalt_mini_app/blocs/user/user_bloc_cubit.dart';
import 'package:get_it/get_it.dart';

Future<void> init(GetIt injector) async {
  //DEPENDENCIES RELATED TO ANSWER
  _injectDependenciesRelatedToAnswer(injector);

  //DEPENDENCIES RELATED TO QUESTION
  _injectDependenciesRelatedToQuestion(injector);

  //DEPENDENCIES RELATED TO AUTHENTICATION
  _injectDependenciesRelatedToAuthentication(injector);
}

void _injectDependenciesRelatedToAnswer(GetIt injector) {
  injector.registerLazySingleton(
      () => AnswerListBloc(answerRepository: injector.get()));
}

void _injectDependenciesRelatedToQuestion(GetIt injector) {
  injector
      .registerLazySingleton(() => QuestionBloc(repository: injector.get()));

  injector.registerLazySingleton(() => QuestionBloc(repository: injector.get()),
      instanceName: 'profile');

  injector.registerLazySingleton(() => CreateCubit(
      answerRepository: injector.get(), questionRepository: injector.get()));
}

void _injectDependenciesRelatedToAuthentication(GetIt injector) {
  injector.registerLazySingleton(
      () => LoginCubit(repository: injector.get(), model: injector.get()));

  injector.registerLazySingleton(() {
    return UserBlocCubit(repository: injector.get());
  });

  injector.registerLazySingleton(() => SignUpCubit(
      repository: injector.get(),
      model: injector.get(),
      loginCubit: injector.get()));
}
