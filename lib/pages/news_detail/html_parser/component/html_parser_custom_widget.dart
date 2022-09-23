import 'package:cached_network_image/cached_network_image.dart';
import 'package:finews_module/configs/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../html_parser_shared.dart';
import '../html_parser_widget.dart';
import 'html_custom_render_widget.dart';
import 'package:flutter_html_all/flutter_html_all.dart';

class HtmlParserCustomWidget extends HtmlParserWidgetBase {
  const HtmlParserCustomWidget({required HtmlParserElement element})
      : super(element: element);

  @override
  Widget build(BuildContext context) {
    print(element.content);
  
    return ClipRect(
      child: Html(
        data: element.content,
        shrinkWrap: false,
         customRenders: {
          iframeCustomMatcher() :  iframeCustomRender(),
          networkSourceMatcher(): networkImageCustomRender(),
          tableMatcher(): tableRender(), 
          svgTagMatcher(): svgTagRender(),
          svgDataUriMatcher(): svgDataImageRender(),
          svgAssetUriMatcher(): svgAssetImageRender(),
          svgNetworkSourceMatcher(): svgNetworkImageRender(),
          videoMatcher(): videoRender(),
          audioMatcher(): audioRender(),  
        }, 
        style: {
          "img": Style( 
            width: MediaQuery.of(context).size.width,
          ),
        },
      ),
    );
  }
}
