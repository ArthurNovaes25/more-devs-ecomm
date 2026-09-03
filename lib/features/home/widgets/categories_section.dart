import 'package:flutter/material.dart';
import 'package:more_devs_do_zero/features/home/controllers/home_controller.dart';
import 'package:more_devs_do_zero/features/home/models/category_model.dart';
import 'package:more_devs_do_zero/features/home/widgets/category_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({
    super.key,
    required this.state,
    required this.categories,
  });

  final CategoriesViewState state;
  final List<Category> categories;

  static final List<Category> _fakeCategories = List.filled(
    4,
    Category(name: 'Categoria', imageUrl: ''),
  );

  @override
  Widget build(BuildContext context) {
    if (state == CategoriesViewState.error) {
      return const Text('Problema ao resgatar categorias');
    }

    final isLoading = state == CategoriesViewState.loading;
    final items = isLoading ? _fakeCategories : categories;

    return Skeletonizer(
      enabled: isLoading,
      child: SizedBox(
        height: 150,
        child: ListView.builder(
          itemCount: items.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return CategoryCard(category: items[index]);
          },
        ),
      ),
    );
  }
}
