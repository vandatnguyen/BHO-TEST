import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    if (cacheTextStyle != null) {
      return cacheTextStyle!;
    }
    FontWeight fontWeight = FontWeight.normal;
    Color? color = null;
    FontStyle fontStyle = FontStyle.normal;
    double lineHeight = 1.5;
    double fontSize = size + 16;
    switch (style) {
      case HtmlParserElementTextStyle.bold:
        fontWeight = FontWeight.w700;
        break;
      case HtmlParserElementTextStyle.boldItalic:
        fontWeight = FontWeight.w700;
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
    if (attachmentLink != null) {
      color = Theme.of(Get.context!).highlightColor;
    }
    
   TextStyle? classStyle;
   TextStyle? tagStyle;
     /*TextStyle? tagStyle = getBasicStyleByTag(Get.context!,tagName);
    
    

    className?.forEach((element) {
      var buildStyle = getBasicStyleByClassName(Get.context!, element );
      if (classStyle == null) {
          classStyle = buildStyle;
      } else if (buildStyle != null) {
       classStyle =  classStyle?.merge(buildStyle);
      } 
    });*/
    
   
    var builStyle = TextStyle(
        color: color ,
        fontSize:  fontSize,
        fontWeight:  fontWeight,
        fontStyle:  fontStyle,
        height: lineHeight);

    if (tagStyle != null) {
      builStyle = builStyle.merge(tagStyle);
    }
     if (classStyle != null) {
      builStyle = builStyle.merge(classStyle);
    }
    cacheTextStyle = builStyle;
    return builStyle;
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

class HtmlKeepAliveWidget extends StatefulWidget {
   final HtmlParserElement element;

  const HtmlKeepAliveWidget({Key? key,required  this.element}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return HtmlKeepAliveState();
  }
  
}

class HtmlKeepAliveState extends State<HtmlKeepAliveWidget> with AutomaticKeepAliveClientMixin {
  HtmlParserElement? _element;
 

  @override
  Widget build(BuildContext context) {
    return  widget.element.buildWidget(context);
  }

  @override
  bool get wantKeepAlive  { 
    if ( _element != widget.element){
      _element =  widget.element;
      return true;
    }
    return false;
  }
  
}