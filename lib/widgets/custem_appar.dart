import 'package:flutter/material.dart';

class CustemAppar extends StatelessWidget {
  const CustemAppar({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.blue,
      child: Padding(
        padding: const EdgeInsets.only(top: 70, bottom: 30, right: 15),
        child: Row(
          children: [
            const Icon(Icons.format_paint_sharp),
            Text(
              textDirection: TextDirection.rtl,
              text,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
