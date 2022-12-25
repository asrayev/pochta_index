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
                '''   Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like)
                ''', style: GoogleFonts.raleway(color: Colors.white),
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
