import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pochta_index/utils/my_colors.dart';

import '../../../../utils/media_query.dart';
import '../../../../view_model/ads_view_model.dart';
import 'package:provider/provider.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.C_1C2632,
      body: Padding(
        padding: EdgeInsets.only(left: m_w(context)*0.03, right: m_w(context)*0.03),
        child: Column(
          children: [
            SizedBox(height: m_h(context)*0.07,),
            Center(
              child: Text("About Aplication", style: GoogleFonts.lalezar(color: Colors.white, fontSize: 27.sp, fontWeight: FontWeight.w400),)),
            SizedBox(height: m_h(context)*0.02,),
            Container(
              height: m_h(context)*0.7,
              width: m_w(context)*0.9,
              child: Text(
                "long_text".tr(), style: GoogleFonts.raleway(color: Colors.white),
              ),
            ),


          ],
        ),
      ),
      bottomNavigationBar:  context.read<AdsViewModel>().bannerAd==null?SizedBox():Container(
        height: context.read<AdsViewModel>().bannerAd!.size.height.toDouble(),
        width: context.read<AdsViewModel>().bannerAd!.size.width.toDouble(),
        child: Container(
          height:context.read<AdsViewModel>().bannerAd!.size.height.toDouble(),
          width:context.read<AdsViewModel>().bannerAd!.size.width.toDouble(),
          child: AdWidget(
            ad: context.read<AdsViewModel>().bannerAd!,
          ),
        ),
      ),
    );
  }
}
