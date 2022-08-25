import 'package:flutter/material.dart';
import 'component/html_parser_custom_widget.dart';
import 'component/html_parser_image_widget.dart';
import 'component/html_parser_text_widget.dart';
import 'component/html_parser_video_widget.dart';
import 'component/html_parser_webview_widget.dart';
import 'html_parser_shared.dart';

extension HtmlWidgetBuilderExtension on HtmlParserElement {
  Widget buildWidget(BuildContext context) {
    switch (type) {
      case HtmlParserElementType.custom:
        return HtmlParserCustomWidget(element: this);
      case HtmlParserElementType.video:
        return HtmlParserVideoWidget(element: this);
      case HtmlParserElementType.webview:
        return HtmlParserWebviewWidget(element: this);
      case HtmlParserElementType.image:
        return HtmlParserImageWidget(element: this);
      case HtmlParserElementType.breakline:
        return Container(
          height: 20,
        );
      default:
        return HtmlParserTextWidget(element: this);
    }
  }

  TextStyle getTextStyle(int size) {
    FontWeight fontWeight = FontWeight.normal;
    FontStyle fontStyle = FontStyle.normal;
    double lineHeight = 1.5;
    double fontSize = size + 16;
    switch (style) {
      case HtmlParserElementTextStyle.bold:
        fontWeight = FontWeight.bold;
        break;
      case HtmlParserElementTextStyle.boldItalic:
        fontWeight = FontWeight.bold;
        fontStyle = FontStyle.italic;
        break;
      case HtmlParserElementTextStyle.italic:
        fontStyle = FontStyle.italic;
        break;
      case HtmlParserElementTextStyle.note:
        fontStyle = FontStyle.italic;
        fontSize -= 2;
        break;

      default:
        break;
    }
    return TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        height: lineHeight);
  }

  EdgeInsets getPadding() {
    if (tagName == "text") {
      return const EdgeInsets.only(top: 0);
    }
    return const EdgeInsets.only(top: 10);
  }

  double? getWidth(BuildContext context) {
    return MediaQuery.of(context).size.width - 20;
  }

  double? getHeight(BuildContext context) {
    return null;
  }
}

abstract class HtmlParserWidgetBase extends StatelessWidget {
  final HtmlParserElement element;
  const HtmlParserWidgetBase({Key? key, required this.element})
      : super(key: key);
}
