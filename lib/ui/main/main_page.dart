import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pochta_index/ui/main/pages/mails_page.dart';
import 'package:pochta_index/ui/main/pages/saved_page.dart';
import 'package:pochta_index/utils/my_colors.dart';
import 'package:pochta_index/utils/my_icons.dart';
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
     body: pages[currentPage],
     bottomNavigationBar: BottomNavigationBar(
       currentIndex: currentPage,
       onTap: (v){
         setState(() {currentPage=v;});
       },
       backgroundColor: MyColors.C_0F1620,
       unselectedItemColor: MyColors.C_938F88,
       selectedItemColor: MyColors.C_46AEF5,
       items: [
         BottomNavigationBarItem(icon: SvgPicture.asset(MyIcons.location, height: 30.h, width: 30.w, color:  colorGenerator(0)),label: "Mails".tr()),
         BottomNavigationBarItem(icon: SvgPicture.asset(MyIcons.pin, height: 23.h, width: 23.w,color:  colorGenerator(1)),label: "Saved".tr()),

       ],
     ),
    );
  }
  Color colorGenerator(int number){
    return currentPage==number? MyColors.C_46AEF5 : MyColors.C_938F88;
  }
}


