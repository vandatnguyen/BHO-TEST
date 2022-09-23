import 'package:cached_network_image/cached_network_image.dart';
import 'package:finews_module/configs/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:webview_flutter/webview_flutter.dart';

CustomRenderMatcher iframeCustomMatcher() => (context) {
      return context.tree.element?.localName == "iframe";
    };

CustomRender iframeCustomRender() =>
    CustomRender.widget(widget: (context, buildChildren) {
      final String? src = context.tree.element!.attributes.cast()["src"];
      double? givenHeight = null; //double.tryParse(context.tree.element?.attributes['height'] ?? "");

      if (src == null) {
        return SIZED_BOX_H02;
      }

      return SizedBox(
          width: MediaQuery.of(context.buildContext).size.width,
          height: givenHeight ??
              (MediaQuery.of(context.buildContext).size.width * 9 / 16),
          child: WebView(
            initialUrl: src,
            javascriptMode: JavascriptMode.unrestricted,
            gestureRecognizers: {
              Factory<VerticalDragGestureRecognizer>(
                  () => VerticalDragGestureRecognizer())
            },
          ));
    });

CustomRender networkImageCustomRender() =>
    CustomRender.widget(widget: (context, buildChildren) {
      final String? src = context.tree.element!.attributes.cast()["src"];
      double? givenHeight =
          null; //double.tryParse(context.tree.element?.attributes['height'] ?? "");

      if (src == null) {
        return SIZED_BOX_H02;
      }

      return ClipRRect(
              borderRadius:  BorderRadius.circular(10),
              child:  CachedNetworkImage( 
                      fit: BoxFit.cover,
                      imageUrl: src,
                      placeholder: (context, url) => Transform.scale(
                        scale: 0.5,
                        child: const SizedBox(width: 18, height: 18, child:   CircularProgressIndicator()),
                      ),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),);
    });