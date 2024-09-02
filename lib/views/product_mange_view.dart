import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/models/product_item_model.dart';
import 'package:shopapp/providers/product_provider.dart';
import 'package:shopapp/widgets/custem_appar.dart';

class ProductMangeView extends StatefulWidget {
  const ProductMangeView({super.key});

  @override
  State<ProductMangeView> createState() => _ProductMangeViewState();
}

class _ProductMangeViewState extends State<ProductMangeView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController quntityControler = TextEditingController();
  List<ProductItemModel> selectProduct = []; // قائمة المنتجات المختارة
  final GlobalKey<FormState> mainFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: mainFormKey, // ربط النموذج بالمفتاح الرئيسي
      child: Scaffold(
        body: Column(
          children: [
            const CustemAppar(
              text: 'إدارة المنتجات',
            ),
            const SizedBox(
              height: 20,
            ),
            selectProduct.isEmpty
                ? Center(
                    child: Text('لا توجد منتجات محددة حاليًا.'),
                  )
                : Consumer<ProductProvider>(
                    builder: (context, productProvider, child) {
                      return DataTable(
                        columns: const [
                          DataColumn(label: Text('المنتج')),
                          DataColumn(label: Text(' الكميه المتاحه')),
                          DataColumn(label: Text('السعر')),
                          DataColumn(label: Text('الإجمالي')),
                        ],
                        rows: productProvider.products
                            .map((ProductItemModel product) {
                          double total = product.quantity * product.price;
                          return DataRow(
                            cells: [
                              DataCell(Text(product.name)),
                              DataCell(Text(product.quantity.toString())),
                              DataCell(Text(product.price.toString())),
                              DataCell(Text(total.toString())),
                            ],
                          );
                        }).toList(),
                      );
                    },
                  ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.orange)),
                onPressed: () {
                  _showAddProductDialog(context);
                },
                child: const Text(
                  'إضافة منتج جديد',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ))
          ],
        ),
      ),
    );
  }

  void _showAddProductDialog(BuildContext context) {
    final GlobalKey<FormState> dialogFormKey = GlobalKey<FormState>();
    // مفتاح جديد للـ Dialog

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('إضافة منتج جديد'),
          content: Form(
            key: dialogFormKey, // استخدام المفتاح الجديد هنا
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'اسم المنتج',
                    border: OutlineInputBorder(),
                    errorStyle: TextStyle(color: Colors.red),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'يرجى إدخال اسم المنتج';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: quntityControler,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'الكميه',
                    border: OutlineInputBorder(),
                    errorStyle: TextStyle(color: Colors.red),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'يرجى إدخال الكميه';
                    }
                    if (int.tryParse(value) == null) {
                      return 'يرجى إدخال رقم صالح';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'السعر',
                    border: OutlineInputBorder(),
                    errorStyle: TextStyle(color: Colors.red),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'يرجى إدخال السعر';
                    }
                    if (double.tryParse(value) == null) {
                      return 'يرجى إدخال سعر صالح';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text('إلغاء'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('إضافة'),
              onPressed: () {
                if (dialogFormKey.currentState!.validate()) {
                  dialogFormKey.currentState!.save();
                  setState(() {
                    Provider.of<ProductProvider>(context, listen: false)
                        .addProduct(ProductItemModel(
                      name: nameController.text,
                      quantity: int.parse(quntityControler.text),
                      price: double.parse(priceController.text),
                    ));
                    // مسح الحقول النصية
                    nameController.clear();
                    quntityControler.clear();
                    priceController.clear();
                  });
                  Navigator.of(context).pop(); // إغلاق النافذة
                }
              },
            ),
          ],
        );
      },
    );
  }
}
