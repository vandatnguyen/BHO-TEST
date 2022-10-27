import 'package:finews_module/pages/home/main_tikop_provider.dart';
import 'package:finews_module/pages/home/main_trading_provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../html_parser_shared.dart';
import '../html_parser_widget.dart';

class HtmlParserTextWidget extends HtmlParserWidgetBase {
  const HtmlParserTextWidget({required HtmlParserElement element})
      : super(element: element);
  @override
  Widget build(BuildContext context) {

    switch (element.type) {
      case HtmlParserElementType.text:
        List<TextSpan> listTextSpan = <TextSpan>[];
        var splitSym = element.content.toString().split("@@@***");
        if (splitSym.length > 1) {
          int index = 0;
          for (var sym in splitSym) {
            if (index == 0) {
              var textSpan =
              TextSpan(text: sym, style: element.getTextStyle(0));
              listTextSpan.add(textSpan);
              index++;
            } else {
              var split2 = sym.split(" ");
              var textSpanSym = TextSpan(
                  text: split2[0],
                  style: const TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 17),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      try {
                        String sym = split2[0];
                        // Get.find<MainFiNewsTradingProvider>().openStockDetail?.call(sym);
                        Get.find<MainFiNewsTikopProvider>().openStockDetail?.call(sym);
                      } catch (e) {
                        print(e);
                      }
                    });
              listTextSpan.add(textSpanSym);
              var textSpan = TextSpan(
                  text: sym.substring(split2[0].length, sym.length),
                  style: element.getTextStyle(0));
              listTextSpan.add(textSpan);
            }
          }
        } else {
          return Padding(
              padding: element.getPadding(),
              child: Text(element.content, style: element.getTextStyle(0)));
        }
        return Padding(
            padding: element.getPadding(),
            child: RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: listTextSpan,
              ),
            ));
      case HtmlParserElementType.group:
        List<InlineSpan> elements = element.children
                ?.map<InlineSpan>(
                    (e) => TextSpan(text: e.content, style: e.getTextStyle(0)))
                .toList() ??
            [];

        return Text.rich(TextSpan(children: elements));
      default:
        return Text("unknow type ${element.type}");
    }
  }
}
