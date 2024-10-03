sealed class DataState<T> {
  const DataState();
}

class Success<T> extends DataState<T> {
  final T data;

  Success(this.data);
}

class InitialState<T> extends DataState<T> {}

class EmptyData<T> extends DataState<T> {}

class Error<T> extends DataState<T> {
  final String message;
  final Function? retry;

  Error(this.message, {this.retry});
}

class Loading<T> extends DataState<T> {
  final int? progress;

  Loading({this.progress});
}
