// ignore_for_file: use_build_context_synchronously
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safetrack/presentation/bloc/features/add_report/camera/camera_bloc.dart';
import 'package:safetrack/presentation/bloc/features/add_report/camera/camera_event.dart';
import 'package:safetrack/presentation/bloc/features/add_report/camera/camera_state.dart';
import 'package:safetrack/presentation/pages/features/submit_report/photo_preview_page.dart';
import 'package:safetrack/presentation/theme/colors.dart';

class CameraPage extends StatelessWidget {
  const CameraPage({super.key});

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
          Future.delayed(const Duration(milliseconds: 300), () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: context.read<CameraBloc>(),
                  child: PhotoPreviewPage(photo: state.imagePath),
                ),
              ),
            );
            context.read<CameraBloc>().add(DisposeCameraEvent());
          });
        }
      },
      buildWhen: (previous, current) {
        return current is CameraInitializingState ||
            current is CameraInitializedState ||
            current is CameraErrorState;
      },
      builder: (context, state) {
        if (state is CameraInitializingState) {
          return const Center(
            child: CircularProgressIndicator(
              color: LightColor.whitePrimaryTextColor,
            ),
          );
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
                        padding:
                            const EdgeInsets.only(left: 16, top: 24, right: 16),
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
                                    color: LightColor.whitePrimaryTextColor,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(child: Container()),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: BlocBuilder<CameraBloc, CameraState>(
                                  buildWhen: (previous, current) =>
                                      current is CameraFlashToggledState,
                                  builder: (context, state) {
                                    IconData flashIcon = Icons.flash_auto;
                                    if (state is CameraFlashToggledState) {
                                      switch (state.flashMode) {
                                        case FlashMode.off:
                                          flashIcon = Icons.flash_off;
                                          break;
                                        case FlashMode.always:
                                          flashIcon = Icons.flash_on;
                                          break;
                                        case FlashMode.auto:
                                        default:
                                          flashIcon = Icons.flash_auto;
                                          break;
                                      }
                                    }
                                    return GestureDetector(
                                      onTap: () {
                                        context
                                            .read<CameraBloc>()
                                            .add(ToggleFlashEvent());
                                      },
                                      child: Icon(
                                        flashIcon,
                                        color: LightColor.whitePrimaryTextColor,
                                      ),
                                    );
                                  },
                                ),
                              ),
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
                                    color: LightColor.whitePrimaryTextColor,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: LightColor.primaryColor,
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
                                          color: LightColor.primaryColor,
                                          width: 3,
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
                                    color: LightColor.whitePrimaryTextColor,
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
          return Center(
            child: Text(
              'Error hahahahahah',
              style: GoogleFonts.quicksand(
                color: Colors.white,
              ),
            ),
          );
        }
      },
    );
  }
}
