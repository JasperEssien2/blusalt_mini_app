import 'package:bloc/bloc.dart';
import 'package:blusalt_mini_app/data/network/model/state.dart';
import 'package:blusalt_mini_app/data/network/model/user_response.dart';
import 'package:blusalt_mini_app/data/network/repository/user_repository_impl.dart';
import 'package:blusalt_mini_app/di/injector_container.dart';
import 'package:equatable/equatable.dart';

part 'user_bloc_state.dart';

class UserBlocCubit extends Cubit<UserBlocState> {
  late UserResponse response = UserResponse(
      id: 'anonymous',
      email: '',
      firstname: '',
      lastname: '',
      createdAt: '',
      updatedAt: '');
  final UserRepositoryImpl repository;
  UserBlocCubit({required this.repository}) : super(UserBlocInitial());

  void getUser({String? userEmail}) async {
    emit(UserLoading());
    if (userEmail == null) {
      response = await injector.getAsync<UserResponse>();
      emit(UserGotten(user: response));
    } else {
      RequestState requestState = await repository.getUser(userEmail);
      if (requestState is SuccessState) {
        response = requestState.value;
        emit(UserGotten(user: requestState.value));
      } else {
        var user = getDummyUser().copyWith(
            firstname: 'Anonymous', lastname: '', id: 'anonymous_poster');
        response = user;
        emit(UserGotten(user: user));
      }
      emit(UserBlocInitial());
    }
    emit(UserBlocInitial());
  }
}
