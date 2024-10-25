import 'package:flutter/material.dart';
import 'package:meucontrole/views/home_login.dart';
import '../views/home_page.dart';
import '../views/home_password.dart';
import '../views/home_cadastro.dart';

class Routes {
  static const String home = '/';
  static const String password = '/password';
  static const String login = '/login';
  static const String cadastrar = '/cadastrar';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case password:
        return MaterialPageRoute(builder: (_) => const HomePassword());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case cadastrar:
        return MaterialPageRoute(builder: (_) => const HomeCadastro());
      default:
        return MaterialPageRoute(
            builder: (_) => const HomePage()); // Redireciona para Home por padrão
    }
  }
}
