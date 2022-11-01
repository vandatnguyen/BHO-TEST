import 'package:finews_module/configs/constants.dart';
import 'package:finews_module/utils/extensions.dart';
import 'package:flutter/material.dart';

class ListNoDataBackground extends StatelessWidget {
  const ListNoDataBackground({
    required this.pngPath,
    this.title,
    this.desc,
    this.padding = EdgeInsets.zero,
    this.btnTitle,
    this.showIconButton = true,
    this.isLoading = false,
    this.onPressed,
    Key? key,
  }) : super(key: key);

  final String pngPath;
  final String? title;
  final String? desc;
  final EdgeInsets padding;
  final bool showIconButton;
  final bool isLoading;

  final String? btnTitle;
  final VoidCallback? onPressed;

  factory ListNoDataBackground.png(String path,
      {String? desc, EdgeInsets padding = EdgeInsets.zero}) {
    return ListNoDataBackground(
      pngPath: path,
      desc: desc,
      padding: padding,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: padding,
          child: isLoading
              ? Container(
                  child: const SizedBox(
                    child: CircularProgressIndicator(),
                    width: 50,
                    height: 50,
                  ),
                  width: 150,
                  height: 150,
                  padding: EdgeInsets.symmetric(vertical: 50, horizontal: 50),
                )
              : Image.asset(
                  pngPath,
                  package: "finews_module",
                  width: 150,
                  height: 150,
                ),
        ),
        SIZED_BOX_H12,
        // if (title != null)
        //   Text(
        //     title!,
        //     // style: context.textSize16.copyWith(
        //     //     fontWeight: FontWeight.bold, color: const Color(0xFF333333)),
        //     textAlign: TextAlign.center,
        //   ),
        // SIZED_BOX_H12,
        if (desc != null)
          Text(
            desc!,
            style: context.textSize14.copyWith(
                fontWeight: FontWeight.normal, color: const Color(0xFF5C5C5C)),
            textAlign: TextAlign.center,
          ),
        SIZED_BOX_H12,
        GestureDetector(
          onTap: () {
            onPressed!();
          },
          child: Container(
            padding:
                const EdgeInsets.only(left: 54, top: 12, right: 54, bottom: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(1000),
              color: (btnTitle != null)
                  ? HexColor.fromHex('#58BD7D')
                  : Colors.transparent,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                if (showIconButton)
                  // Row(
                  //   mainAxisSize: MainAxisSize.min,
                  //   children: <Widget>[
                  //     Image.asset("assets/images/png/ic_add.png",
                  //         package: "finews_module"),
                  //     SIZED_BOX_W12,
                  //   ],
                  // ),
                  Text(
                    btnTitle ?? "",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      // fontFamily: 'iCielHelveticaNowText',
                      fontWeight: FontWeight.w700,
                      decoration: TextDecoration.none,
                    ),
                  )
              ],
            ),
          ),
        ),
        SIZED_BOX_H12,
      ],
    );
  }
}
