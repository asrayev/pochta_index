import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pochta_index/ui/main/pages/settings/settings_page.dart';
import 'package:pochta_index/ui/main/pages/widget/postage_card.dart';
import 'package:pochta_index/utils/my_icons.dart';
import 'package:pochta_index/view_model/pochta_view_model.dart';
import 'package:pochta_index/view_model/saveds_view_model.dart';

import '../../../utils/media_query.dart';
import '../../../utils/my_colors.dart';
import 'package:provider/provider.dart';


class SavedPage extends StatefulWidget {
  const SavedPage({Key? key}) : super(key: key);

  @override
  State<SavedPage> createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
  @override
  void initState() {
    context.read<SavedsViewModel>().listenSaveds(context.read<PochtaViewModel>().products);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.C_0F1620,
      appBar: AppBar(
        backgroundColor: MyColors.C_0F1620,
        elevation: 0,
        actions: [
          InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: ((){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingPage()));
            }),
            child: SvgPicture.asset(
              MyIcons.settings,
              height: 27.h,
              width: 27.w,
            ),
          ),
          SizedBox(width: m_w(context)*0.04,)
        ],
      ),
      body: Consumer<SavedsViewModel>(
        builder: (context, value, child) {
          if(value.saveds!=null){
            return Container(
              padding: const  EdgeInsets.symmetric(horizontal: 12).r,
              height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: value.saveds!.length,
                  itemBuilder: (context, index) => Dismissible(

                      key: UniqueKey(),
                      onDismissed: (direction) {
                        context.read<SavedsViewModel>().deleteByIndex(value.saveds![index]);
                      },
                      child: PostageCardWidget(postage: value.saveds![index])),
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(height: 20.h,);
                  },) );
          }
          if(value.saveds==null || value.saveds!.isEmpty){
            context.read<SavedsViewModel>().listenSaveds(context.read<PochtaViewModel>().products);
          }
          return Container();
        },
      ),
    );
  }
}
