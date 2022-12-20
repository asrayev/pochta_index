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
import 'package:provider/provider.dart';
import 'dart:math' as math;

class MailsPage extends StatefulWidget {
  const MailsPage({Key? key}) : super(key: key);

  @override
  State<MailsPage> createState() => _MailsPageState();
}

class _MailsPageState extends State<MailsPage> {
  @override
  void initState() {
    super.initState();
    locationService();
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
      body: StreamBuilder(
        stream: Provider.of<PochtaViewModel>(context, listen: false)
            .listenProducts1(),
        builder: (context, snapshot) {
          if(snapshot.hasError){
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
            List<PochtaModel> mails = snapshot.data!;
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
                      Text("Others", style: GoogleFonts.signika(color: Colors.white),),
                    ],
                  ),
                  Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      children: List.generate(mails.length-1, (index) {
                        PochtaModel category = mails[index];
                        return PostsSmallCard(category: category,distance: distance(category.lat, category.lon),);
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

  num distance(lat2, lon2) {
    double lat1 = UserLocation.lat;
    double lon1 = UserLocation.long;
    int r = 6371;
    lon1 = (lon1 * math.pi) / 180;
    lon2 = (lon2 * math.pi) / 180;
    lat1 = (lat1 * math.pi) / 180;
    lat2 = (lat2 * math.pi) / 180;

    num dlon = lon2 - lon1;
    num dlat = lat2 - lat1;

    num a = math.pow(math.sin(dlat / 2), 2) +
        math.cos(lat1) * math.cos(lat2) * math.pow(math.sin(dlon / 2), 2);
    num c = 2 * math.asin(math.sqrt(a));
    return c * r;
  }
}
