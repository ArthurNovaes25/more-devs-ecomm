import 'package:flutter/material.dart';
import 'package:more_devs_do_zero/features/home/pages/home_page.dart';
import 'package:more_devs_do_zero/features/home/pages/products_by_category_page.dart';
import 'package:more_devs_do_zero/features/login/pages/login_page.dart';
import 'package:more_devs_do_zero/features/recover/pages/recover_page.dart';
import 'package:more_devs_do_zero/features/signup/pages/signup_page.dart';

class AppRoutes {
  static final Map<String, WidgetBuilder> routes = {
    LoginPage.route: (context) => const LoginPage(),
    SignupPage.route: (context) => const SignupPage(),
    RecoverPage.route: (context) => const RecoverPage(),
    HomePage.route: (context) => const HomePage(),
    ProductsByCategoryPage.route: (context) {
      final String CategoryName =
          ModalRoute.of(context)!.settings.arguments as String;
      return ProductsByCategoryPage(categoryName: CategoryName);
    },
  };
}
