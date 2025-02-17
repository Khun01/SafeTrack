import 'package:camera/camera.dart';

abstract class CameraState {}

class CameraInitial extends CameraState {}

class CameraInitializedState extends CameraState {
  final CameraController controller;

  CameraInitializedState(this.controller);
}

class CameraErrorState extends CameraState {
  final String errorMessage;

  CameraErrorState(this.errorMessage);
}

class TakingEvidenceLoadingState extends CameraState{}

class CameraInitializingState extends CameraState {}

class CameraPhotoCapturedState extends CameraState {
  final String imagePath;

  CameraPhotoCapturedState(this.imagePath);
}

class CameraFlashToggledState extends CameraState {
  final FlashMode flashMode;
  CameraFlashToggledState(this.flashMode);
}