import 'package:flutter/material.dart';
import 'dart:math' as math;

class FontSizeSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      const SizedBox(
        width: 24,
        height: 24,
        child: Icon(Icons.text_decrease_outlined, size: 24),
      ),
      const SizedBox(width: 15),
      Expanded(
          child: SliderTheme(
              data: SliderThemeData(
                trackHeight: 8,
                thumbShape: const CustomSliderThumbShape(),
                trackShape: CustomTrackShape(),
              ),
              child: Slider(
                value: 0,
                max: 100,
                divisions: 5,
                label: null,
                onChanged: (double value) {},
                thumbColor: const Color(0xFF58BD7D),
                inactiveColor: const Color(0xFFF3F4F6),
                activeColor: const Color(0xFF58BD7D),
              ))),
      const SizedBox(width: 15),
      const SizedBox(
        width: 32,
        height: 32,
        child: Icon(Icons.text_increase_outlined, size: 32),
      ),
    ]);
  }
}

class BrightnessSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 24,
          height: 24,
          child: Icon(Icons.light_mode_outlined, size: 24),
        ),
        const SizedBox(width: 15),
        Expanded(
            child: SliderTheme(
                data: SliderThemeData(
                  trackHeight: 6,
                  thumbShape: const CustomSliderThumbShape(),
                  trackShape: CustomTrackShape(),
                ),
                child: Slider(
                  value: 0,
                  max: 100,
                  label: null,
                  onChanged: (double value) {},
                  thumbColor: const Color(0xFF58BD7D),
                  inactiveColor: const Color(0xFFF3F4F6),
                  activeColor: const Color(0xFF58BD7D),
                ))),
        const SizedBox(width: 15),
        const SizedBox(
          width: 32,
          height: 32,
          child: Icon(Icons.light_mode_outlined, size: 32),
        ),
      ],
    );
  }
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight ?? 8;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}

class CustomSliderThumbShape extends SliderComponentShape {
  /// Create a slider thumb that draws a circle.
  const CustomSliderThumbShape({
    this.enabledThumbRadius = 9.0,
    this.disabledThumbRadius,
    this.elevation = 1.0,
    this.pressedElevation = 9.0,
  });

  final double enabledThumbRadius;

  /// [enabledThumbRadius]
  final double? disabledThumbRadius;
  double get _disabledThumbRadius => disabledThumbRadius ?? enabledThumbRadius;
  final double elevation;
  final double pressedElevation;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(
        isEnabled == true ? enabledThumbRadius : _disabledThumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    assert(context != null);
    assert(center != null);
    assert(enableAnimation != null);
    assert(sliderTheme != null);
    assert(sliderTheme.disabledThumbColor != null);
    assert(sliderTheme.thumbColor != null);

    final Canvas canvas = context.canvas;
    final Tween<double> radiusTween = Tween<double>(
      begin: _disabledThumbRadius,
      end: enabledThumbRadius,
    );
    final ColorTween colorTween = ColorTween(
      begin: sliderTheme.disabledThumbColor,
      end: sliderTheme.thumbColor,
    );

    final Color color = colorTween.evaluate(enableAnimation)!;
    final double radius = radiusTween.evaluate(enableAnimation);

    final Tween<double> elevationTween = Tween<double>(
      begin: elevation,
      end: pressedElevation,
    );

    final double evaluatedElevation =
        elevationTween.evaluate(activationAnimation);
    final Path path = Path()
      ..addArc(
          Rect.fromCenter(
              center: center, width: 2 * radius, height: 2 * radius),
          0,
          math.pi * 2);
    canvas.drawShadow(path, Colors.black, evaluatedElevation, true);

    canvas.drawCircle(
      center,
      radius,
      Paint()..color = color,
    );
    canvas.drawCircle(
      center,
      radius - 2,
      Paint()..color = Colors.white,
    );
    canvas.drawCircle(
      center,
      radius - 4,
      Paint()..color = color,
    );
  }
}
