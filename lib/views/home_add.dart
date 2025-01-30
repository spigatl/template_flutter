import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:template_flutter/helpers/db_helper.dart';
import 'package:template_flutter/models/login.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
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

      await DatabaseHelper.instance.addUser(user);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Usuario Cadastrado com sucesso')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastrar')),
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
