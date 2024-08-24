import 'dart:io';
import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'images_state.dart';

class ImagesCubit extends Cubit<ImagesState> {
  ImagesCubit() : super(ImagesState());

  Future<void> uploadImage({required String path, required String productId}) async {
    final imageRef = FirebaseStorage.instance.ref().child('images');

    try {
      emit(ImagesState(isLoading: true));

      final imgName = path.split('/').last;

      final uploadTask = imageRef.child(imgName).putFile(File(path));

      uploadTask.snapshotEvents.listen((event) {
        switch (event.state) {
          case TaskState.running:
            final progress = 100 * (event.bytesTransferred / event.totalBytes);

            emit(ImagesState(isLoading: true, uploadProgress: progress / 100));

            break;
          case TaskState.success:
            event.ref.getDownloadURL().then((value) =>
                emit(ImagesState(isLoading: true, linkGambar: value)));
            break;
          case TaskState.error:
            emit(ImagesState(errorMessage: e.toString()));
            break;
          case TaskState.canceled || TaskState.paused:
            break;
        }
      });
    } catch (e) {
      emit(ImagesState(errorMessage: e.toString()));
    }
  }
}
