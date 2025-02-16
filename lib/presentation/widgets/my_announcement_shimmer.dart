// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MyAnnouncementShimmer extends StatelessWidget {
  const MyAnnouncementShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      margin: const EdgeInsets.only(left: 16, bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FBFF),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0x1A023E8A)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A023E8A),
            offset: Offset(0.0, 10.0),
            blurRadius: 4.0,
            spreadRadius: -4.0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Shimmer.fromColors(
                baseColor: const Color(0x4C3B3B3B),
                highlightColor: Colors.white.withOpacity(0.3),
                child: Container(
                  height: 16,
                  width: 70,
                  decoration: BoxDecoration(
                    color: const Color(0x4C3B3B3B),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              Shimmer.fromColors(
                baseColor: const Color(0x4C3B3B3B),
                highlightColor: Colors.white.withOpacity(0.3),
                child: Container(
                  height: 16,
                  width: 50,
                  decoration: BoxDecoration(
                    color: const Color(0x4C3B3B3B),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Shimmer.fromColors(
            baseColor: const Color(0x4C3B3B3B),
            highlightColor: Colors.white.withOpacity(0.3),
            child: Container(
              height: 18,
              width: 200,
              decoration: BoxDecoration(
                color: const Color(0x4C3B3B3B),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Shimmer.fromColors(
            baseColor: const Color(0x4C3B3B3B),
            highlightColor: Colors.white.withOpacity(0.3),
            child: Container(
              height: 18,
              width: 180,
              decoration: BoxDecoration(
                color: const Color(0x4C3B3B3B),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Shimmer.fromColors(
            baseColor: const Color(0x4C3B3B3B),
            highlightColor: Colors.white.withOpacity(0.3),
            child: Container(
              height: 18,
              width: 160,
              decoration: BoxDecoration(
                color: const Color(0x4C3B3B3B),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Shimmer.fromColors(
            baseColor: const Color(0x4C3B3B3B),
            highlightColor: Colors.white.withOpacity(0.3),
            child: Container(
              height: 18,
              width: 140,
              decoration: BoxDecoration(
                color: const Color(0x4C3B3B3B),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          const Spacer(),
          Shimmer.fromColors(
            baseColor: const Color(0x4C3B3B3B),
            highlightColor: Colors.white.withOpacity(0.3),
            child: Container(
              height: 30,
              width: 120,
              decoration: BoxDecoration(
                color: const Color(0x4C3B3B3B),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
