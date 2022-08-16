import 'package:flutter/material.dart';
import '../html_parser_shared.dart';
import '../html_parser_widget.dart';

class HtmlParserTextWidget extends HtmlParserWidgetBase {
  const HtmlParserTextWidget({required HtmlParserElement element})
      : super(element: element);
  @override
  Widget build(BuildContext context) {

    switch (element.type) {
      case HtmlParserElementType.text: 
        return Padding(
            padding: element.getPadding(),
            child: Text(element.content, style: element.getTextStyle(0)));
      case HtmlParserElementType.group:
        List<InlineSpan> elements = element.children
                ?.map<InlineSpan>(
                    (e) => TextSpan(text: e.content, style: e.getTextStyle(0)))
                .toList() ??
            [];

        return Text.rich(TextSpan(children: elements));
      default:
        return Text("unknow type ${element.type}");
    }
  }
}
