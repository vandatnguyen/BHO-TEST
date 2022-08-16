import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../html_parser_shared.dart';
import '../html_parser_widget.dart';

class HtmlParserImageWidget extends HtmlParserWidgetBase {
  const HtmlParserImageWidget({required HtmlParserElement element})
      : super(element: element);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: element.getPadding(),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: CachedNetworkImage( imageUrl:  element.content["src"],
      fit: BoxFit.cover,
          width: element.getWidth(), height: element.getHeight())),
    );
  }
}
