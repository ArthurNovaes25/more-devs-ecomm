import 'package:flutter/material.dart';
import 'package:more_devs_do_zero/features/home/controllers/home_controller.dart';
import 'package:more_devs_do_zero/features/home/models/product_model.dart';
import 'package:more_devs_do_zero/features/home/widgets/product_card.dart';
import 'package:more_devs_do_zero/shared/app_text_style.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductsSection extends StatelessWidget {
  const ProductsSection({
    super.key,
    required this.state,
    required this.products,
  });

  final ProductsViewState state;
  final List<Product> products;

  static final List<Product> _fakeProducts = List.filled(
    4,
    Product(
      brand: 'Marca do produto',
      name: 'Nome do produto',
      imageUrl: '',
      price: 0,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Produtos', style: AppTextStyle.title),
              Icon(Icons.chevron_right),
            ],
          ),
        ),
        if (state == ProductsViewState.error)
          const Text('Problema ao resgatar produtos')
        else
          Builder(
            builder: (context) {
              final isLoading = state == ProductsViewState.loading;
              final items = isLoading ? _fakeProducts : products;

              return Skeletonizer(
                enabled: isLoading,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: isLoading
                      ? const NeverScrollableScrollPhysics()
                      : null,
                  child: IntrinsicHeight(
                    child: Row(
                      children: items.map((Product product) {
                        return ProductCard(product: product);
                      }).toList(),
                    ),
                  ),
                ),
              );
            },
          ),
      ],
    );
  }
}
