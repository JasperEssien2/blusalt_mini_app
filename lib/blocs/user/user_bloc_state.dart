part of 'user_bloc_cubit.dart';

abstract class UserBlocState extends Equatable {
  const UserBlocState();
}

class UserBlocInitial extends UserBlocState {
  @override
  List<Object> get props => [];
}

class UserLoading extends UserBlocState {
  @override
  List<Object?> get props => [];
}

class UserGotten extends UserBlocState {
  final UserResponse user;

  UserGotten({required this.user});

  @override
  List<Object?> get props => [user];
}
