import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'answer_create_state.dart';

class AnswerCreateCubit extends Cubit<AnswerCreateState> {
  AnswerCreateCubit() : super(AnswerCreateInitial());
}
