import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewsDetailStock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: Container(
        padding: const EdgeInsets.all(8),
        color: const Color(0xFFF4F5F6),
        child: Row(
          children: [
            Expanded(
                child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(4)),
              child: Text(
                "DBC",
                style: TextStyle(
                    color: Color(0xFF58BD7D),
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            )),
            const SizedBox(
              width: 10,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Giá",
                  style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 12),
                ),
                const SizedBox(
                  height: 2,
                ),
                Text(
                  "23,800",
                  style: TextStyle(
                      color: Color(0xFF23262F),
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                )
              ],
            )),
            const SizedBox(
              width: 10,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Giá",
                  style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 12),
                ),
                const SizedBox(
                  height: 2,
                ),
                Text(
                  "-800/-3.25% ",
                  style: TextStyle(
                      color: Color(0xFFFF3B30),
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                )
              ],
            )),
            const SizedBox(
              width: 10,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Tổng KL",
                  style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 12),
                ),
                const SizedBox(
                  height: 2,
                ),
                Text(
                  "23,800",
                  style: TextStyle(
                      color: Color(0xFF23262F),
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                )
              ],
            ))
          ],
        ),
      ),
    ));
  }
}
