import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:safetrack/presentation/bloc/features/add_report/camera/camera_event.dart';
import 'package:safetrack/presentation/bloc/features/add_report/camera/camera_state.dart';

class CameraBloc extends Bloc<CameraEvent, CameraState> {
  CameraController? controller;
  int currentCameraIndex = 0;
  List<CameraDescription> cameras = [];

  CameraBloc() : super(CameraInitial()) {
    on<InitializeCameraEvent>(initializeCameraEvent);
    on<DisposeCameraEvent>(disposeCameraEvent);
    on<CapturePhotoEvent>(capturePhotoEvent);
    on<SwitchCameraEvent>(switchCameraEvent);
  }

  FutureOr<void> initializeCameraEvent(
      InitializeCameraEvent event, Emitter<CameraState> emit) async {
    emit(CameraInitializingState());
    try {
      cameras = await availableCameras();
      if (cameras.isEmpty) {
        emit(CameraErrorState("No cameras available"));
        return;
      }
      currentCameraIndex = 0;
      await _initializeCamera(emit);
    } catch (e) {
      emit(CameraErrorState("Error initializing camera: $e"));
    }
  }

  Future<void> _initializeCamera(Emitter<CameraState> emit) async {
    try {
      controller = CameraController(
        cameras[currentCameraIndex],
        ResolutionPreset.high,
      );
      await controller!.initialize();
      emit(CameraInitializedState(controller!));
    } catch (e) {
      emit(CameraErrorState("Error initializing camera: $e"));
    }
  }

  FutureOr<void> disposeCameraEvent(
      DisposeCameraEvent event, Emitter<CameraState> emit) async {
    await controller?.dispose();
    controller = null;
    emit(CameraInitial());
  }

  FutureOr<void> capturePhotoEvent(
      CapturePhotoEvent event, Emitter<CameraState> emit) async {
    if (controller == null || !controller!.value.isInitialized) {
      emit(CameraErrorState("Camera not initialized"));
      return;
    }
    try {
      final image = await controller!.takePicture();
      log('The image path is: ${image.path}');
      emit(CameraPhotoCapturedState(image.path));
    } catch (e) {
      emit(CameraErrorState("Error capturing photo: $e"));
    }
  }

  FutureOr<void> switchCameraEvent(
      SwitchCameraEvent event, Emitter<CameraState> emit) async {
    if (cameras.isEmpty) {
      emit(CameraErrorState("No cameras available to switch"));
      return;
    }
    await controller?.dispose();
    currentCameraIndex = (currentCameraIndex + 1) % cameras.length;
    await _initializeCamera(emit);
  }

  @override
  Future<void> close() {
    controller?.dispose();
    return super.close();
  }
}
