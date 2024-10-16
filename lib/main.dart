import 'package:flutter/material.dart';
import 'screens/account_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplicação Bancária',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Color(0xFF1B1B1B),
        cardColor: Color(0xFF2C2C2C),
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: Colors.white), // Cor do texto
          bodySmall: TextStyle(color: Colors.white70), // Texto secundário
        ),
      ),
      home: AccountList(),
    );
  }
}
