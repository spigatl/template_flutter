// ignore: file_names
import 'package:flutter/material.dart';
import 'package:template_flutter/views/home_login.dart';
import '../views/home_page.dart';
import '../views/home_password.dart';
import '../views/home_add.dart';
import '../views/dashboard.dart';

class Routes {
  static const String home = '/';
  static const String password = '/password';
  static const String login = '/login';
  static const String add = '/add';
  static const String dashboard = '/dashboard';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case password:
        return MaterialPageRoute(builder: (_) => const HomePassword());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case add:
        return MaterialPageRoute(builder: (_) => const AddPage());
      case dashboard:
        return MaterialPageRoute(builder: (_) => const Dashboard());
      default:
        return MaterialPageRoute(
            builder: (_) =>
                const HomePage()); // Redireciona para Home por padrão
    }
  }
}
