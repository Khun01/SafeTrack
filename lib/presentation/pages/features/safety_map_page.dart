import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SafetyMapPage extends StatefulWidget {
  const SafetyMapPage({super.key});

  @override
  State<SafetyMapPage> createState() => _SafetyMapPageState();
}

class _SafetyMapPageState extends State<SafetyMapPage> {
  final LatLngBounds _restrictedBounds = LatLngBounds(
    southwest: const LatLng(16.0260, 120.3121),
    northeast: const LatLng(16.0713, 120.3594), 
  );

  // ignore: unused_field
  late GoogleMapController _mapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [    
            GoogleMap(
              initialCameraPosition: const CameraPosition(
                target: LatLng(16.0431, 120.3333), 
                zoom: 16,
              ),
              mapType: MapType.terrain,
              onMapCreated: (GoogleMapController controller) {
                _mapController = controller;
              },
              compassEnabled: false,
              cameraTargetBounds: CameraTargetBounds(_restrictedBounds),
              myLocationEnabled: true,
              zoomGesturesEnabled: false,
              zoomControlsEnabled: false,
            ),
            Positioned(
              top: 24,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  height: 50,
                  width: 100,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFCFCFC),
                    borderRadius: BorderRadius.circular(500),
                    border: Border.all(color: const Color(0x1A023E8A)),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x1A3B3B3B),
                        offset: Offset(0.0, 10.0),
                        blurRadius: 4.0,
                        spreadRadius: -4.0,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'Map',
                      style: GoogleFonts.quicksand(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF3B3B3B),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 24,
              left: 16,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: 50,
                  width: 50,
                  padding: const EdgeInsets.only(left: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFCFCFC),
                    borderRadius: BorderRadius.circular(500),
                    border: Border.all(color: const Color(0x1A023E8A)),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x1A3B3B3B),
                        offset: Offset(0.0, 10.0),
                        blurRadius: 4.0,
                        spreadRadius: -4.0,
                      ),
                    ],
                  ),
                  child: const Icon(Icons.arrow_back_ios),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
