import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safetrack/presentation/pages/home_page.dart';
import 'package:safetrack/presentation/pages/profile_page.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            IndexedStack(
              key: ValueKey<int>(selectedIndex),
              index: selectedIndex,
              children: const [HomePage(), ProfilePage()],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 60,
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    spreadRadius: 1,
                    blurRadius: 6,
                    offset: const Offset(0, -6),
                  ),
                ]),
                child: BottomNavigationBar(
                  selectedItemColor: const Color(0xFF023E8A),
                  selectedLabelStyle: GoogleFonts.nunito(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF023E8A),
                  ),
                  items: [
                    BottomNavigationBarItem(
                      label: 'Home',
                      icon: selectedIndex == 0
                          ? const Icon(Icons.home)
                          : const Icon(Icons.home_outlined),
                    ),
                    BottomNavigationBarItem(
                      label: "Profile",
                      icon: selectedIndex == 1
                          ? const Icon(Icons.person)
                          : const Icon(Icons.person_outline),
                    ),
                  ],
                  currentIndex: selectedIndex,
                  onTap: (int index) {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                ),
              ),
            ),
            Positioned(
              bottom: 15,
              right: MediaQuery.of(context).size.width / 2 - 35,
              child: GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Add Report')));
                },
                child: Container(
                  height: 80,
                  width: 80,
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFCFCFC),
                    borderRadius: BorderRadius.circular(500),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF023E8A),
                      borderRadius: BorderRadius.circular(500),
                    ),
                    child: const Icon(
                      Icons.add,
                      size: 48,
                      color: Color(0xFFFCFCFC),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
