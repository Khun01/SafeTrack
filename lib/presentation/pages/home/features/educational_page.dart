import 'package:flutter/material.dart';
import 'package:safetrack/presentation/widgets/my_header.dart';

class EducationalPage extends StatelessWidget {
  const EducationalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          MyHeader(title: 'Educational'),
        ],
      ),
    );
  }
}