

import 'package:finews_module/cores/networking/result.dart';

abstract class DataState<T> {
  final T? data;
  final Errors? error;

  const DataState({this.data,this.error});

}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T data) : super(data: data);
}

class DataFailed<T> extends DataState<T> {
  const DataFailed(Errors? error) : super(error: error);
}