import 'dart:typed_data';

class ImageModel {
  Uint8List? data;
  String name;

  ImageModel({
    required this.name,
    required this.data,
  });
}
