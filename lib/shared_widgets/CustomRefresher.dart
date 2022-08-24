import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CustomRefresher extends StatelessWidget {
  const CustomRefresher(
      {Key? key,
      required this.controller,
      required this.child,
      this.onRefresh,
      this.onLoading})
      : super(key: key);

  final RefreshController controller;
  final Widget child;
  final VoidCallback? onRefresh;
  final VoidCallback? onLoading;
  @override
  Widget build(BuildContext context) {
    //

    return SmartRefresher(
      controller: controller,
      enablePullDown: onRefresh != null,
      onRefresh: onRefresh,
      enablePullUp: onLoading != null,
      onLoading: onLoading,
      header: const ClassicHeader(
        idleText: "",
        releaseText: "",
        completeText: "",
        refreshingText: "",
        failedText: "Đã có lỗi xảy ra",
      ),
      footer: const ClassicFooter(
        iconPos: IconPosition.top,
        idleIcon: null,
        idleText: "",
        loadingText: "",
        noDataText: "",
        canLoadingText: "",
        failedText: "Đã có lỗi xảy ra",
      ),
      child: child,
    );
  }
}
