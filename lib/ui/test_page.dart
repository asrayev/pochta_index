import 'package:location/location.dart';
import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:pochta_index/data/models/pochta_model.dart';
import 'package:pochta_index/data/models/user_location_model.dart';
import 'package:pochta_index/utils/media_query.dart';
import 'package:pochta_index/view_model/pochta_view_model.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;
class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
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
    print("ASDASDASDFASDASDASD${distancetest(41.2800346, 69.2127423)}");
    print("latlatlatlatlatlat ${UserLocation.lat}");
    print("lonlonlonlonlonlon ${UserLocation.long}");
    return Scaffold(
       body: Container(
         width: m_w(context),
         height: m_h(context),
         child: StreamBuilder(
           stream:  Provider.of<PochtaViewModel>(context, listen: false).listenProducts1(),
           builder: (context, snapshot){
            if(UserLocation.lat == 0.0){
              return Column(
                children: [
                  SizedBox(height: 200,),
                  InkWell(
                    onTap: (()async{
                      await locationService();
                      setState(() {



                      });

                    }),
                    child: Container(

                        child: Center(child: Text("Iltimos locationni allow qiling"))
                    ),
                  ),
                ],
              );
            }

             else if(snapshot.hasData){
             List<PochtaModel> mails = snapshot.data!;
             mails.sort((a, b) => distance(a.lat, a.lon).compareTo( distance(b.lat, b.lon)));
             return ListView(
               children: List.generate(mails.length, (index) {
                 PochtaModel category = mails[index];
                 return ListTile(
                   title: Text(category.phoneNumber.toString()),
                   trailing: SizedBox(
                     width: 100,
                     child: Row(
                       children: [

                         Text((distance(category.lat, category.lon)).toString().substring(0,10)),
                       ],
                     ),
                   ),
                 );
               }),
             );

             }
             else{
               return CircularProgressIndicator();
             }
           },
         ),
       ),
    );
  }
  num distance(lat2, lon2){
    double lat1 = UserLocation.lat;
    double lon1 = UserLocation.long;
    int r = 6371;
    lon1 = (lon1*math.pi)/180;
    lon2 =(lon2*math.pi)/180;
    lat1 = (lat1*math.pi)/180;
    lat2 = (lat2*math.pi)/180;

    num dlon = lon2 - lon1;
    num dlat = lat2 - lat1;

    num a = math.pow(math.sin(dlat/2), 2) + math.cos(lat1) * math.cos(lat2)* math.pow(math.sin(dlon/2),2);
    num c = 2 * math.asin(math.sqrt(a));
    return c * r;
  }
  num distancetest(lat2, lon2){
    double lat1 =  41.285746;
    double lon1 = 69.203476;
    int r = 6371;
    lon1 = (lon1*math.pi)/180;
    lon2 =(lon2*math.pi)/180;
    lat1 = (lat1*math.pi)/180;
    lat2 = (lat2*math.pi)/180;

    num dlon = lon2 - lon1;
    num dlat = lat2 - lat1;
    // lat1 = 41.285746
    // lat2 = 41.2800346
    // lon1 = 69.203476
    // lon2 = 69.2127423
    num a = math.pow(math.sin(dlat/2), 2) + math.cos(lat1) * math.cos(lat2)* math.pow(math.sin(dlon/2),2);
    num c = 2 * math.asin(math.sqrt(a));
    return c * r;
  }
}
