import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'package:pochta_index/data/models/pochta_model.dart';
import 'package:pochta_index/data/models/user_location_model.dart';
import 'package:pochta_index/ui/main/pages/settings/settings_page.dart';
import 'package:pochta_index/ui/main/pages/widget/mail_hasError.dart';
import 'package:pochta_index/ui/main/pages/widget/mail_location.dart';
import 'package:pochta_index/ui/main/pages/widget/mails_shimmer.dart';
import 'package:pochta_index/ui/main/pages/widget/postage_card.dart';
import 'package:pochta_index/ui/main/pages/widget/postage_small_card.dart';
import 'package:pochta_index/utils/media_query.dart';
import 'package:pochta_index/utils/my_colors.dart';
import 'package:pochta_index/utils/my_icons.dart';
import 'package:pochta_index/view_model/pochta_view_model.dart';
import 'package:pochta_index/view_model/saveds_view_model.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

import '../../../data/servis/distance_service.dart';

class MailsPage extends StatefulWidget {
  const MailsPage({Key? key}) : super(key: key);

  @override
  State<MailsPage> createState() => _MailsPageState();
}

class _MailsPageState extends State<MailsPage> {
  @override
  void initState() {
    super.initState();
    context.read<SavedsViewModel>().listenSaveds(context.read<PochtaViewModel>().products);
    locationService();
    getconnet();
  }
  Future<bool> getconnet()async{
   var  connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.ethernet || connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else  {
      return false;
    }
  }


  Future<void> locationService() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionLocation;
    LocationData _locData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionLocation = await location.hasPermission();
    if (_permissionLocation == PermissionStatus.denied) {
      _permissionLocation = await location.requestPermission();
      if (_permissionLocation != PermissionStatus.granted) {
        return;
      }
    }

    _locData = await location.getLocation();

    setState(() {
      UserLocation.lat = _locData.latitude!;
      UserLocation.long = _locData.longitude!;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.C_0F1620,
      appBar: AppBar(
        title: Text(" Pochta Indeksi", style: GoogleFonts.lalezar(color: Colors.white, fontSize: 24.sp, fontWeight: FontWeight.w300),),
        backgroundColor: MyColors.C_0F1620,
        elevation: 0,
        actions: [
          InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: ((){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> const SettingPage()));
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
      body: StreamBuilder(
        stream: Provider.of<PochtaViewModel>(context, listen: false)
            .listenProducts1(),
        builder: (context, snapshot) {

          if(snapshot.hasError ){
            return const MailHasError();
          }
          if (UserLocation.lat == 0.0) {
            return InkWell(
            onTap: (() async {
               await locationService();
              setState(() {});
               }),
                child: const MailLocationTurn());
          }
          if(snapshot.connectionState == ConnectionState.waiting){
            return const MailsShimmer();
          }
          if (snapshot.hasData) {
            List indexes = context.read<SavedsViewModel>().indexes!;
            print(indexes);
            List<PochtaModel> mails = context.read<PochtaViewModel>().changeisSavedField(indexes);
            mails.sort((a, b) => distance(a.lat, a.lon)
                .compareTo(distance(b.lat, b.lon)));
            context.read<PochtaViewModel>().changePostage(mails[0],distance(mails[0].lat, mails[0].lon));
            return Padding(
              padding: EdgeInsets.only(
                  right: m_w(context) * 0.03,
                  left: m_w(context) * 0.03),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                 PostageCardWidget(postage: context.watch<PochtaViewModel>().currentPostage!),
                  SizedBox(height: m_h(context)*0.02,),
                  Row(
                    children: [
                      SizedBox(width: 4.w,),
                      Text("Others".tr(), style: GoogleFonts.signika(color: Colors.white),),
                    ],
                  ),
                  Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      children: List.generate(mails.length-1, (index) {
                        PochtaModel category = mails[index+1];
                        return Dismissible(
                            key: UniqueKey(),
                            onDismissed: (direction) async{
                              await context.read<SavedsViewModel>().insertToDb(category.oldIndex!, context.read<SavedsViewModel>().saveds!);
                            },
                            child: PostsSmallCard(category: category,distance: distance(category.lat, category.lon),));
                      }),
                    ),
                  )
                ],
              ),
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }

}
