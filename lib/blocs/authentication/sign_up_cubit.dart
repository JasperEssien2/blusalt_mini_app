import 'package:bloc/bloc.dart';
import 'package:blusalt_mini_app/data/network/model/request_models/signup_body.dart';
import 'package:blusalt_mini_app/data/network/model/server_error_model.dart';
import 'package:blusalt_mini_app/data/network/model/state.dart';
import 'package:blusalt_mini_app/data/network/repository/authentication_repository_impl.dart';
import 'package:blusalt_mini_app/di/injector_container.dart';
import 'package:blusalt_mini_app/helpers/storage/storage.helper.dart';
import 'package:blusalt_mini_app/helpers/storage/storage.keys.dart';
import 'package:blusalt_mini_app/models/state_changes_model/loading_ui_model.dart';
import 'package:equatable/equatable.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final AuthenticationRepositoryImpl repository;
  final LoadingUIModel model = LoadingUIModel();
  SignUpCubit({required this.repository}) : super(SignUpInitial());

  void login(SignupBody body) async {
    emit(SignUpLoadingState());
    model.toggleLoadingStatus(true);
    RequestState requestState = await repository.signUp(body);
    if (requestState is SuccessState) {
      injector.pushNewScope(scopeName: registeredUserScope);
      StorageHelper.setString(StorageKeys.token, requestState.value);
      emit(SignUpSuccessfulState());
      emit(SignUpInitial());
      model.toggleLoadingStatus(false);
    } else if (requestState is ErrorState) {
      emit(SignUpErrorState(errorModel: requestState.value));
      emit(SignUpInitial());
      model.toggleLoadingStatus(false);
    }
  }
}
