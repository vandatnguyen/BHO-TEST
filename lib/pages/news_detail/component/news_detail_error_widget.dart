import 'package:finews_module/configs/constants.dart';
import 'package:finews_module/utils/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewsDetailErrorWidget extends StatelessWidget {
  final VoidCallback? onTap;
  final String error;

  const NewsDetailErrorWidget({Key? key, this.onTap, required this.error}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Center(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
      children: [
        SIZED_BOX_H12,
        SizedBox(width: 160, height: 160, child: Image.asset("assets/images/banner_error.png", package: 'finews_module')),
        SIZED_BOX_H12,
        Text(error, style: const TextStyle(fontSize: 16, color: Color(0xFF777E91))),
        SIZED_BOX_H16,
         GestureDetector(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.only(
                  left: 54, top: 12, right: 54, bottom: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(1000),
                color: HexColor.fromHex('#58BD7D'),
              ),
              child: const Text(
                      "Thử lại",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        // fontFamily: 'iCielHelveticaNowText',
                        fontWeight: FontWeight.w700,
                        decoration: TextDecoration.none,
                      ),
                    ),
            ),
          ),
          SIZED_BOX_H30,
      ],
    ),
      ),
    );
  }
  
}