import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:safetrack/presentation/bloc/features/verification_of_user/proof_of_id/image_picker_event.dart';
import 'package:safetrack/presentation/bloc/features/verification_of_user/proof_of_id/image_picker_state.dart';

class ImagePickerBloc extends Bloc<ImagePickerEvent, ImagePickerState> {
  final ImagePicker imagePicker;
  ImagePickerBloc(this.imagePicker) : super(ImagePickerInitial()) {
    on<ImagePickerRequestedEvent>(imagePickerRequestedEvent);
    on<ImagePickerRemovedRequestedEvent>(imagePickerRemovedRequestedEvent);
  }

  FutureOr<void> imagePickerRequestedEvent(
      ImagePickerRequestedEvent event, Emitter<ImagePickerState> emit) async {
    emit(ImagePickerLoading());
    log('clicked the image picker');
    try {
      final XFile? pickedFile =
          await imagePicker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        final String imageUrl = pickedFile.path;
        log('The image url is: $imageUrl');
        emit(ImagePickerSuccess(File(pickedFile.path), imageUrl));
      } else {
        emit(ImagePickerError(error: 'Please select an image first'));
      }
    } catch (e) {
      emit(ImagePickerError(error: e.toString()));
    }
  }

  FutureOr<void> imagePickerRemovedRequestedEvent(
      ImagePickerRemovedRequestedEvent event, Emitter<ImagePickerState> emit) {
    emit(ImagePickerInitial());
  }
}
