import 'package:flutter/material.dart';

class CustomBottomCard extends StatelessWidget {
  const CustomBottomCard({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 135,
      child: Card(
        color: Colors.orange,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 3),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
