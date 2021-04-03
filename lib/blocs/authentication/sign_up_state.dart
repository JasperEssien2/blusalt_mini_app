part of 'sign_up_cubit.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();
}

class SignUpInitial extends SignUpState {
  @override
  List<Object> get props => [];
}

class SignUpLoadingState extends SignUpState {
  @override
  List<Object?> get props => [];
}

class SignUpSuccessfulState extends SignUpState {
  @override
  List<Object?> get props => [];
}

class SignUpErrorState extends SignUpState {
  final ServerErrorModel errorModel;

  SignUpErrorState({required this.errorModel});
  @override
  List<Object?> get props => [];
}
