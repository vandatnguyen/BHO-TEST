
import 'dart:developer';

import 'package:finews_module/configs/constants.dart';

abstract class BaseConfig {
  EnvironmentConfiguration get environment;
  String get host;
  String get protocol;

  String get marketHost;
  String get marketProtocol;

  String get appName;
  String get appBundle;
}


class DevConfig implements BaseConfig {
  @override
  EnvironmentConfiguration get environment => EnvironmentConfiguration.develop;
  @override
  String get host => "104.199.179.48:8501";
  //ahuy
  // @override
  // String get host => "172.16.8.31:8501";
  //nhung
  //String get host => "172.16.24.81:8501";
  @override
  String get protocol => "http://";
  //String get protocol => "http://";
  @override
  String get marketHost => "104.199.179.48:8910";
  @override
  String get marketProtocol => "http://";
  @override
  String get appName => "Trading-Dev";
  @override
  String get appBundle => "com.trading.dev";
}


class StagingConfig implements BaseConfig {
  @override
  EnvironmentConfiguration get environment => EnvironmentConfiguration.staging;
  @override
  String get host => "stg-trading-api.tikop.vn";
  //String get host => "172.16.24.81:8501";
  @override
  String get protocol => "https://";
  //String get protocol => "http://";
  @override
  String get marketHost => "stg-trading-market.tikop.vn";
  @override
  String get marketProtocol => "https://";
  @override
  String get appName => "Trading-Stg";
  @override
  String get appBundle => "com.trading.stg";
}


class ProdConfig implements BaseConfig {
  @override
  EnvironmentConfiguration get environment => EnvironmentConfiguration.product;
  @override
  String get host => "trading-api.tikop.vn";
  @override
  String get protocol => "https://";
  @override
  String get marketHost => "trading-market.tikop.vn";
  @override
  String get marketProtocol => "https://";
  @override
  String get appName => "Trading";
  @override
  String get appBundle => "com.trading";
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
  String get marketUrl => '${config.marketProtocol}${config.marketHost}';
  bool get isProduct => config.environment == EnvironmentConfiguration.product;
}