import 'package:flutter/material.dart';

class NewsDetailTopRelated extends StatelessWidget {
  final category = "Chứng khoán";
  final code = "ANV";
  final source = "CaffeF";
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 14),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                decoration: BoxDecoration(
                    color: Color(0xFF58BD7D),
                    borderRadius: BorderRadius.circular(4)),
                child: Text(
                  code,
                  style: TextStyle(color: Colors.white, fontSize: 13),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                decoration: BoxDecoration(
                    color: Color(0xFFF2F4F7),
                    borderRadius: BorderRadius.circular(4)),
                child: Text(
                  category,
                  style:
                      const TextStyle(color: Color(0xFF8A8A8A), fontSize: 13),
                ),
              ),
              const Expanded(child: SizedBox(width: 5)),
              const SizedBox(
                  width: 30,
                  height: 30,
                  child: Icon(
                    Icons.more_horiz_rounded,
                    size: 20,
                    color: Color(0xFF858689),
                  ))
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                child: Text(
                  "Lãnh đạo DSD muốn gom gần 2 triệu cp sau kết quả tích cực quý 2",
                  style: TextStyle(
                      color: Color(0xFF111827),
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  width: 70,
                  height: 70,
                  child: Container(
                    color: Colors.red,
                  ),
                ),
              )
            ],
          ),
          Row(
            children: [
              Container(
                child: Text(
                  source,
                  style: const TextStyle(
                      color: Color(0xFF858689),
                      fontSize: 13,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              const SizedBox(
                width: 16,
                height: 16,
                child: Icon(Icons.timelapse_outlined,
                    size: 16, color: Color(0xFF9CA3AF)),
              ),
              const SizedBox(width: 4),
              Container(
                child: Text(
                  category,
                  style:
                      const TextStyle(color: Color(0xFF9CA3AF), fontSize: 13),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              const SizedBox(
                width: 16,
                height: 16,
                child: Icon(Icons.comment_outlined,
                    size: 16, color: Color(0xFF9CA3AF)),
              ),
              const SizedBox(width: 4),
              Container(
                child: Text(
                  "23",
                  style:
                      const TextStyle(color: Color(0xFF9CA3AF), fontSize: 13),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
