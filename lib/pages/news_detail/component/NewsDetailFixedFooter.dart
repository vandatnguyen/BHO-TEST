import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class NewsDetailFixedFooter extends StatelessWidget {
  final Color backgroundColor;
  final Color foregroundColor;

  const NewsDetailFixedFooter(
      {Key? key,
      this.backgroundColor = const Color(0xFFF5F5F5),
      this.foregroundColor = const Color(0xFF7A7A7A)})
      : super(key: key);
  @override
  Widget build(Object context) {
    return ClipRect(
        child: Container(
              color: backgroundColor.withOpacity(0.98),
            child: BackdropFilter(
              filter: ui.ImageFilter.blur(
                sigmaX: 5.0,
              sigmaY: 5.0,
              ),
              child: SafeArea(
                  top: false,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 12),
                    child: Row(
                      children: [
                        Expanded(
                            child: Container(
                          padding: const EdgeInsets.only(left: 12),
                          height: 40,
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: const Color(0xFFE8E8E8)),
                          child: Text(
                            "Viết bình luận",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 16,
                                color: foregroundColor),
                          ),
                        )),
                        const SizedBox(
                          width: 16,
                        ),
                        SizedBox(
                          width: 30,
                          height: 30,
                          child:  ImageIcon( const AssetImage("assets/images/ic_relative.png", package:  'finews_module'), color: foregroundColor)
                           
                          //Icon(Icons.policy, color: foregroundColor),
                        ),
                        SizedBox(
                          width: 30,
                          height: 30,
                          child: ImageIcon( const AssetImage("assets/images/ic_share.png", package:  'finews_module'), color: foregroundColor)
                           
                          // Icon(Icons.share, color: foregroundColor),
                        )
                      ],
                    ),
                  )),
            )));
  }
}
