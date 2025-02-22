import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:template_flutter/helpers/db_helper.dart';
import 'package:template_flutter/models/login.dart';
import 'package:template_flutter/routes/AppRoutes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  //controller of form
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  //password change visible/hide
  bool _showPassword = false;
  void _togglevisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  //realiza o processo de login do usuario caso a senha esteja correta
  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final user = User(
        email: _loginController.text,
        password: _passwordController.text,
      );

      // Declare a variável e armazene o retorno do selectUser
      List<Map<String, Object?>> userList =
          await DatabaseHelper.instance.selectUser(user);

      if (userList.isNotEmpty) {
        final storedUser = userList[0];

        // Compara a senha fornecida com a senha armazenada no banco de dados
        if (storedUser['password'] == user.password) {
          // Senha correta: login bem-sucedido
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Login bem-sucedido!')),
          );
          // Redireciona para a próxima tela após o login
          Navigator.pushReplacementNamed(context, Routes.dashboard);
        }
      } else {
        // Usuário não encontrado
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Usuário não encontrado!')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Image.asset(
                'assets/loreipsum.png',
                // width: MediaQuery.of(context).size.width * 0.8,
                // height: MediaQuery.of(context).size.height * 0.3,
                fit: BoxFit.fill,
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      controller: _loginController,
                      decoration: const InputDecoration(
                        labelText: 'E-mail *',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'A email não pode ser em branco';
                        } else if (!EmailValidator.validate(value)) {
                          return 'Email Invalido';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: !_showPassword,
                      cursorColor: Colors.deepPurple,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        labelText: "Password",
                        suffixIcon: GestureDetector(
                          onTap: () {
                            _togglevisibility();
                          },
                          child: Icon(
                            _showPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.deepPurple,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'A senha nao pode ser vazia';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 14, top: 14, bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple,
                              foregroundColor: Colors.white70),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              await _submitForm();

                              _loginController.clear();
                              _passwordController.clear();
                              // Navigator.pushNamed(context, Routes.login);
                            }
                          },
                          child: const Text('Login'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
