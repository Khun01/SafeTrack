import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safetrack/presentation/bloc/features/add_report/camera/camera_bloc.dart';
import 'package:safetrack/presentation/bloc/features/add_report/camera/camera_event.dart';
import 'package:safetrack/presentation/bloc/features/add_report/camera/camera_state.dart';
import 'package:safetrack/presentation/pages/features/submit_report/photo_preview_page.dart';
import 'package:safetrack/presentation/widgets/my_circular_progress_indicator.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _SubmitReportState();
}

class _SubmitReportState extends State<CameraPage> {
  @override
  void initState() {
    super.initState();
    context.read<CameraBloc>().add(InitializeCameraEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CameraBloc, CameraState>(
      listener: (context, state) {
        if (state is CameraErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage)),
          );
        }
        if (state is CameraPhotoCapturedState) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                value: context.read<CameraBloc>(),
                child: PhotoPreviewPage(photo: state.imagePath),
              ),
            ),
          );
        }
      },
      buildWhen: (previous, current) {
        return current is CameraInitializingState ||
            current is CameraInitializedState ||
            current is CameraErrorState;
      },
      builder: (context, state) {
        if (state is CameraInitializingState) {
          return const Center(child: MyCircularProgressIndicator());
        } else if (state is CameraInitializedState) {
          // ignore: deprecated_member_use
          return WillPopScope(
            onWillPop: () async {
              context.read<CameraBloc>().add(DisposeCameraEvent());
              return true;
            },
            child: Scaffold(
              body: SafeArea(
                child: Stack(
                  children: [
                    SizedBox.expand(
                      child: CameraPreview(state.controller),
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
                                        .add(DisposeCameraEvent());
                                  },
                                  child: const Icon(
                                    Icons.arrow_back,
                                    color: Color(0xFFFCFCFC),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container()
                            ),
                            Expanded(
                              child: Container(),
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 24,
                      left: 0,
                      right: 0,
                      child: SizedBox(
                        height: 70,
                        width: double.infinity,
                        child: Row(
                          children: [
                            Expanded(
                              child: Center(
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFCFCFC),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: const Color(0xFF3B3B3B),
                                      width: 2,
                                    ),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color(0x1A023E8A),
                                        offset: Offset(0.0, 10.0),
                                        blurRadius: 4.0,
                                        spreadRadius: -4.0,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: GestureDetector(
                                  onTap: () {
                                    context
                                        .read<CameraBloc>()
                                        .add(CapturePhotoEvent());
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) => const SafetyMapPage()
                                    //   ),
                                    // );
                                  },
                                  child: Container(
                                    height: 70,
                                    width: 70,
                                    padding: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFCFCFC),
                                      borderRadius: BorderRadius.circular(500),
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFCFCFC),
                                        border: Border.all(
                                          color: const Color(0xFF3B3B3B),
                                          width: 2,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(500),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  context.read<CameraBloc>().add(
                                        SwitchCameraEvent(
                                          controller: state.controller,
                                        ),
                                      );
                                },
                                child: const Center(
                                  child: Icon(
                                    Icons.cameraswitch_outlined,
                                    color: Color(0xFFFCFCFC),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else if (state is CameraErrorState) {
          return Center(child: Text(state.errorMessage));
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
