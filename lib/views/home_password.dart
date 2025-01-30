import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class HomePassword extends StatefulWidget {
  const HomePassword({super.key});

  @override
  _HomePasswordStaste createState() => _HomePasswordStaste();
}

class _HomePasswordStaste extends State<HomePassword> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController loginController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Esqueceu a senha')),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Image.asset('assets/loreipsum.png'),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Card(
                          child: _SampleCard(
                              cardName:
                                  'Insira seu e-mail para recuperar a senha')),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      controller: loginController,
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
                    padding: const EdgeInsets.only(
                        left: 20, right: 14, top: 14, bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple,
                              foregroundColor: Colors.white70),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // If the form is valid, display a snackbar. In the real world,
                              // you'd often call a server or save the information in a database.
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Aguarde')),
                              );
                              print(loginController.text);
                              // Navigator.pushNamed(context, Routes.login);
                            }
                          },
                          child: const Text('Enviar'),
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

class _SampleCard extends StatelessWidget {
  const _SampleCard({required this.cardName});
  final String cardName;

// @todo rever o tamanho da sizebox colocar ela dinamica para ficar responsivo para refazer
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 100,
      child: Center(child: Text(cardName)),
    );
  }
}
