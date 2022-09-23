import 'package:finews_module/theme/app_color.dart'; 
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/style.dart';
import 'package:get/get.dart';

enum HtmlParserElementTextStyle { normal, bold, italic, note, boldItalic }

enum HtmlParserElementType {
  text,
  image,
  video,
  table,
  group,
  breakline,
  webview,
  custom
}

class HtmlParserElement {
  String tagName;
  HtmlParserElementTextStyle? style;
  dynamic content;
  HtmlParserElementType type;
  String? attachmentLink;
  List<HtmlParserElement>? children;
  List<String>? className;

  TextStyle? cacheTextStyle;

  HtmlParserElement(
      {required this.tagName,
      this.style,
      this.content,
      required this.type,
      this.attachmentLink,
      this.children,
      this.className});

  @override
  String toString() {
    return "$tagName ($content): children (${children == null ? 0 : children?.length})";
  }

  String toText() {
    if (content is String) {
      return content;
    }
    return content.toString();
  }
} 
 
 Map<String, Style> buildHtmlStyle (BuildContext context, int sizeAdd) {
  var screenWidth = MediaQuery.of(context).size.width - 20;
  
  return {
    "p": Style(  
        margin:  EdgeInsets.zero ,
        padding: EdgeInsets.zero ,
        fontSize: const FontSize(16),
        lineHeight: const LineHeight(1.4),
         fontWeight: FontWeight.w400
    ),
    "div": Style( 
        
        margin:  EdgeInsets.zero ,
        padding: EdgeInsets.zero,
        
    ),
     
    "img": Style(
       margin: const EdgeInsets.only(top: 10),
    ),
     
    "ul": Style(
      lineHeight: const LineHeight(1.4),
      fontSize: const FontSize(16),
      fontWeight: FontWeight.w400
    ) ,
    "li": Style(
      lineHeight: const LineHeight(1.4),
      fontSize: const FontSize(16),
      fontWeight: FontWeight.w400
    )
  } ;
  }