import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:location/location.dart';
import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:pochta_index/data/models/pochta_model.dart';
import 'package:pochta_index/data/models/user_location_model.dart';
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
                      bottom: 10),
                  child: SvgPicture.asset(
                    MyIcons.settings,
                    height: 27,
                    width: 27,
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
                  if (UserLocation.lat == 0.0) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 300,
                        ),
                        InkWell(
                          onTap: (() async {
                            await locationService();
                            setState(() {});
                          }),
                          child: Container(
                              child: Center(
                                  child:
                                      Text("Iltimos locationni allow qiling"))),
                        ),
                      ],
                    );
                  } else if (snapshot.hasData) {
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
                                borderRadius: BorderRadius.circular(25)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:
                                  [
                                    Text("Eng yaqin pochta ", style: TextStyle(color: MyColors.C_8A96A4),),
                                    Text("${(distance(mails[0].lat, mails[0].lon)).toStringAsFixed(2)} km", style: TextStyle(color: Colors.white), )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(mails[0].oldIndex.toString(), style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),),
                                            SizedBox(width: m_w(context)*0.005,),
                                            InkWell(
                                                onTap: ((){
                                                  // for copy
                                                }),
                                                child: SvgPicture.asset(MyIcons.copy, color: MyColors.C_46AEF5,))
                                          ],
                                        ),
                                        Text("Indeksi", style: TextStyle(color: MyColors.C_8A96A4),)
                                      ],
                                    ),
                                  ],
                                ), // index

                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                                height: m_h(context) * 0.08,
                                                child: Text(mails[0].address.toString(), style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),)),


                                          ],
                                        ),
                                        Text("Address", style: TextStyle(color: MyColors.C_8A96A4),)
                                      ],
                                    ),
                                  ],
                                ),//address




                                Row(
                                  children: [
                                    Text(mails[0].newIndex.toString())
                                  ],
                                )
                              ],
                            ),
                          ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: m_h(context) * 0.62,
                          child: ListView(
                            physics: BouncingScrollPhysics(),
                            children: List.generate(mails.length-1, (index) {
                              PochtaModel category = mails[index+1];

                              return Padding(

                                padding: EdgeInsets.only(top: 10, right: 10, left: 10),
                                child: Container(
                                  height: m_h(context)*0.07,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                  color: MyColors.C_1C2632,
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
