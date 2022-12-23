import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pochta_index/data/models/pochta_model.dart';
import 'package:pochta_index/data/servis/database_service.dart';
import 'package:pochta_index/ui/description/post_page.dart';
import 'package:pochta_index/view_model/saveds_view_model.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../../../utils/media_query.dart';
import '../../../../utils/my_colors.dart';
import '../../../../view_model/pochta_view_model.dart';
import 'package:provider/provider.dart';
class PostsSmallCard extends StatefulWidget {
  PochtaModel category;
  num distance;
   PostsSmallCard({required this.category,required this.distance,Key? key}) : super(key: key);

  @override
  State<PostsSmallCard> createState() => _PostsSmallCardState();
}

class _PostsSmallCardState extends State<PostsSmallCard> {
  @override
  Widget build(BuildContext context) {
    bool isSaved = context.read<SavedsViewModel>().indexes!.contains(int.parse(widget.category.oldIndex!));
    return ZoomTapAnimation(
      onTap: () async {
        Navigator.push(context, MaterialPageRoute(builder: (_)=>FullInfoPage(postage: widget.category)));
      },
      child: Container(
        margin: const EdgeInsets.only(top: 12).r,
        height: m_h(context)*0.07,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: MyColors.C_1C2632,
        ),
        child: Padding(
          padding: const EdgeInsets.only(right: 10,).r,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(onPressed: () async {
                widget.category.isSaved = !(await context.read<SavedsViewModel>().deleteOrInsertToDb(widget.category.oldIndex!));
                isSaved=!isSaved;
                setState(() {});
                print("Saved: ${widget.category.isSaved}");
              // ignore: iterable_contains_unrelated_type
              }, icon: isSaved?Icon(Icons.star,color: Colors.white,):Icon(Icons.star_border_outlined,color: Colors.grey,)),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.category.oldIndex.toString(), style: TextStyle(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.w800),),
                    Text("${(widget.distance).toStringAsFixed(2)} km", style: TextStyle(color: Colors.white, fontSize: 14.sp), )
                  ],
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
