import 'package:flutter/widgets.dart';
import 'package:more_devs_do_zero/features/home/models/category_model.dart';
import 'package:more_devs_do_zero/features/home/models/product_model.dart';
import 'package:more_devs_do_zero/shared/mocks.dart';

enum CategoriesViewState { loading, success, error }

enum ProductsViewState { loading, success, error }

class HomeController extends ChangeNotifier {
  List<Category> categories = [];

  CategoriesViewState categoriesState = CategoriesViewState.loading;

  List<Product> products = [];

  ProductsViewState productsState = ProductsViewState.loading;

  void changeCategoriesState(CategoriesViewState state) {
    categoriesState = state;
    notifyListeners();
  }

  void changeProductsState(ProductsViewState state) {
    productsState = state;
    notifyListeners();
  }

  Future<void> getCategories() async {
    changeCategoriesState(CategoriesViewState.loading);
    //simula o delay da API
    await Future.delayed(Duration(seconds: 3));
    try {
      categories = categoriesJson.map((item) {
        return Category.fromJson(item);
      }).toList();

      changeCategoriesState(CategoriesViewState.success);
    } catch (e) {
      //caso der erro na deserialização, emite o erro para a tela tratar
      changeCategoriesState(CategoriesViewState.error);
    }
  }

  Future<void> getProducts() async {
    changeProductsState(ProductsViewState.loading);
    //simula o delay da API
    await Future.delayed(Duration(seconds: 3));
    try {
      products = productsJson.map((item) {
        return Product.fromJson(item);
      }).toList();

      changeProductsState(ProductsViewState.success);
    } catch (e) {
      //caso der erro na deserialização, emite o erro para a tela tratar
      changeProductsState(ProductsViewState.error);
    }
  }
}
