import 'package:flutter/material.dart';
import 'package:shopapp/models/manage_debts_model.dart';
import 'package:shopapp/widgets/custem_appar.dart';

class ManageDebts extends StatefulWidget {
  const ManageDebts({super.key});

  @override
  State<ManageDebts> createState() => _ManageDebtsState();
}

class _ManageDebtsState extends State<ManageDebts> {
  TextEditingController clientNameControler = TextEditingController();
  TextEditingController amountControler = TextEditingController();
  TextEditingController dateControler = TextEditingController();
  List<ManageDebtsModel> addDebts = [];
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: Column(
          children: [
            const CustemAppar(
              text: 'ادارة الديون',
            ),
            addDebts.isEmpty
                ? const Center(
                    child: Text('لا يوجد ديون لعرضها'),
                  )
                : DataTable(
                    columns: const [
                      DataColumn(label: Text('تاريخ الاستحقاق')),
                      DataColumn(label: Text('المبلغ')),
                      DataColumn(label: Text('اسم العميل')),
                    ],
                    rows: addDebts.map((product) {
                      return DataRow(
                        cells: [
                          DataCell(
                            Text(product.date.toString()),
                          ),
                          DataCell(
                            Text(product.amount.toString()),
                          ),
                          DataCell(
                            Text(product.clientName),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
            ElevatedButton(
                style: ButtonStyle(
                    foregroundColor: WidgetStateProperty.all(Colors.black),
                    backgroundColor: WidgetStateProperty.all(Colors.orange)),
                onPressed: () {
                  showDialogToAddDebts();
                },
                child: const Text('اضافه دين')),
          ],
        ),
      ),
    );
  }

  void showDialogToAddDebts() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'اضافة دين',
            style: TextStyle(),
            textDirection: TextDirection.rtl,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextFieldToAddDebts(
                text: 'اسم العميل',
                controller: clientNameControler,
                validate: (value) {
                  if (value == null || value.isEmpty) {
                    return 'يرجى ادخال اسم العميل';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextFieldToAddDebts(
                keyBourd: TextInputType.number,
                text: "المبلغ",
                controller: amountControler,
                validate: (value) {
                  if (value == null || value.isEmpty) {
                    return 'يرجى ادخال المبلغ';
                  }
                  if (double.tryParse(value) == null) {
                    return 'يررجى ادخال مبلغ صالح';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextFieldToAddDebts(
                text: "تاريخ الستحقاق",
                controller: dateControler,
                validate: (value) {
                  if (value == null || value.isEmpty) {
                    return 'يرجى ادخال  date';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('الغاء')),
            ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save;
                    setState(() {
                      addDebts.add(ManageDebtsModel(
                          clientName: clientNameControler.text,
                          amount: double.parse(amountControler.text),
                          date: dateControler.text));
                      clientNameControler.clear();
                      amountControler.clear();
                      dateControler.clear();
                    });
                    Navigator.of(context).pop();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('يرجى ملء جميع الحقول بشكل صحيح'),
                      ),
                    );
                  }
                },
                child: const Text('اضافه'))
          ],
        );
      },
    );
  }
}

class CustomTextFieldToAddDebts extends StatelessWidget {
  const CustomTextFieldToAddDebts({
    super.key,
    required this.text,
    required this.controller,
    this.validate,
    this.keyBourd,
  });

  final String text;
  final TextEditingController controller;
  final FormFieldValidator<String>? validate;
  final TextInputType? keyBourd;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyBourd,
      validator: validate,
      controller: controller,
      decoration: InputDecoration(
        errorStyle: TextStyle(color: Colors.red),
        border: OutlineInputBorder(),
        label: Text(text),
      ),
    );
  }
}
