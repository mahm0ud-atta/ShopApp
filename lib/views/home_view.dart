import 'package:flutter/material.dart';
import 'package:shopapp/widgets/Custom_home_body.dart';

import '../widgets/custem_appar.dart';

class HomeView extends StatelessWidget {
  const HomeView({
    super.key,
  });

  static String id = 'HomeView';
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          CustemAppar(
            text: 'العطا للحدايد والبوهيات',
          ),
          CustemBody()
        ],
      ),
    );
  }
}
