// ignore_for_file: use_build_context_synchronously, deprecated_member_use
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safetrack/presentation/bloc/features/report/camera/camera_bloc.dart';
import 'package:safetrack/presentation/bloc/features/report/camera/camera_event.dart';
import 'package:safetrack/presentation/bloc/features/report/camera/camera_state.dart';
import 'package:safetrack/presentation/pages/home/features/report/photo_preview_page.dart';
import 'package:safetrack/presentation/theme/colors.dart';
import 'package:safetrack/services/global.dart';

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
        return (current is CameraInitializingState &&
                previous is CameraInitial) ||
            current is CameraInitializedState ||
            current is CameraErrorState ||
            current is TakingEvidenceLoadingState;
      },
      builder: (context, state) {
        CameraController? controller;
        Widget body;
        switch (state) {
          case CameraInitializingState():
            body = const Expanded(
              child: Center(
                child: CircularProgressIndicator(
                  color: LightColor.whitePrimaryTextColor,
                ),
              ),
            );
            break;
          case CameraInitializedState():
            controller = state.controller;
            body = Expanded(
              child: SizedBox.expand(
                child: CameraPreview(state.controller),
              ),
            );
            break;
          case CameraErrorState():
            body = Expanded(
              child: Center(
                child: Text(
                  state.errorMessage,
                  style: GoogleFonts.quicksand(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
            break;
          case TakingEvidenceLoadingState():
            body = Expanded(
              child: Container(
                width: double.infinity,
                color: LightColor.blackPrimaryTextColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(
                      color: LightColor.whitePrimaryTextColor,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'The picture is being captured, please wait...',
                      style: GoogleFonts.quicksand(
                        fontSize: 16,
                        color: LightColor.whitePrimaryTextColor,
                      ),
                    ),
                  ],
                ),
              ),
            );
            break;
          default:
            body = Expanded(
              child: Center(
                child: Text(
                  'Nako yun lang',
                  style: GoogleFonts.quicksand(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: LightColor.whitePrimaryTextColor,
                  ),
                ),
              ),
            );
            break;
        }
        return WillPopScope(
          onWillPop: () async {
            context.read<CameraBloc>().add(DisposeCameraEvent());
            return true;
          },
          child: Scaffold(
            backgroundColor: LightColor.blackPrimaryTextColor,
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 24,
                    bottom: 24,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
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
                      BlocBuilder<CameraBloc, CameraState>(
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
                    ],
                  ),
                ),
                body,
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                color: LightColor.blackPrimaryTextColor,
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
                              if (state is TakingEvidenceLoadingState) {
                                null;
                              } else {
                                context
                                    .read<CameraBloc>()
                                    .add(CapturePhotoEvent());
                              }
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
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: GestureDetector(
                            onTap: () {
                              if (controller != null) {
                                context
                                    .read<CameraBloc>()
                                    .add(SwitchCameraEvent(
                                      controller: controller,
                                    ));
                              } else {
                                snackBar(
                                  context,
                                  'Camera controller is not initialized.',
                                  LightColor.primaryColor,
                                );
                              }
                            },
                            child: const Center(
                              child: Icon(
                                Icons.cameraswitch_outlined,
                                color: LightColor.whitePrimaryTextColor,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
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
