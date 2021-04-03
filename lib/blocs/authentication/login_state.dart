part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginLoadingState extends LoginState {
  @override
  List<Object?> get props => [];
}

class LoginSuccessfulState extends LoginState {
  @override
  List<Object?> get props => [];
}

class LoginErrorState extends LoginState {
  final ServerErrorModel errorModel;

  LoginErrorState({required this.errorModel});
  @override
  List<Object?> get props => [];
}
