import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pochta_index/utils/my_icons.dart';

import '../../../../utils/map_util.dart';
import '../../../../utils/media_query.dart';
import '../../../../utils/my_colors.dart';

class ContributorPage extends StatelessWidget {
  const ContributorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.C_0F1620,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15).w,
          child: Column(
            children: [
              Text("Contributors", style: GoogleFonts.lalezar(color: Colors.white, fontSize: 27.sp, fontWeight: FontWeight.w400),),
              InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                  onTap: ((){
                    MapUtils.openDeveloper("https://t.me/asrayev");
                  }),
                child: Container(
                  margin: const EdgeInsets.only(top: 12).r,
                  height: m_h(context)*0.12,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: MyColors.C_1C2632,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10, left: 10).r,
                    child: Row(
                      children: [
                        Container(
                          height: m_h(context)*0.1,
                          width: m_w(context)*0.17,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage(MyIcons.abdurauf)
                            )
                          ),

                        ),
                         SizedBox(width: m_w(context)*0.03,),
                        Column(
                          children: [
                            SizedBox(height: m_h(context)*0.025,),
                            Text("Abdurauf       ", style: TextStyle(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.w800),),
                            Text("Software engineer", style: GoogleFonts.raleway(color: Colors.grey, fontSize: 14.sp),),
                            Text("Flutter Developer  ", style: GoogleFonts.raleway(color: Colors.grey,fontSize: 14.sp),)
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: ((){
                  MapUtils.openDeveloper("https://t.me/ahadjonovss");
                }),
                child: Container(
                  margin: const EdgeInsets.only(top: 12).r,
                  height: m_h(context)*0.12,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: MyColors.C_1C2632,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10, left: 10).r,
                    child: Row(
                      children: [
                        Container(
                          height: m_h(context)*0.1,
                          width: m_w(context)*0.17,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: AssetImage(MyIcons.samandar)
                              )
                          ),

                        ),
                        SizedBox(width: m_w(context)*0.03,),
                        Column(
                          children: [
                            SizedBox(height: m_h(context)*0.033,),
                            Text("Samandar Ahadjonov", style: TextStyle(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.w800),),
                            Text("Flutter Developer                     ", style: GoogleFonts.raleway(color: Colors.grey,fontSize: 14.sp),)
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: ((){
                  MapUtils.openDeveloper("https://t.me/WEST_1449");
                }),
                child: Container(
                  margin: const EdgeInsets.only(top: 12).r,
                  height: m_h(context)*0.12,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: MyColors.C_1C2632,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10, left: 10).r,
                    child: Row(
                      children: [
                        Container(
                          height: m_h(context)*0.1,
                          width: m_w(context)*0.17,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: AssetImage(MyIcons.asadbek)
                              )
                          ),

                        ),
                        SizedBox(width: m_w(context)*0.03,),
                        Column(
                          children: [
                            SizedBox(height: m_h(context)*0.033,),
                            Text("Asadbek Rustamov", style: TextStyle(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.w800),),
                            Text("Graphic Designer                 ", style: GoogleFonts.raleway(color: Colors.grey, fontSize: 14.sp),),

                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }
}
