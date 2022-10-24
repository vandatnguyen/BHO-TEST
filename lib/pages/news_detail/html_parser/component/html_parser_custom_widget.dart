import 'package:finews_module/pages/news_detail/html_parser/component/flutter_custom_html_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import '../html_parser_shared.dart';
import '../html_parser_widget.dart';
import 'html_custom_render_widget.dart';
import 'package:flutter_html_all/flutter_html_all.dart';

class HtmlParserCustomWidget extends HtmlParserWidgetBase {
  const HtmlParserCustomWidget({required HtmlParserElement element})
      : super(element: element);

  @override
  Widget build(BuildContext context) {

    return ClipRect(
      child: Html(
        data: element.content,
        shrinkWrap: false,
         customRenders: {
          iframeCustomMatcher() :  iframeCustomRender(),
          networkSourceMatcher(): networkImageCustomRender(),
          tableMatcher(): tableCustomRender(),
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
