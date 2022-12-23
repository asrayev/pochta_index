import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:pochta_index/data/models/pochta_model.dart';
import 'package:pochta_index/utils/map_util.dart';
import 'package:pochta_index/utils/media_query.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../data/servis/post_page_service.dart';
import '../../utils/my_colors.dart';

// ignore: must_be_immutable
class FullInfoPage extends StatefulWidget {
  PochtaModel postage;
  FullInfoPage({required this.postage, Key? key}) : super(key: key);

  @override
  State<FullInfoPage> createState() => _FullInfoPageState();
}

class _FullInfoPageState extends State<FullInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.C_0F1620,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(m_w(context) * 0.04),
          child: Column(
            children: [
              Container(
                height: m_h(context) * 0.25,
                width: m_w(context),
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            "https://sun9-76.userapi.com/impg/l-fXjFHicRl6QmJoaL8dmXVRdq3JvF9bQym-JQ/RXjAf4HdN8c.jpg?size=604x404&quality=96&sign=e3b414e1ea6b1b89a06b1ceb52adb41b&type=album"),
                        fit: BoxFit.cover)),
              ), //advertisement
              Expanded(
                  child: Container(
                    padding:  EdgeInsets.all(m_h(context)*0.012),
                    margin:  EdgeInsets.only(top: m_h(context)*0.013),
                    decoration:  BoxDecoration(
                      color: MyColors.C_1C2632,
                      borderRadius: BorderRadius.circular(m_h(context)*0.013)
                    ),
                    width: m_w(context),
                    child: Column(
                children:  [
                  Text("Information".tr(),style: const TextStyle(color: Colors.white),),
                  SizedBox(height: m_h(context)*0.032,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Index".tr(),style: const TextStyle(color: Colors.white),),
                      SizedBox(
                          width: m_w(context)*0.46,
                          child: Text(widget.postage.oldIndex.toString(),style: const TextStyle(color: Colors.white)))
                    ],
                  ),
                   SizedBox(height: m_h(context)*0.022,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Address".tr(),style: const TextStyle(color: Colors.white),),
                      SizedBox(
                        width: 180,
                          child: Text(widget.postage.address.toString(),style: const TextStyle(color: Colors.white)))
                    ],
                  ),
                  SizedBox(height: m_h(context)*0.022,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Status".tr(),style: const TextStyle(color: Colors.white),),
                      SizedBox(
                          width: m_w(context)*0.46,
                          child: Row(
                            children: [
                              Text(holati(int.parse(widget.postage.workDay.toString()),int.parse(widget.postage.workHour.toString()) ).toString(),style: TextStyle(color: Colors.white)),
                              const SizedBox(width: 5,),
                              SizedBox(
                                height: m_h(context)*0.025,
                                width: m_h(context)*0.025,
                                child: isOnline(int.parse(widget.postage.workDay.toString()),int.parse(widget.postage.workHour.toString()) ),
                              )
                            ],
                          ))
                    ],
                  ),
                  SizedBox(height: m_h(context)*0.024,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Work days".tr(),style: const TextStyle(color: Colors.white),),
                      SizedBox(
                          width: m_w(context)*0.46,
                          child: Text(parseDay(int.parse(widget.postage.workDay.toString())),style: TextStyle(color: Colors.white)))
                    ],
                  ),
                  SizedBox(height: m_h(context)*0.024,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Work hours".tr(),style: const TextStyle(color: Colors.white),),
                      SizedBox(
                          width: m_w(context)*0.46,
                          child: Text(parsedate(int.parse(widget.postage.workHour.toString())),style: TextStyle(color: Colors.white)))
                    ],
                  ),
                  SizedBox(height: m_h(context)*0.024,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Phone number".tr(),style: const TextStyle(color: Colors.white),),
                      SizedBox(
                          width: m_w(context)*0.46,
                          child: Text(widget.postage.phoneNumber.toString(),style: const TextStyle(color: Colors.white)))


                    ],
                  ),
                  SizedBox(height: m_h(context)*0.024,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ZoomTapAnimation(
                        child: Container(
                          height: 48,
                          width: 110,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(m_h(context)*0.0123)
                          ),
                          child: const Center(
                            child: Icon(Icons.location_city),
                          ),
                        ),
                        onTap: (){
                          MapUtils.navigateTo(widget.postage.lat!, widget.postage.lon!);
                        },
                      ),
                      ZoomTapAnimation(
                        onTap: () async {
                          String number = widget.postage.phoneNumber.toString(); //set the number here
                          bool? res = await FlutterPhoneDirectCaller.callNumber(number);
                        },
                        child: Container(
                          height: 48,
                          width: 110,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(12)
                          ),
                          child: const Center(
                            child: Icon(Icons.call),
                          ),
                        ),
                      ),

                    ],
                  ),
                ],
              ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}