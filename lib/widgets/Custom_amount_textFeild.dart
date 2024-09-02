import 'package:flutter/material.dart';

class CusteomAmountTextField extends StatelessWidget {
  const CusteomAmountTextField({
    super.key,
    required this.quantityController,
  });

  final TextEditingController quantityController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: quantityController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'الكمية',
        border: OutlineInputBorder(),
      ),
    );
  }
}
