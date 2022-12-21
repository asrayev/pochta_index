import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pochta_index/data/models/pochta_model.dart';
import 'package:pochta_index/data/servis/database_service.dart';
import 'package:pochta_index/ui/description/post_page.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../../../utils/media_query.dart';
import '../../../../utils/my_colors.dart';
import '../../../../view_model/pochta_view_model.dart';
import 'package:provider/provider.dart';
class PostsSmallCard extends StatelessWidget {
  PochtaModel category;
  num distance;
   PostsSmallCard({required this.category,required this.distance,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      onTap: () async {
        Navigator.push(context, MaterialPageRoute(builder: (_)=>FullInfoPage(postage: category)));
      },
      child: Container(
        margin: const EdgeInsets.only(top: 12).r,
        height: m_h(context)*0.07,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: MyColors.C_1C2632,
        ),
        child: Padding(
          padding: const EdgeInsets.only(right: 10, left: 10).r,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(category.oldIndex.toString(), style: TextStyle(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.w800),),
              Text("${(distance).toStringAsFixed(2)} km", style: TextStyle(color: Colors.white, fontSize: 14.sp), )
            ],
          ),
        ),
      ),
    );
  }
}
