import 'package:finews_module/pages/home/main_tikop_provider.dart';
import 'package:finews_module/pages/home/main_trading_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class NewsDetailHeader extends StatelessWidget {
  final String title;
  final String sourceName;
  final String desc;
  final String date;
  const NewsDetailHeader({Key? key, required this.title, required this.sourceName,  required this.date,  required this.desc}) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SafeArea(
            child: SizedBox(
              height: 80,
            ),
            bottom: false,
          ),
          Text(title,
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 24,
          ),
          Row(
            children: [
              Text(
                sourceName,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF9CA3AF)),
              ),
              const SizedBox(
                width: 8,
              ),
              ClipOval(
                child: Container(
                  color: const Color(0xFF9CA3AF),
                  width: 4,
                  height: 4,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                date,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF9CA3AF)),
              )
            ],
          ),
          const SizedBox(
            height: 14,
          ),
          RichText(text: getDesTextSpan(desc, const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF454545))))
          ,
          // Text(
          //   desc,
          //   style: const TextStyle(
          //       fontSize: 16,
          //       fontWeight: FontWeight.bold,
          //       color: Color(0xFF454545)),
          // ),
          const SizedBox(
            height: 14,
          ),
        ],
      ),
    );
  }

  TextSpan getDesTextSpan(String desc, TextStyle textStyle){
    List<TextSpan> listTextSpan = <TextSpan>[];
    var splitSym = desc.split("@@@***");
    if (splitSym.length > 1) {
      int index = 0;
      for (var sym in splitSym) {
        if (index == 0) {
          var textSpan =
          TextSpan(text: sym, style: textStyle);
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
                  String sym = split2[0];
                  sym = sym.replaceAll(",", "").replaceAll(".", "").replaceAll(")", "").replaceAll("(", "").removeAllWhitespace;
                  Get.find<MainFiNewsTikopProvider>().openStockDetail?.call(sym);
                });
          listTextSpan.add(textSpanSym);
          var textSpan = TextSpan(
              text: sym.substring(split2[0].length, sym.length),
              style: textStyle);
          listTextSpan.add(textSpan);
        }
      }
    }else{
      var textSpan = TextSpan(
          text: desc,
          style: textStyle);
      listTextSpan.add(textSpan);
    }
    return TextSpan(
      style: textStyle,
      children: listTextSpan,
    );
  }
}
