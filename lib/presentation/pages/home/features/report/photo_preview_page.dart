import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safetrack/presentation/bloc/features/report/camera/camera_bloc.dart';
import 'package:safetrack/presentation/bloc/features/report/camera/camera_event.dart';
import 'package:safetrack/presentation/bloc/features/report/camera/camera_state.dart';
import 'package:safetrack/presentation/pages/home/features/report/submit_report_page.dart';
import 'package:safetrack/presentation/theme/colors.dart';

class PhotoPreviewPage extends StatelessWidget {
  final String photo;
  const PhotoPreviewPage({super.key, required this.photo});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CameraBloc, CameraState>(
      listener: (context, state) {},
      builder: (context, state) {
        // ignore: deprecated_member_use
        return WillPopScope(
          onWillPop: () async {
            context.read<CameraBloc>().add(InitializeCameraEvent());
            return true;
          },
          child: Scaffold(
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
                                  context
                                      .read<CameraBloc>()
                                      .add(InitializeCameraEvent());
                                },
                                child: const Icon(
                                  Icons.close_rounded,
                                  color: LightColor.whitePrimaryTextColor,
                                ),
                              ),
                            ),
                          ),
                          Expanded(child: Container()),
                          Expanded(child: Container())
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 16,
                    right: 16,
                    bottom: 24,
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => BlocProvider.value(
                                value: context.read<CameraBloc>(),
                                child: SubmitReportPage(photo: photo),
                              ),
                            ),
                          );
                        },
                        child: Container(
                          height: 70,
                          width: 70,
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: LightColor.whitePrimaryTextColor,
                            borderRadius: BorderRadius.circular(500),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: LightColor.whitePrimaryTextColor,
                              border: Border.all(
                                color: LightColor.blackPrimaryTextColor,
                                width: 3,
                              ),
                              borderRadius: BorderRadius.circular(500),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.check_rounded,
                                color: LightColor.blackPrimaryTextColor,
                                size: 48,
                                weight: 3,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
