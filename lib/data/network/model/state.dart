class RequestState<T> {
  RequestState._(); // private constructor
  factory RequestState.success(T value) = SuccessState<T>;

  factory RequestState.error(T msg) = ErrorState<T>;
}

class ErrorState<T> extends RequestState<T> {
  ErrorState(this.value) : super._();
  final T value;
}

class SuccessState<T> extends RequestState<T> {
  SuccessState(this.value) : super._();
  final T value;
}
