import 'package:flutter/material.dart';
import 'package:more_devs_do_zero/features/home/models/category_model.dart';
import 'package:more_devs_do_zero/shared/app_text_style.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key, required this.category});

  final Category category;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          SizedBox(
            height: 76,
            child: Skeleton.replace(
              replacement: Bone.circle(size: 50),
              width: 76,
              height: 76,
              child: Image.network(category.imageUrl),
            ),
          ),
          Text(category.name, style: AppTextStyle.smallBlack),
        ],
      ),
    );
  }
}
