import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:infinite_carousel/infinite_carousel.dart';

typedef RendererFunction<T> = Widget Function(T item);

class AutoVerticalScrollView<T> extends StatefulWidget {
  const AutoVerticalScrollView(
      {Key? key, required this.listItem, required this.renderItem, required this.maxHeight, required this.maxWidth})
      : super(key: key);
  final List<T>? listItem;
  final RendererFunction<T> renderItem;
  final double maxWidth;
  final double maxHeight;

  @override
  State<AutoVerticalScrollView<T>> createState() =>
      _AutoVerticalScrollViewState<T>();
}

const Duration timeRerun = Duration(milliseconds: 2000);

class _AutoVerticalScrollViewState<T> extends State<AutoVerticalScrollView<T>> {
  final controller = InfiniteScrollController();

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

    WidgetsBinding.instance?.addPostFrameCallback(
      (_) {
        scrollInterval?.cancel();
        scrollInterval = Timer.periodic(timeRerun, (timer) {
          try {
            controller.animateTo(controller.offset + 100,
                duration: timeRerun, curve: Curves.linear);
          } catch (e) {
            if (kDebugMode) {
              print(e);
            }
          }
        });
      },
    );

    return SizedBox(
      height: widget.maxHeight,
      child: InfiniteCarousel.builder(
        itemCount: listItem.length,
        controller: controller,
        loop: true,
        itemBuilder: (context, itemIndex, realIndex) {
          return renderItem(
            listItem[itemIndex],
          );
        },
        itemExtent: widget.maxWidth,
      ),
    );
  }
}

class PrototypeHeight extends StatelessWidget {
  final Widget prototype;
  final Widget child;

  const PrototypeHeight({
    Key? key,
    required this.prototype,
    required this.child,
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
        Positioned.fill(child: child),
      ],
    );
  }
}
