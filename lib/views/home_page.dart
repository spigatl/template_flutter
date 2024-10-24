import 'package:flutter/material.dart';
import 'package:meucontrole/routes/AppRoutes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset('assets/loreipsum.png'),
            ],
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 14, top: 14, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      foregroundColor: Colors.white70),
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.login);
                  },
                  child: const Text('Login'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.password);
                  },
                  child: const Text('Esqueceu a senha?'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
