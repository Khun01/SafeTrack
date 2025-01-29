import 'package:camera/camera.dart';

abstract class CameraEvent {}

class InitializeCameraEvent extends CameraEvent {}

class CapturePhotoEvent extends CameraEvent {}

class DisposeCameraEvent extends CameraEvent {}

class SwitchCameraEvent extends CameraEvent {
  final CameraController controller;

  SwitchCameraEvent({required this.controller});
}

class ToggleFlashEvent extends CameraEvent {}

class ResetCameraStateEvent extends CameraEvent {}