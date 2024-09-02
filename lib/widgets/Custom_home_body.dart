import 'package:flutter/material.dart';
import 'package:shopapp/views/Manage_debts.dart';
import 'package:shopapp/views/product_mange_view.dart';
import 'package:shopapp/views/recourd_view.dart';
import 'package:shopapp/widgets/custom_Primary_card.dart';
import 'package:shopapp/widgets/custom_bottom_card.dart';

class CustemBody extends StatelessWidget {
  const CustemBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 100,
        ),
        const CustomPrimaryCard(
          text: 'اجمالى المبيعات اليوميه',
        ),
        const SizedBox(
          height: 20,
        ),
        const CustomPrimaryCard(
          text: 'اجمالى الديون المسحقه',
        ),
        const SizedBox(
          height: 20,
        ),
        const CustomPrimaryCard(
          text: 'عدد العملاء اليوم',
        ),
        const SizedBox(
          height: 200,
        ),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ManageDebts();
                    },
                  ),
                );
              },
              child: const CustomBottomCard(
                text: 'اداره الديون',
              ),
            ),
            const Spacer(
              flex: 1,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ProductMangeView();
                }));
              },
              child: const CustomBottomCard(
                text: "إدارة المنتجات",
              ),
            ),
            const Spacer(
              flex: 1,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return RecourdView();
                    },
                  ),
                );
              },
              child: const CustomBottomCard(
                text: "تسجيل المبيعات",
              ),
            ),
          ],
        )
      ],
    );
  }
}
