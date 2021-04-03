import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'question_create_state.dart';

class QuestionCreateCubit extends Cubit<QuestionCreateState> {
  QuestionCreateCubit() : super(QuestionCreateInitial());
}
