import 'package:flutter/material.dart';
import 'package:more_devs_do_zero/features/home/models/product_model.dart';
import 'package:more_devs_do_zero/shared/app_text_style.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Skeleton.replace(
              width: 150,
              height: 150,
              child: Image.network(
                product.imageUrl,
                height: 150,
                width: 150,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(product.brand, style: AppTextStyle.smallGrey),
          Text(product.name, style: AppTextStyle.smallBlack),
          Text(
            '\$${product.price.toStringAsFixed(2).replaceAll('.', ',')}',
            style: AppTextStyle.smallGreen,
          ),
        ],
      ),
    );
  }
}
