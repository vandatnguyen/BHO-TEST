import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:finews_module/configs/constants.dart';

part 'result.g.dart';

@JsonSerializable()
class Result {
  Result({
    this.success = false,
    this.code,
    this.tikopException,
    this.msg,
    this.data,
  });

  final bool success;
  final int? code;
  final dynamic data;
  final String? msg;
  bool? tikopException;

  bool get hasError => !success && code != null;

  Errors? get error =>
      code != null ? Errors(code!, msg ?? UNKNOWN_ERROR) : null;

  factory Result.fromJson(String json) =>
      _$ResultFromJson(jsonDecode(json) as Map<String, dynamic>);

  factory Result.unknowError() =>
      Result(code: -1, success: false, msg: UNKNOWN_ERROR);
}

class Errors {
  final int code;
  final String message;

  // @JsonKey(name: "errors")
  // final dynamic errors;

  const Errors(this.code, this.message);

  factory Errors.nullValue() => const Errors(-1, "Success");

  factory Errors.serverError() => const Errors(500, "Server Error");

// factory Errors.fromJson(Map<String, dynamic> json) => _$ErrorsFromJson(json);
// Map<String, dynamic> toJson() => _$ErrorsToJson(this);
}
