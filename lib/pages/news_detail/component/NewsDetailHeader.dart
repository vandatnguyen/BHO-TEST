import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
          ),Text(
            desc,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF454545)),
          ),const SizedBox(
            height: 14,
          ),
        ],
      ),
    );
  }
}
