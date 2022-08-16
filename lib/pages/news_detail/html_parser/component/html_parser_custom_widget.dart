import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import '../html_parser_shared.dart';
import '../html_parser_widget.dart';

class HtmlParserCustomWidget extends HtmlParserWidgetBase {
  const HtmlParserCustomWidget({required HtmlParserElement element})
      : super(element: element);

  @override
  Widget build(BuildContext context) {
    return Html(
      data: element.content,
      shrinkWrap: false,
    );
  }
}
