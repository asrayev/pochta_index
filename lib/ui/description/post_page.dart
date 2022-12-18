import 'package:flutter/material.dart';
import 'package:pochta_index/data/models/pochta_model.dart';
import 'package:pochta_index/utils/media_query.dart';

import '../../utils/my_colors.dart';

class FullInfoPage extends StatefulWidget {
  PochtaModel postage;
  FullInfoPage({required this.postage, Key? key}) : super(key: key);

  @override
  State<FullInfoPage> createState() => _FullInfoPageState();
}

class _FullInfoPageState extends State<FullInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.C_0F1620,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(m_w(context)*0.04),
          child: Column(
            children: [
              Container(
                height: m_h(context)*0.25,
                width: m_w(context),
                color: MyColors.C_1C2632,
              )

            ],
          ),
        ),
      ),



    );
  }
}
