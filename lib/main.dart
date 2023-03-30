import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gerador de Senhas da FTEAM ',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: const PasswordGenerator(),
    );
  }
}

class PasswordGenerator extends StatefulWidget {
  const PasswordGenerator({Key? key}) : super(key: key);

  @override
  _PasswordGeneratorState createState() => _PasswordGeneratorState();
}

class _PasswordGeneratorState extends State<PasswordGenerator> {
  String _password = '';
  int _passwordLength = 12;

  void _generatePassword(bool includeSpecialChars) {
    const allowedChars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    const specialChars = '!@#\$%^&*()_+{}|:<>?,./';
    final random = Random.secure();
    final passwordChars = List.generate(_passwordLength, (index) {
      if (index < _passwordLength - (includeSpecialChars ? 4 : 0)) {
        return allowedChars[random.nextInt(allowedChars.length)];
      } else {
        return specialChars[random.nextInt(specialChars.length)];
      }
    });
    passwordChars.shuffle();
    final password = passwordChars.join();
    setState(() {
      _password = password;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerador de Senhas'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Sua nova senha:',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Center(
                    child: SelectableText(
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      _password,
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              'Comprimento da senha: $_passwordLength',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 10),
            Slider(
              value: _passwordLength.toDouble(),
              min: 6,
              max: 20,
              divisions: 14,
              label: _passwordLength.toString(),
              onChanged: (double value) {
                setState(() {
                  _passwordLength = value.toInt();
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _generatePassword(false),
              child: const Text('Gerar Senha (sem caracteres especiais)'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _generatePassword(true),
              child: const Text('Gerar Senha (com caracteres especiais)'),
            ),
          ],
        ),
      ),
    );
  }
}
