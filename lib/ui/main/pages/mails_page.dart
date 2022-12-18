import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:location/location.dart';
import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:pochta_index/data/models/pochta_model.dart';
import 'package:pochta_index/data/models/user_location_model.dart';
import 'package:pochta_index/ui/main/pages/settings/settings_page.dart';
import 'package:pochta_index/ui/main/pages/widget/mail_hasError.dart';
import 'package:pochta_index/ui/main/pages/widget/mail_location.dart';
import 'package:pochta_index/ui/main/pages/widget/mails_shimmer.dart';
import 'package:pochta_index/utils/media_query.dart';
import 'package:pochta_index/utils/my_colors.dart';
import 'package:pochta_index/utils/my_icons.dart';
import 'package:pochta_index/view_model/pochta_view_model.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math' as math;

import '../../../utils/map_util.dart';
import '../../../utils/my_utils.dart';

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
    print("latlatlatlatlatlat ${UserLocation.lat}");
    print("lonlonlonlonlonlon ${UserLocation.long}");
    return Scaffold(
      body: Container(
        width: m_w(context),
        height: m_h(context),
        color: MyColors.C_0F1620,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      right: m_w(context) * 0.035,
                      top: m_h(context) * 0.055,
                      bottom: 10).r,
                  child: InkWell(
                    onTap: ((){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingPage()));
                    }),
                    child: SvgPicture.asset(
                      MyIcons.settings,
                      height: 27.h,
                      width: 27.w,
                    ),
                  ),
                )
              ], //Settings
            ),
            Container(
              width: double.infinity,
              height: m_h(context) * 0.85,
              child: StreamBuilder(
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
                    // return Column(
                    //   children: [
                    //     SizedBox(
                    //       height: 300.h,
                    //     ),
                    //     InkWell(
                    //       onTap: (() async {
                    //         await locationService();
                    //         setState(() {});
                    //       }),
                    //       child: Container(
                    //           child: Center(
                    //               child:
                    //                   Text("Iltimos locationni allow qiling"))),
                    //     ),
                    //   ],
                    // );
                  }
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return const MailsShimmer();
                  }

                  if (snapshot.hasData) {
                    List<PochtaModel> mails = snapshot.data!;
                    mails.sort((a, b) => distance(a.lat, a.lon)
                        .compareTo(distance(b.lat, b.lon)));
                    return Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              right: m_w(context) * 0.03,
                              left: m_w(context) * 0.03),
                          child: Container(
                            height: m_h(context) * 0.2,
                            decoration: BoxDecoration(
                                color: MyColors.C_1C2632,
                                borderRadius: BorderRadius.circular(25).r),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0).r,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:
                                  [
                                    Text("Eng yaqin pochta ", style: GoogleFonts.raleway(color: MyColors.C_8A96A4, fontSize: 14.sp),),
                                    Text("${(distance(mails[0].lat, mails[0].lon)).toStringAsFixed(2)} km", style: TextStyle(color: Colors.white, fontSize: 14.sp), )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        Text(mails[0].oldIndex.toString(), style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.sp),),
                                        SizedBox(width: m_w(context)*0.005,),
                                        InkWell(
                                            onTap: (() async{
                                               await Clipboard.setData(ClipboardData(text: mails[0].oldIndex.toString()));
                                               MyUtils.getMyToast(message: "Text copied to clipboard");
                                            }),
                                            child: SvgPicture.asset(MyIcons.copy, height: 24.h,width: 24.w, color: MyColors.C_46AEF5,))
                                      ],
                                    ),

                                  ],
                                ),
                                Row(
                                  children: [
                                    SizedBox(width: 3.w,),
                                    Text("Indeksi", style: TextStyle(color: MyColors.C_8A96A4, fontSize: 14.sp),),
                                  ],
                                ),// index
                                SizedBox(height: m_h(context)*0.018,),
                                Row(

                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                            height: m_h(context) * 0.07,
                                            width: m_w(context)*0.45,

                                            child: Center(child: Text(mails[0].address.toString().length > 121 ? mails[0].address.toString().substring(0,122) : mails[0].address.toString(), style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500,fontSize: 12.sp ),))),


                                      ],
                                    ),
                                    SizedBox(width: m_w(context)*0.15,),
                                    Row(
                                      children: [
                                        Column(
                                          children: [
                                            SizedBox(height: m_h(context)*0.045,),
                                            Container(
                                                height: m_h(context) * 0.025,
                                                width: m_w(context)*0.30,

                                                 child: Text(mails[0].phoneNumber.toString(), style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 12.sp),),),
                                          ],
                                        )



                                      ],
                                    ),

                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text("Address  ", style: TextStyle(color: MyColors.C_8A96A4, fontSize: 14.sp),),
                                        SizedBox(width: m_w(context)*0.005,),
                                        InkWell(
                                            onTap: (()async {
                                              MapUtils.navigateTo(double.parse(mails[0].lat.toString()),double.parse(mails[0].lon.toString()));
                                            }),
                                            child: SvgPicture.asset(MyIcons.location_map, color: MyColors.C_46AEF5, height: 20.h, width: 20.w,)),
                                      ],
                                    ),

                                    Text("Phone number    ", style: TextStyle(color: MyColors.C_8A96A4, fontSize: 14.sp),)

                                  ],
                                )//address



                              ],
                            ),
                          ),
                          ),
                        ),
                        SizedBox(height: m_h(context)*0.02,),
                        Row(
                          children: [
                            SizedBox(width: 20.w,),
                            Text("Qolgan pochtalar", style: GoogleFonts.signika(color: Colors.white),)],
                        ),
                        Container(
                          width: double.infinity,
                          height: m_h(context) * 0.6,
                          child: ListView(
                            physics: BouncingScrollPhysics(),
                            children: List.generate(mails.length-1, (index) {
                              PochtaModel category = mails[index+1];

                              return Padding(
                                padding: EdgeInsets.only(bottom: 10, right: 10, left: 10).r,
                                child: Container(
                                  height: m_h(context)*0.07,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                  color: MyColors.C_1C2632,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 10, left: 10).r,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [

                                        Text(category.oldIndex.toString(), style: TextStyle(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.w800),),
                                        Text("${(distance(category.lat, category.lon)).toStringAsFixed(2)} km", style: TextStyle(color: Colors.white, fontSize: 14.sp), )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        )
                      ],
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
            ),
          ],
        ),
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

// child: ListView(
// children: List.generate(mails.length, (index) {
// PochtaModel category = mails[index];
// return ListTile(
// title: Text(category.phoneNumber.toString()),
// trailing: SizedBox(
// width: 100,
// child: Row(
// children: [
//
// Text((distance(category.lat, category.lon)).toString().substring(0,10)),
// ],
// ),
// ),
// );
// }),
// ),
