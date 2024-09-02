import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/models/product_item_model.dart';
import 'package:shopapp/providers/product_provider.dart';
import 'package:shopapp/widgets/Custom_DataTable.dart';
import 'package:shopapp/widgets/Custom_amount_textFeild.dart';
import 'package:shopapp/widgets/custem_appar.dart';

class RecourdView extends StatefulWidget {
  const RecourdView({super.key});

  @override
  State<RecourdView> createState() => _RecourdViewState();
}

class _RecourdViewState extends State<RecourdView> {
  ProductItemModel? selectedProduct;
  TextEditingController quantityController = TextEditingController();
  List<ProductItemModel> selectedProducts = [];

  double calculateTotal() {
    double total = 0;
    for (var product in selectedProducts) {
      total += product.quantity * product.price;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustemAppar(
            text: 'تسجيل المنتجات',
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                flex: 2, // نسبة العرض
                child: Consumer<ProductProvider>(
                    builder: (context, productProvider, child) {
                  return DropdownButton<ProductItemModel>(
                    value: selectedProduct,
                    hint: Text('اختر منتجًا'),
                    items: productProvider.products.map((product) {
                      return DropdownMenuItem<ProductItemModel>(
                        value: product,
                        child: Text(product.name),
                      );
                    }).toList(),
                    onChanged: (ProductItemModel? newValue) {
                      setState(() {
                        selectedProduct = newValue;
                      });
                    },
                    isExpanded: true, // لتجنب القص في القائمة المنسدلة
                  );
                }),
              ),
              SizedBox(width: 20), // مسافة بين القائمة وحقل الكمية
              Expanded(
                flex: 1, // نسبة العرض
                child: CusteomAmountTextField(
                    quantityController: quantityController),
              ),
            ],
          ),
          SizedBox(height: 20),
          ElevatedButton(
            style: ButtonStyle(
                foregroundColor: WidgetStateProperty.all(Colors.black),
                backgroundColor: WidgetStateProperty.all(Colors.orange)),
            onPressed: () {
              if (selectedProduct != null &&
                  quantityController.text.isNotEmpty) {
                setState(() {
                  selectedProducts.add(
                    ProductItemModel(
                      name: selectedProduct!.name,
                      quantity: int.parse(quantityController.text),
                      price: 10.0, // سعر افتراضي للمنتج
                    ),
                  );
                  // إعادة تعيين الحقول
                  selectedProduct = null;
                  quantityController.clear();
                });
              }
            },
            child: Text('إضافة إلى السلة'),
          ),
          SizedBox(height: 20),
          CustomDataTable(selectedProducts: selectedProducts),
          SizedBox(height: 20),
          ElevatedButton(
            style: ButtonStyle(
                foregroundColor: WidgetStateProperty.all(Colors.black),
                backgroundColor: WidgetStateProperty.all(Colors.orange)),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('تأكيد البيع'),
                    content: Text(
                        'المجموع النهائي: ${calculateTotal().toStringAsFixed(2)}\nهل أنت متأكد من إتمام عملية البيع؟'),
                    actions: [
                      TextButton(
                        child: Text('إلغاء'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      ElevatedButton(
                        child: Text('تأكيد'),
                        onPressed: () {
                          setState(() {
                            selectedProducts.clear(); // تفريغ السلة بعد البيع
                          });
                          Navigator.of(context).pop(); // إغلاق النافذة
                        },
                      ),
                    ],
                  );
                },
              );
            },
            child: Text('إتمام البيع'),
          ),
        ],
      ),
    );
  }
}
