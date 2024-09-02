import 'package:flutter/material.dart';
import 'package:shopapp/models/product_item_model.dart';

class CustomDataTable extends StatelessWidget {
  const CustomDataTable({
    super.key,
    required this.selectedProducts,
  });

  final List<ProductItemModel> selectedProducts;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: DataTable(
          columns: [
            DataColumn(label: Text('المنتج')),
            DataColumn(label: Text('الكمية')),
            DataColumn(label: Text('السعر')),
            DataColumn(label: Text('الإجمالي')),
          ],
          rows: selectedProducts
              .map(
                (product) => DataRow(
                  cells: [
                    DataCell(Text(product.name)),
                    DataCell(Text(product.quantity.toString())),
                    DataCell(Text(product.price.toString())),
                    DataCell(
                        Text((product.quantity * product.price).toString())),
                  ],
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
