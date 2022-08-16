import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../html_parser_shared.dart';
import '../html_parser_widget.dart';

class HtmlParserVideoWidget extends HtmlParserWidgetBase {
  const HtmlParserVideoWidget({required HtmlParserElement element})
      : super(element: element);

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return Text("not support");
    }
    return SizedBox(
      height: MediaQuery.of(context).size.width,
      child: Padding(
          padding: element.getPadding(),
          child: WebView(
            initialUrl: element.content != null ? element.content["src"] : "", 
           
            onPageStarted: (String url) {
              print('Page started loading: $url');
            },
            onPageFinished: (String url) {
              print('Page finished loading: $url');
            },
            gestureNavigationEnabled: true, 
          )),
    );
  }
}
