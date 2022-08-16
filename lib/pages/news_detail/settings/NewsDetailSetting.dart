import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'; 
import '../widget/FontSizeSlider.dart';
import '../widget/SwithDarkNightButton.dart';

class NewsDetailSetting extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NewsDetailSettingState();
  }
}

class _NewsDetailSettingState extends State<NewsDetailSetting> {
  final TextStyle gTitleStyle = const TextStyle(
      fontSize: 16, fontWeight: FontWeight.normal, color: Color(0xFF9CA3AF));
  final TextStyle gLabelStyle =
      const TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height, color: Colors.black.withAlpha(1),),
        ),
        DraggableScrollableSheet(
      initialChildSize: 0.75, //set this as you want
      maxChildSize: 0.75, //set this as you want
      minChildSize: 0.75, //set this as you want
      expand: true,
      builder: (context, scrollController) {
        return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(35), topRight: Radius.circular(35))),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 24),
              child: Text("Cài đặt hiển thị",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ),
          Text("Chế độ", style: gTitleStyle),
          const SizedBox(
            height: 12,
          ),
          Row(
            children: [
              Expanded(child: Text("Sang", style: gLabelStyle)),
              SwithDarkNightButton()
            ],
          ),
          const SizedBox(
            height: 32,
          ),
          Text("Cỡ chữ", style: gTitleStyle),
           const SizedBox(
            height: 12,
          ),
          SizedBox(
            height: 40,
            child: FontSizeSlider(),
          ),
          const SizedBox(
            height: 24,
          ),
          Text("Độ sáng", style: gTitleStyle),
           const SizedBox(
            height: 12,
          ),
          SizedBox(height: 40, child: BrightnessSlider()),
          const SizedBox(
            height: 24,
          ),
          /* Text("Màu sắc", style: gTitleStyle),
          SizedBox(height: 40, child: BrightnessSlider()),*/
          Container(
            height: 56,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: const Color(0xFF58BD7D),
                borderRadius: BorderRadius.circular(28)),
            child: const Text("Áp dụng",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
          )
        ],
      ),
    ); //whatever you're returning, does not have to be a Container
      }
    )
    
      ],
    ); 
  }
}
