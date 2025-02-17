import 'package:flutter/material.dart';
import 'package:safetrack/presentation/widgets/my_header.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            MyHeader(title: 'Notifications'),
          ],
        ),
      ),
    );
  }
}
