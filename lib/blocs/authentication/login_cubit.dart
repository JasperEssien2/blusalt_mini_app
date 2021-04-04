import 'package:bloc/bloc.dart';
import 'package:blusalt_mini_app/data/network/model/server_error_model.dart';
import 'package:blusalt_mini_app/data/network/model/state.dart';
import 'package:blusalt_mini_app/data/network/repository/authentication_repository_impl.dart';
import 'package:blusalt_mini_app/di/injector_container.dart';
import 'package:blusalt_mini_app/helpers/storage/storage.helper.dart';
import 'package:blusalt_mini_app/helpers/storage/storage.keys.dart';
import 'package:blusalt_mini_app/models/state_changes_model/authentication_ui_model.dart';
import 'package:equatable/equatable.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthenticationRepositoryImpl repository;
  final AuthenticationUIModel model;

  LoginCubit({required this.repository, required this.model})
      : super(LoginInitial());

  void login() async {
    emit(LoginLoadingState());
    model.toggleLoadingStatus(true);
    RequestState requestState = await repository.signIn(
        model.signupBody.email, model.signupBody.password);
    if (requestState is SuccessState) {
      injector.pushNewScope(scopeName: registeredUserScope);
      StorageHelper.setString(StorageKeys.token, requestState.value);
      emit(LoginSuccessfulState());
      emit(LoginInitial());
      model.toggleLoadingStatus(false);
    } else if (requestState is ErrorState) {
      emit(LoginErrorState(errorModel: requestState.value));
      emit(LoginInitial());
      model.toggleLoadingStatus(false);
    }
  }

  void updateEmail(String email) {
    model.signupBody.email = email;
    _updateEnableField();
  }

  void updatePassword(String password) {
    model.signupBody.password = password;
    _updateEnableField();
  }

  void _updateEnableField() {
    if (model.isLoading)
      model.isButtonEnabled = false;
    else {
      if (model.signupBody.email.trim().isNotEmpty &&
          model.signupBody.password.trim().isNotEmpty)
        model.isButtonEnabled = true;
      else {
        model.isButtonEnabled = false;
      }
    }
    emit(LoginEnableButton());
    emit(LoginInitial());
    print(
        'IS EMAIL AND PASSWORD IS NOT EMPTY: ${(model.signupBody.email.trim().isNotEmpty && model.signupBody.password.trim().isNotEmpty)}');
  }
}
