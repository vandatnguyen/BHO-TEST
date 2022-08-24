import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TextWithIcon extends StatelessWidget {
  const TextWithIcon({
    Key? key,
    required this.text,
    this.icon,
  }) : super(key: key);

  final Text text;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 13),
      child: Row(
        children: [
          icon != null ? icon! : Container(),
          const VerticalDivider(
            width: 4,
          ),
          text,
        ],
      ),
    );
  }
}