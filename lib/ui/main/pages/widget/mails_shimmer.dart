import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pochta_index/utils/my_colors.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../utils/media_query.dart';



class MailsShimmer extends StatelessWidget {
  const MailsShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: MyColors.C_1C2632,
      highlightColor: Colors.grey[700]!,
      child: Column(

        children: [
          SizedBox(height: m_h(context)*0.1,),
      Padding(
      padding: EdgeInsets.only(
      right: m_w(context) * 0.03,
        left: m_w(context) * 0.03),
      child: Container(
    height: m_h(context) * 0.2,
      decoration: BoxDecoration(
    color: Colors.blue,
    borderRadius: BorderRadius.circular(25)
      ),

      )),
          SizedBox(
            width: double.infinity,
            height: m_h(context) * 0.6,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: 12,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10, right: 10, left: 10).r,
                  child: Container(
                      height: m_h(context)*0.07,
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.blue,)
                  ),
                );
              },
            ),
          ),
        ],
      ) ,);
  }
}
