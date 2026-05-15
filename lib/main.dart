// main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fitness_app1/core/theme/theme_provider.dart';
import 'package:fitness_app1/app.dart'; // ملف الـ app بتاعك

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const FitnessApp(),
    ),
  );
}
