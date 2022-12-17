import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pochta_index/data/models/user_location_model.dart';
import 'package:pochta_index/ui/main/pages/mails_page.dart';
import 'package:pochta_index/ui/main/pages/saved_page.dart';
import 'package:pochta_index/utils/my_colors.dart';
import 'package:pochta_index/utils/my_icons.dart';

import '../../utils/media_query.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}
int currentPage=0;
List pages=[
 MailsPage(),
  SavedPage()
];

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
        body: Stack(
          children: [
            pages[currentPage],
            Column(
              children: [
                SizedBox(height: m_h(context)*0.92,),
                Center(
                  child: Container(
                    height: m_h(context)*0.08,
                    decoration: BoxDecoration(

                      color: MyColors.C_0F1620,


                    ),
                    child: Padding(
                      padding: EdgeInsets.only(right: m_w(context)*0.23, left: m_w(context)*0.25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                              onTap: ((){
                                setState(() {
                                  currentPage=0;
                                });
                              }),
                              child: Padding(
                                padding: EdgeInsets.only(top: m_h(context)*0.01),
                                child: Column(
                                  children: [
                                    SvgPicture.asset(MyIcons.location, height: 30, width: 30, color:  currentPage==0? Colors.blue : MyColors.C_938F88),
                                    Text("Mails", style: GoogleFonts.mulish(color:  currentPage==0? Colors.blue : MyColors.C_938F88, fontWeight: FontWeight.w600),)
                                  ],
                                ),
                              )),
                          InkWell(
                              onTap: ((){
                                setState(() {
                                  currentPage=1;
                                });
                              }),
                              child: Padding(
                                padding: EdgeInsets.only(top: m_h(context)*0.016),
                                child: Column(
                                  children: [
                                    SvgPicture.asset(MyIcons.pin, height: 23, width: 23,color:  currentPage==1? Colors.blue : MyColors.C_938F88),
                                    SizedBox(height: m_h(context)*0.005,),
                                    Text("Saved", style: GoogleFonts.mulish(color:  currentPage==1? Colors.blue : MyColors.C_938F88, fontWeight: FontWeight.w600),)
                                  ],
                                ),
                              )),



                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        )
    );
  }
}
