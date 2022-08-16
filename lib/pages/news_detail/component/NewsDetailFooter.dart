import 'package:flutter/material.dart';

typedef NewsDetailFooterTagCallback = void Function (String tag);
typedef NewsDetailFooterSourceCallback = void Function ();

class NewsDetailFooter extends StatelessWidget {
  final List<String> tags;
  final NewsDetailFooterTagCallback? onTapTag;
  final NewsDetailFooterSourceCallback? onTapSource;
  
  final String originSrc;
  const NewsDetailFooter({Key? key, required this.originSrc, required this.tags , this.onTapSource, this.onTapTag}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      padding:const EdgeInsets.only(top: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          height: 24,
          decoration: BoxDecoration(
            color: const Color(0xFFF4F5F7),
            borderRadius: BorderRadius.circular(12),
          ),
          child: GestureDetector(
            onTap: (){
              if (onTapSource != null) {
               onTapSource!();
              }
            },
            child: Row(
            children:  [
               const SizedBox(
                width: 16,
                height: 16,
                child: Icon(
                  Icons.info_outline,
                  color: Color(0xFF7D8498),
                  size: 16,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                  child: Text(
                originSrc,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ))
            ],
          )),
        ),
        const SizedBox(height: 10,),
        Wrap(
          children: tags.map<Widget>((e) => GestureDetector(
          onTap: () {
            if (onTapTag != null) { 
              onTapTag!(e);
            }
          },
          child: Container(
          margin: const EdgeInsets.only(right: 8,bottom: 8),
          decoration:  BoxDecoration(
            border:  Border.all(color: const Color(0xFFE8E8E8),),
            borderRadius: BorderRadius.circular(8)
          ),
          padding: const EdgeInsets.symmetric(horizontal: 22,vertical: 7),
          child: Text(e, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),),
        ),)
        ).toList())
      ],
    ));
  }
}
