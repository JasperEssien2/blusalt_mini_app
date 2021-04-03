import 'package:blusalt_mini_app/blocs/answer/answer_list_bloc.dart';
import 'package:get_it/get_it.dart';

Future<void> init(GetIt injector) async {
  injector.registerLazySingleton(
      () => AnswerListBloc(answerRepository: injector.get()));
}
