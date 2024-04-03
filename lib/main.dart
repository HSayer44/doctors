import 'package:doctors/screens/home_screen.dart';
import 'package:doctors/shared/theme/app_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: const AppTheme().themeData,
      home: const HomeScreen(),
    );
  }
}
