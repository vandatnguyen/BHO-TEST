
import 'dart:developer';

import 'package:finews_module/configs/constants.dart';

abstract class BaseConfig {
  EnvironmentConfiguration get environment;
  String get host;
  String get protocol;
  String get appName;
  String get appBundle;
}


class DevConfig implements BaseConfig {
  @override
  EnvironmentConfiguration get environment => EnvironmentConfiguration.develop;
  @override
  String get host => "dev-api.r14express.vn";
  @override
  String get protocol => "https://"; 
  @override 
  String get appName => "FI-News";
  @override
  String get appBundle => "com.news.dev";
}


class StagingConfig implements BaseConfig {
   @override
  EnvironmentConfiguration get environment => EnvironmentConfiguration.develop;
  @override
  String get host => "dev-api.r14express.vn";
  @override
  String get protocol => "https://"; 
  @override 
  String get appName => "FI-News";
  @override
  String get appBundle => "com.news.stg";
}


class ProdConfig implements BaseConfig {
   @override
  EnvironmentConfiguration get environment => EnvironmentConfiguration.develop;
  @override
  String get host => "api.r14express.vn";
  @override
  String get protocol => "https://"; 
  @override 
  String get appName => "FI-News";
  @override
  String get appBundle => "com.news.prod";
}

class Environment {
  factory Environment() {
    return _singleton;
  }

  Environment._internal();
  static final Environment _singleton = Environment._internal();

  BaseConfig config =  DevConfig();

  void initConfig(EnvironmentConfiguration environment) {
    log("environment environment");
    log(environment.name);
    config = _getConfig(environment);
  }

  BaseConfig _getConfig(EnvironmentConfiguration environment) {
    switch (environment) {
      case EnvironmentConfiguration.product:
        return ProdConfig();
      case EnvironmentConfiguration.staging:
        return StagingConfig();
      default:
        return DevConfig();
    }
  }


  String get backendUrl => '${config.protocol}${config.host}'; 
  bool get isProduct => config.environment == EnvironmentConfiguration.product;
}