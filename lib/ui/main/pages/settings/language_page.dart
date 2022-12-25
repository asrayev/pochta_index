
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pochta_index/ui/main/main_page.dart';
import 'package:pochta_index/ui/main/pages/settings/settings_page.dart';
import 'package:pochta_index/utils/my_icons.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../utils/media_query.dart';
import '../../../../utils/my_colors.dart';
import '../../../../view_model/ads_view_model.dart';
import 'package:provider/provider.dart';

class LanguagePage extends StatefulWidget {
  String locale;
   LanguagePage({required this.locale,Key? key}) : super(key: key);

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

giveMeLocale(String locale){
  switch(locale){
    case "ru_RU":
      ru=1;break;
      case "uz_UZ":
      uz=1;break;
      case "en_US":
      en=1;break;
  }
}
  int uz=0;
  int en = 0;
  int ru = 0;
  // context.currentLocale();

class _LanguagePageState extends State<LanguagePage> {
  @override
  void initState() {
    giveMeLocale(widget.locale);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    context.read<AdsViewModel>().getBannerAd();

    return Scaffold(
      backgroundColor: MyColors.C_0F1620,
      body: Column(
        children: [
          SizedBox(height: m_h(context)*0.06,),
          Padding(
            padding: EdgeInsets.only(right: m_w(context)*0.04, left:m_w(context)*0.03 ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: ((){
                      Navigator.pop(context);
                     }),
                    child: SvgPicture.asset(MyIcons.back, color: MyColors.C_1C2632,height: 35.h, width: 35.w,)),
                Text("Language".tr(), style: GoogleFonts.lalezar(color: Colors.white, fontSize: 27.sp, fontWeight: FontWeight.w400),),
                SizedBox(width: 35.w,)
              ],
            ),

          ),
          SizedBox(height: m_h(context)*0.03,),
          Padding(
              padding: EdgeInsets.only(left: m_w(context)*0.03, right: m_w(context)*0.03),
              child: Container(
                  width: double.infinity,
                  height: m_h(context)*0.2,
                  decoration: BoxDecoration(
                      color: MyColors.C_1C2632,
                      borderRadius: BorderRadius.circular(8).r),
                  child: Column(
                      children: [
                        SizedBox(height: m_h(context)*0.02,),
                        InkWell(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onTap: ((){
                              context.setLocale(Locale('uz','UZ'));


                              uz = 1;
                              en = 0;
                              ru = 0;
                              Navigator.push(context, MaterialPageRoute(builder: (_)=>MainPage()));
                            }),
                            child: funSettings(context,"UZ", "Uzbekistan", uz)),
                        myLine(context),
                        InkWell(

                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onTap: ((){
                              context.setLocale(Locale('en','US'));
                              uz = 0;
                              en = 1;
                              ru = 0;
                              Navigator.push(context, MaterialPageRoute(builder: (_)=>MainPage()));

                            }),

                            child: funSettings(context,"EN", "USA", en)),
                        myLine(context),
                        InkWell(

                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onTap: ((){
                              context.setLocale(Locale('ru','RU'));
                              uz = 0;
                              en = 0;
                              ru = 1;
                              Navigator.push(context, MaterialPageRoute(builder: (_)=>MainPage()));

                            }),
                            child: funSettings(context,"RU", "Russia", ru)),
               ]
             ),
           ),
          )
        ],
      ),
      bottomNavigationBar: context.read<AdsViewModel>().bannerAd==null?SizedBox():Container(
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

  Padding funSettings(BuildContext context, String Name, String Country, int index) {
    return Padding(
      padding: EdgeInsets.only(right: m_w(context)*0.04, left:m_w(context)*0.03 ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Row(

            children: [
              Text(Name, style: GoogleFonts.balsamiqSans(color: Colors.white, fontSize: 17.sp, fontWeight: FontWeight.w300),),
              SizedBox(width: m_w(context)*0.02,),
              Text(Country, style: GoogleFonts.oxanium(color: Colors.grey, fontSize: 17.sp, fontWeight: FontWeight.w100),),
            ],
          ),
          SvgPicture.asset(MyIcons.done, color: index == 1 ? MyColors.C_46AEF5 :Colors.transparent,height: 20.h, width: 20.w,)


        ],
      ),
    );
  }

  Column myLine(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: m_h(context)*0.02,),
        Padding(
          padding: const EdgeInsets.only(left: 15).r,
          child: Container(
            height: m_h(context)*0.0001,
            color: Colors.grey,
          ),
        ),
        SizedBox(height: m_h(context)*0.02,),
      ],
    );
  }
}
