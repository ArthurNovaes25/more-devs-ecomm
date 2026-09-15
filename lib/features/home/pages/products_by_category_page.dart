import 'package:flutter/material.dart';
import 'package:more_devs_do_zero/features/home/controllers/products_by_category_controller.dart';
import 'package:more_devs_do_zero/features/home/models/product_model.dart';
import 'package:more_devs_do_zero/features/home/widgets/product_card.dart';
import 'package:more_devs_do_zero/shared/app_text_style.dart';
import 'package:more_devs_do_zero/shared/widgets/app_text_field.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductsByCategoryPage extends StatelessWidget {
  const ProductsByCategoryPage({super.key, required this.categoryName});

  static String route = '/productsbycategorypage';

  final String categoryName;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductsByCategoryController(),
      child: ProductsByCategoryContent(categoryName: categoryName),
    );
  }
}

class ProductsByCategoryContent extends StatefulWidget {
  const ProductsByCategoryContent({super.key, required this.categoryName});

  final String categoryName;

  @override
  State<ProductsByCategoryContent> createState() =>
      _ProductsByCategoryContentState();
}

class _ProductsByCategoryContentState extends State<ProductsByCategoryContent> {
  static final List<Product> _fakeProducts = List.filled(
    6,
    Product(
      brand: 'Marca do produto',
      name: 'Nome do produto',
      imageUrl: '',
      price: 0,
      category: '',
    ),
  );

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductsByCategoryController>().getProductsByCategory(
        widget.categoryName,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.categoryName, style: AppTextStyle.title),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.shopping_cart_outlined),
          ),
        ],
      ),
      body: Consumer<ProductsByCategoryController>(
        builder: (context, controller, child) {
          return Column(
            children: [
              Skeletonizer(
                enabled:
                    controller.state == ProductsByCategoryViewState.loading,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: AppTextField(
                        hintText: 'Buscar produtos',
                        prefixIcon: const Icon(Icons.search),
                        onChanged: context
                            .read<ProductsByCategoryController>()
                            .searchQuery,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: MultiDropdown<String>(
                        items: [
                          ...controller.brands.map(
                            (e) => DropdownItem(label: e, value: e),
                          ),
                        ],
                        singleSelect: true,
                        fieldDecoration: FieldDecoration(
                          hintText: 'Selecionar marca',
                          suffixIcon: const Icon(
                            Icons.keyboard_arrow_down_rounded,
                          ),
                        ),
                        onSelectionChange: (values) {
                          controller.searchBrand(values.first);
                        },
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: Consumer<ProductsByCategoryController>(
                  builder: (context, controller, child) {
                    if (controller.state == ProductsByCategoryViewState.error) {
                      return const Center(
                        child: Text('Problema ao resgatar produtos'),
                      );
                    }

                    final isLoading =
                        controller.state == ProductsByCategoryViewState.loading;

                    final products = isLoading
                        ? _fakeProducts
                        : controller.products;

                    if (!isLoading && products.isEmpty) {
                      return const Center(
                        child: Text('Nenhum produto encontrado'),
                      );
                    }

                    return Skeletonizer(
                      enabled: isLoading,
                      child: GridView.builder(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        itemCount: products.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              childAspectRatio: 0.62,
                            ),
                        itemBuilder: (context, index) {
                          return ProductCard(product: products[index]);
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
