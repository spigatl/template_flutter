import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:meucontrole/helpers/db_helper.dart';
import 'package:meucontrole/models/login.dart';


class HomeCadastro extends StatefulWidget {
  const HomeCadastro({super.key});

  @override
  _HomeCadastroStaste createState() => _HomeCadastroStaste();
}

class _HomeCadastroStaste extends State<HomeCadastro> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _loginController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _rePasswordController = TextEditingController();

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final user = User(
        email: _loginController.text,
        password: _passwordController.text,
      );

      await DatabaseHelper.instance.addUser(user);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Usuário salvo com sucesso!')));
    }
  }

  bool _showPassword = false;
  void _togglevisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de Usuario')),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                'assets/loreipsum.png',
                fit: BoxFit.fill,
                height: 200,
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
                          //validator de email importa uma lib/email_validator
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
                          labelText: "Senha",
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
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        controller: _rePasswordController,
                        obscureText: !_showPassword,
                        cursorColor: Colors.deepPurple,
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          labelText: "Repetir Senha",
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

                                // If the form is valid, display a snackbar. In the real world,
                                // you'd often call a server or save the information in a database.
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Aguarde')),
                                );
                                print(_loginController.text);
                                // Navigator.pushNamed(context, Routes.login);
                              }
                            },
                            child: const Text('Cadastrar'),
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
      ),
    );
  }
}
