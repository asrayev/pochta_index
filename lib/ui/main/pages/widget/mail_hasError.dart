import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:pochta_index/utils/media_query.dart';
import 'package:pochta_index/utils/my_lotties.dart';

class MailHasError extends StatelessWidget {
  const MailHasError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          SizedBox(height: m_h(context)*0.25,),
          Padding(
            padding: const EdgeInsets.all(10).r,
            child: Container(
              child: Lottie.asset(MyLottie.disconnect),
            ),
          ),
        ],
      );
  }
}
