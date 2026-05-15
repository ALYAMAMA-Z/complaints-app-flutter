import 'package:flutter/material.dart';
import 'screens/complaints_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'شكاوى بلديتي',
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Tajawal',
        useMaterial3: true,
      ),
      home: const ComplaintsListScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
