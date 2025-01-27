import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safetrack/presentation/theme/colors.dart';

class MyHomePageFeatureButton extends StatelessWidget {
  final String name;
  final String image;
  final Widget? onTap;

  const MyHomePageFeatureButton({
    super.key,
    this.onTap,
    required this.name,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(500),
            boxShadow: const [
              BoxShadow(
                color: Color(0x1A023E8A),
                spreadRadius: 1,
                blurRadius: 4,
                offset: Offset(0, 4),
              )
            ],
          ),
          child: OpenContainer(
            transitionDuration: const Duration(seconds: 1),
            transitionType: ContainerTransitionType.fadeThrough,
            closedElevation: 0,
            openElevation: 0,
            openColor: Colors.transparent,
            closedColor: const Color(0xFFE5E9F4),
            closedShape: const CircleBorder(),
            closedBuilder: (context, action) {
              return Container(
                height: 60,
                width: 60,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(500),
                  color: const Color(0xFFE5E9F4),
                ),
                child: Image.asset(image),
              );
            },
            openBuilder: (context, action) {
              return onTap ?? Container(color: Colors.transparent);
            },
          ),
        ),
        const SizedBox(height: 16),
        Text(
          name,
          style: GoogleFonts.quicksand(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: LightColor.primaryColor,
          ),
        )
      ],
    );
  }
}
