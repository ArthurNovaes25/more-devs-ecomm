import 'package:flutter/material.dart';
import 'package:more_devs_do_zero/features/login/model/user.dart';
import 'package:more_devs_do_zero/shared/exceptions/auth_exception.dart';

class LoginController extends ChangeNotifier {
  final RegExp _emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  final int _caracterMinimoSenha = 6;
  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  final GlobalKey<FormState> key = GlobalKey<FormState>();

  bool isActiveCheckBox = false;

  User? user;

  bool isLoading = false;

  bool get isEmailValid => _emailRegex.hasMatch(emailController.text.trim());
  bool get isSenhaValid =>
      senhaController.text.trim().length >= _caracterMinimoSenha;

  void changeActiveCheckBox() {
    isActiveCheckBox = !isActiveCheckBox;
    notifyListeners();
  }

  void changeIsLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Future<void> handleLogin() async {
    if (!key.currentState!.validate()) {
      throw ErrorDescription('validacao_incorreta');
    }

    changeIsLoading(true);
    try {
      await login();
      emailController.clear();
      senhaController.clear();
    } finally {
      changeIsLoading(false);
    }
  }

  Future<void> login() async {
    //Simula chamada da API
    await Future.delayed(const Duration(seconds: 2));
    if (emailController.text.trim() != 'vitor6890@gmail.com' ||
        senhaController.text.trim() != '123456') {
      throw AuthException('E-mail ou senha incorretos');
    }
    user = User(nome: 'Vitor', email: emailController.text);
  }

  String? validateEmail(String? value) {
    if (_emailRegex.hasMatch(emailController.text)) {
      return null;
    }
    return 'E-mail inválido';
  }

  String? validateSenha(String? value) {
    if (senhaController.text.length >= _caracterMinimoSenha) {
      return null;
    }
    return 'Senha inválida';
  }
}
