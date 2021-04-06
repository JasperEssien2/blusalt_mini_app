import 'package:bloc/bloc.dart';
import 'package:blusalt_mini_app/blocs/authentication/login_cubit.dart';
import 'package:blusalt_mini_app/data/network/model/request_models/signup_body.dart';
import 'package:blusalt_mini_app/data/network/model/server_error_model.dart';
import 'package:blusalt_mini_app/data/network/model/state.dart';
import 'package:blusalt_mini_app/data/network/repository/authentication_repository_impl.dart';
import 'package:blusalt_mini_app/models/state_changes_model/authentication_ui_model.dart';
import 'package:equatable/equatable.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final AuthenticationRepositoryImpl repository;
  final AuthenticationUIModel model;
  final LoginCubit loginCubit;
  SignUpCubit(
      {required this.repository, required this.model, required this.loginCubit})
      : super(SignUpInitial());

  void signUp() async {
    emit(SignUpLoadingState());
    model.setLoadingStatus(true);
    RequestState requestState = await repository.signUp(model.signupBody);
    if (requestState is SuccessState) {
      _login();

      emit(SignUpSuccessfulState());
      emit(SignUpInitial());
      model.setLoadingStatus(false);
    } else if (requestState is ErrorState) {
      emit(SignUpErrorState(errorModel: requestState.value));
      emit(SignUpInitial());
      model.setLoadingStatus(false);
    }
  }

  _login() {
    loginCubit.model.signupBody = model.signupBody;
    loginCubit.login();
  }

  void updateSignUpBodyModel(SignupBody signupBody) {
    this.model.signupBody = signupBody;
    _updateButtonEnableField();
  }

  void _updateButtonEnableField() {
    if (model.isLoading)
      model.isButtonEnabled = false;
    else {
      if (_neccessaryFieldsNotEmpty())
        model.isButtonEnabled = true;
      else {
        model.isButtonEnabled = false;
      }
    }
    emit(SignUpEnableButton());
    emit(SignUpInitial());
  }

  bool _neccessaryFieldsNotEmpty() {
    return model.signupBody.email.trim().isNotEmpty &&
        model.signupBody.password.trim().isNotEmpty &&
        (model.signupBody.cPassword.trim() ==
            model.signupBody.password.trim()) &&
        model.signupBody.firstname.trim().isNotEmpty &&
        model.signupBody.lastname.trim().isNotEmpty;
  }
}
