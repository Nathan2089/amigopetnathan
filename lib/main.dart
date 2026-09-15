import 'package:flutter/material.dart';
import 'styles/app_styles.dart';
import 'pages/caregiver_list_page.dart';

void main() {
  runApp(const AmigoPetApp());
}

class AmigoPetApp extends StatelessWidget {
  const AmigoPetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AmigoPet',
      debugShowCheckedModeBanner: false,
      theme: AppStyles.themeData,
      home: const CaregiverListPage(),
    );
  }
}
