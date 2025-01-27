import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safetrack/presentation/bloc/features/add_report/camera/camera_bloc.dart';
import 'package:safetrack/presentation/bloc/features/add_report/camera/camera_event.dart';
import 'package:safetrack/presentation/bloc/features/add_report/camera/camera_state.dart';
import 'package:safetrack/presentation/pages/features/submit_report/submit_report_page.dart';

class PhotoPreviewPage extends StatelessWidget {
  final String photo;
  const PhotoPreviewPage({super.key, required this.photo});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CameraBloc, CameraState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Image.file(
                      File(photo),
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.only(left: 16, top: 24),
                    width: double.infinity,
                    child: Row(
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(
                                Icons.close_rounded,
                                color: Color(0xFFFCFCFC),
                              ),
                            ),
                          ),
                        ),
                        Expanded(child: Container()),
                        Expanded(
                          child: Container(),
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 16,
                  right: 16,
                  bottom: 24,
                  child: Center(
                    child: SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<CameraBloc>().add(DisposeCameraEvent());
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => SubmitReportPage(photo: photo),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF023E8A),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Next',
                          style: GoogleFonts.quicksand(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFFFCFCFC),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
