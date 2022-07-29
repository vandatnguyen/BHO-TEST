import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class BaseViewModel<T extends GetxController> extends StatelessWidget {
  const BaseViewModel({Key? key, this.tag}) : super(key: key);

  final String? tag;
  T get controller => GetInstance().find<T>(tag: tag);

  @override
  Widget build(BuildContext context) {
    return Obx(() => child(context));
  }

  Widget child(BuildContext context);
}
