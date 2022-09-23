import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class NewsDetailFixedHeader extends StatelessWidget {
  final Color backgroundColor;
  final Color foregroundColor;
  final String title;

  final VoidCallback? onBack;
  final VoidCallback? onSetting;
  final VoidCallback? onBookmark;

  const NewsDetailFixedHeader(
      {Key? key,
      required this.title,
      this.backgroundColor = const Color(0xFFFDFDFD),
      this.foregroundColor = const Color(0xFF000000),
      this.onBack,
      this.onSetting,
      this.onBookmark})
      : super(key: key);
  @override
  Widget build(Object context) {
    return ClipRect(
      child: Container(
          color: backgroundColor.withOpacity(1),
          child:  SafeArea(
                bottom: false,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                  child: Row(
                    children: [
                      InkWell(
                        child: SizedBox(
                          width: 40,
                          height: 40,
                          child: Icon(Icons.arrow_back, color: foregroundColor),
                        ),
                        onTap: () {
                          if (onBack != null) {
                            onBack!();
                          }
                        },
                      ),
                      Expanded(
                          child: Text(
                        title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: foregroundColor),
                      )),
                     //  InkWell(
                     //    child: SizedBox(
                     //      width: 30,
                     //      height: 30,
                     //      child: ImageIcon( const AssetImage("assets/images/ic_font_setting.png", package:  'finews_module'), color: foregroundColor)
                     //          //Icon(Icons.text_decrease, color: foregroundColor),
                     //    ),
                     //    onTap: () {
                     //      if (onSetting != null) {
                     //        onSetting!();
                     //      }
                     //    },
                     //  ),
                     // const SizedBox(width: 10,),
                     //  InkWell(
                     //    child: SizedBox(
                     //      width: 30,
                     //      height: 30,
                     //      child: ImageIcon( const AssetImage("assets/images/ic_bookmark.png", package:  'finews_module'), color: foregroundColor)
                     //         // Icon(Icons.bookmark_add, color: foregroundColor),
                     //    ),
                     //    onTap: () {
                     //      if (onBookmark != null) {
                     //        onBookmark!();
                     //      }
                     //    },
                     //  )
                    ],
                  ),
                )),
          ),
    );
  }
}
