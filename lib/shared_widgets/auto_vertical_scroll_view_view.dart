import 'dart:async';

import 'package:flutter/material.dart';

typedef RendererFunction<T> = Widget Function(T item);

class AutoVerticalScrollView<T> extends StatefulWidget {
  const AutoVerticalScrollView(
      {Key? key, required this.listItem, required this.renderItem})
      : super(key: key);
  final List<T>? listItem;
  final RendererFunction<T> renderItem;

  @override
  State<AutoVerticalScrollView<T>> createState() =>
      _AutoVerticalScrollViewState<T>();
}

const Duration timeRerun = Duration(milliseconds: 10);

class _AutoVerticalScrollViewState<T> extends State<AutoVerticalScrollView<T>> {
  final controller = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    scrollInterval?.cancel();
  }

  Timer? scrollInterval;

  @override
  Widget build(BuildContext context) {
    var renderItem = widget.renderItem;
    List<T>? listItem = widget.listItem;

    if (listItem == null) {
      return Container();
    }

    if (listItem.isEmpty) {
      return Container();
    }

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        scrollInterval?.cancel();
        scrollInterval = Timer.periodic(timeRerun, (timer) {
          controller.jumpTo(controller.offset + 0.5);
        });
      },
    );

    return PrototypeHeight(
      prototype: renderItem(listItem[0]),
      listView: ListView.builder(
        controller: controller,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          var currentItem = listItem[index % listItem.length];
          return renderItem(currentItem);
        },
      ),
    );
  }
}

class PrototypeHeight extends StatelessWidget {
  final Widget prototype;
  final ListView listView;

  const PrototypeHeight({
    Key? key,
    required this.prototype,
    required this.listView,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IgnorePointer(
          child: Opacity(
            opacity: 0.0,
            child: prototype,
          ),
        ),
        const SizedBox(width: double.infinity),
        Positioned.fill(child: listView),
      ],
    );
  }
}
