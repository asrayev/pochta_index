import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:location/location.dart';
import 'package:lottie/lottie.dart';
import 'package:pochta_index/ui/test_page.dart';
import 'package:pochta_index/utils/media_query.dart';
import 'package:pochta_index/utils/my_colors.dart';
import 'package:pochta_index/utils/my_lotties.dart';

import '../../data/models/user_location_model.dart';
import '../main/main_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {




  @override
  void initState() {
    super.initState();
    onNextPage();
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
  onNextPage(){
    Future.delayed(Duration(seconds: 5),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){return MainPage();}));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: m_h(context),
        width: m_w(context),
        color: MyColors.C_0F1620,
        child: Center(
          child: Column(
            children: [
              SizedBox(height: m_h(context)*0.3,),
              Container(
                  width: m_w(context)*0.5,
                  child: Lottie.asset(MyLottie.splash_location)),
              AnimatedTextKit(
                animatedTexts: [
                TypewriterAnimatedText("Pochta Indexi", textStyle: GoogleFonts.raleway(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w500
                ),),
              ])
            ],
          )
        ),
      ),
    );
  }
}
