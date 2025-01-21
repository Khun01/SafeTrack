import 'dart:io';

abstract class ImagePickerState {}

final class ImagePickerInitial extends ImagePickerState {}

class ImagePickerSuccess extends ImagePickerState {
  final File image;
  final String imageUrl;

  ImagePickerSuccess(this.image, this.imageUrl);
}

class ImagePickerError extends ImagePickerState {
  final String error;

  ImagePickerError({required this.error});
}

class ImagePickerLoading extends ImagePickerState {}
