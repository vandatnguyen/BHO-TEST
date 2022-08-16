import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef SwithDarkNightCallback = void Function(bool);

class SwithDarkNightButton extends StatefulWidget {
  var isOn = false;
  SwithDarkNightCallback? onChange;
  @override
  State<StatefulWidget> createState() {
    return _SwithDarkNightButtonState();
  }
}

class _SwithDarkNightButtonState extends State<SwithDarkNightButton>
    with SingleTickerProviderStateMixin {
  Color activeColor = const Color(0xFF58BD7D);
  Color inactiveColor = const Color(0xFF9CA3AF);
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late Animation<Color?> _colorAnimation;
  late Animation<Color?> _colorAnimation2;
  var isOn = false;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    )..addListener(() {
        setState(() {});
      });
    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(1, 0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutCubic,
    ));
    _colorAnimation = ColorTween(
      begin: activeColor,
      end: inactiveColor,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutCubic,
    ));
    _colorAnimation2 = ColorTween(
      begin: inactiveColor,
      end: activeColor,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutCubic,
    ));

    isOn = widget.isOn;
    if (isOn) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(Object context) {
    return GestureDetector(
      onTap: () {
        if (!isOn) {
          _controller.forward();
        } else {
          _controller.reverse();
        }
        isOn = !isOn;
        if (widget.onChange != null) {
          widget.onChange!(isOn);
        }
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.all(2),
          color: const Color(0xFFF3F4F6),
          child: Stack(children: [
            SlideTransition(
                position: _offsetAnimation,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.all(2),
                  height: 24,
                  width: 24,
                )),
            Row(
              children: [
                SizedBox(
                  width: 24,
                  height: 24,
                  child: Icon(Icons.light_mode_outlined,
                      size: 16, color: _colorAnimation.value),
                ),
                SizedBox(
                  width: 24,
                  height: 24,
                  child: Icon(Icons.dark_mode_outlined,
                      size: 16, color: _colorAnimation2.value),
                )
              ],
            )
          ]),
        ),
      ),
    );
  }
}
