import 'package:cached_network_image/cached_network_image.dart';
import 'package:finews_module/configs/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../html_parser_shared.dart';
import '../html_parser_widget.dart';

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
         customRender: {
          "iframe": ((context, parsedChild) { 
            String? url = context.tree.attributes["src"]; 
              double? givenHeight = null ;//double.tryParse(context.tree.element?.attributes['height'] ?? "");
  
            if (url == null) {
              return SIZED_BOX_H02;
            }

            return SizedBox(
              width: MediaQuery.of(context.buildContext).size.width,
              height: givenHeight ??  (MediaQuery.of(context.buildContext).size.width *  9/ 16), child: WebView(
        initialUrl: url,
        key: key,
        javascriptMode: JavascriptMode.unrestricted,
 
        gestureRecognizers: {
          Factory<VerticalDragGestureRecognizer>(() => VerticalDragGestureRecognizer())
        },
      ));
          })
        },
        customImageRenders:  {
          networkSourceMatcher(): (context, attributes, element) {
            return ClipRRect(
              borderRadius:  BorderRadius.circular(10),
              child:  CachedNetworkImage( 
                      fit: BoxFit.cover,
                      imageUrl: attributes["src"] ??"",
                      placeholder: (context, url) => Transform.scale(
                        scale: 0.5,
                        child: const SizedBox(width: 18, height: 18, child:   CircularProgressIndicator()),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),);
          }
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
