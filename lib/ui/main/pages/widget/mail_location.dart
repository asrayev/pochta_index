import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:pochta_index/utils/media_query.dart';
import 'package:pochta_index/utils/my_lotties.dart';

class MailLocationTurn extends StatelessWidget {
  const MailLocationTurn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          SizedBox(height: m_h(context)*0.1,),
          Padding(
            padding: const EdgeInsets.all(40).r,
            child: Container(
              child: Lottie.asset(MyLottie.location_turn),
            ),
          ),
        ],
    );
  }
}
