import 'package:flutter/foundation.dart';
import 'package:more_devs_do_zero/features/home/models/product_model.dart';
import 'package:more_devs_do_zero/shared/mocks.dart';

enum ProductsByCategoryViewState { loading, success, error }

class ProductsByCategoryController extends ChangeNotifier {
  List<Product> _categoryProducts = [];
  List<String> brands = [];

  String _selectedBrand = '';

  String _query = '';

  ProductsByCategoryViewState state = ProductsByCategoryViewState.loading;

  List<Product> get products {
    if (_query.isEmpty) return _categoryProducts;

    final query = _query.toLowerCase();

    return _categoryProducts.where((product) {
      if (_selectedBrand.isNotEmpty && query.isNotEmpty) {
        return product.name.toLowerCase().contains(query) &&
            product.brand == _selectedBrand;
      } else if (_selectedBrand.isNotEmpty) {
        // filtra apenas por marca
        return product.brand == _selectedBrand;
      } else {
        return product.name.toLowerCase().contains(query);
        //filtra pelo que foi digitado
      }
    }).toList();
  }

  void changeState(ProductsByCategoryViewState newState) {
    state = newState;
    notifyListeners();
  }

  void searchQuery(String query) {
    _query = query;

    notifyListeners();
  }

  void searchBrand(String selectedBrand) {
    _selectedBrand = selectedBrand;
    notifyListeners();
  }

  Future<void> getProductsByCategory(String category) async {
    changeState(ProductsByCategoryViewState.loading);
    //simula o delay da API
    await Future.delayed(Duration(seconds: 3));
    try {
      _categoryProducts = productsJson
          .map((item) => Product.fromJson(item))
          .where((product) => product.category == category)
          .toList();
      //TODO popular brands com todas as marcas, sem repetir.

      brands = _categoryProducts
          .map((product) => product.brand)
          .toSet()
          .toList();

      changeState(ProductsByCategoryViewState.success);
    } catch (e) {
      //caso der erro na deserialização, emite o erro para a tela tratar
      changeState(ProductsByCategoryViewState.error);
    }
  }
}
