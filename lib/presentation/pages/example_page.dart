import 'package:flutter/material.dart';
import 'package:safetrack/presentation/widgets/my_announcement_shimmer.dart';

class ExamplePage extends StatefulWidget {
  const ExamplePage({super.key});

  @override
  State<ExamplePage> createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: 240,
          child: MyAnnouncementShimmer(),
        ),
      ),
    );
  }
}
