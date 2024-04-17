import 'dart:typed_data';
import 'package:couple/models/image_model.dart';
import 'package:couple/utils/logger.dart';
import 'package:firebase_storage/firebase_storage.dart';

class MediaService {
  final storageRef = FirebaseStorage.instance.ref('images');

  Future<void> uploadImage(ImageModel image) async {
    final imageRef = storageRef.child(image.name);
    try {
      await imageRef.putData(image.data!);
      return;
    } on FirebaseException catch (e) {
      logger(from: "MediaService", message: "${e.code} ${e.message}");
    }
  }

  Future<ImageModel?> getImage(String path) async {
    final imageRef = storageRef.child(path);
    try {
      Uint8List? imageData = await imageRef.getData();
      if (imageData != null) {
        return ImageModel(name: path, data: imageData);
      }
      return null;
    } on FirebaseException catch (e) {
      logger(from: "MediaService", message: "${e.code} ${e.message}");
      return null;
    }
  }
}
