import 'package:bloc/bloc.dart';
import 'package:blusalt_mini_app/data/network/model/server_error_model.dart';
import 'package:blusalt_mini_app/data/network/model/state.dart';
import 'package:blusalt_mini_app/data/network/repository/authentication_repository_impl.dart';
import 'package:blusalt_mini_app/di/injector_container.dart';
import 'package:blusalt_mini_app/helpers/storage/storage.helper.dart';
import 'package:blusalt_mini_app/helpers/storage/storage.keys.dart';
import 'package:blusalt_mini_app/models/state_changes_model/loading_ui_model.dart';
import 'package:equatable/equatable.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthenticationRepositoryImpl repository;
  final LoadingUIModel model = LoadingUIModel();
  LoginCubit({required this.repository}) : super(LoginInitial());

  void login(String email, String password) async {
    emit(LoginLoadingState());
    model.toggleLoadingStatus(true);
    RequestState requestState = await repository.signIn(email, password);
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
}
