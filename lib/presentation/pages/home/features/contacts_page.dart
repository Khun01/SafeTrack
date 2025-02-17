import 'package:flutter/material.dart';
import 'package:safetrack/presentation/widgets/my_header.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            MyHeader(title: 'Contacts'),
          ],
        ),
      ),
    );
  }
}
