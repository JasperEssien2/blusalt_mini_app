part of 'create_cubit.dart';

abstract class CreateState extends Equatable {
  const CreateState();
}

class CreateInitial extends CreateState {
  @override
  List<Object> get props => [];
}

class CreateLoadingState extends CreateState {
  @override
  List<Object?> get props => [];
}

class CreateErrorState extends CreateState {
  final ServerErrorModel errorModel;

  CreateErrorState({required this.errorModel});

  @override
  List<Object?> get props => [errorModel];
}

class UploadedSuccessfully extends CreateState {
  @override
  List<Object?> get props => [];
}
