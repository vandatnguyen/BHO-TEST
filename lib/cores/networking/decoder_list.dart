
import 'package:finews_module/cores/networking/result.dart';

typedef Decoder<T> = T Function(dynamic data);

class BaseDecoderList<T> {
  final Result result;
  final Decoder decoder;

  BaseDecoderList(
      this.result, {
        required this.decoder,
      });

  bool get success => result.success;

  bool get hasError => result.hasError;

  String? get msg => result.msg;

  int get code => result.code ?? -1;

  Errors? get error =>
      hasError ? Errors(result.code ?? -1, result.msg ?? "") : null;

  T get modelDTO => decoded();

  T decoded() {
    try {
      print("getStockIndex decoded");
      if (result.data != null) {
        print("getStockIndex decoded data ");
        return decoder(result.data) as T;
      } else {
        throw UnsupportedError(
            "BaseDecoder Error=> ${T.runtimeType} data is null");
      }
    } on Exception catch (e) {
      throw UnsupportedError(
          "BaseDecoder Error=> ${T.runtimeType} ${e.toString()}");
    }
  }
}
