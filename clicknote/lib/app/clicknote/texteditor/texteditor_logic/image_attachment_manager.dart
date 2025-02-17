import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';

class ImageAttachmentManager {
  static const int maxImagesAllowed = 4;
  final List<Uint8List> _images = [];

  List<Uint8List> get images => List.unmodifiable(_images);

  /// Retorna true si se agregaron imágenes, false si el usuario canceló
  /// o no se agregó nada nuevo.
  Future<bool> pickImagesFromGallery() async {
    try {
      if (_images.length >= maxImagesAllowed) {
        // ignore: avoid_print
        print('Reached the limit of $maxImagesAllowed images.');
        return false;
      }

      final picker = ImagePicker();
      final List<XFile> pickedFiles = await picker.pickMultiImage();

      // Si es null o vacío, usuario canceló
      if (pickedFiles.isEmpty) {
        return false;
      }

      final allowedSlots = maxImagesAllowed - _images.length;
      final truncatedPickedFiles = pickedFiles.take(allowedSlots).toList();

      final List<Uint8List> imageBytesToAdd = [];
      for (var file in truncatedPickedFiles) {
        Uint8List originalBytes = await file.readAsBytes();
        Uint8List resizedBytes = _processImage(originalBytes);

        // Descartamos si sigue siendo >5MB
        if (resizedBytes.lengthInBytes > 5 * 1024 * 1024) {
          // ignore: avoid_print
          print('This image is > 5MB after resizing. Discarding.');
          continue;
        }

        // Evitamos duplicados
        final exists = _images.any(
          (imgBytes) => const ListEquality().equals(imgBytes, resizedBytes),
        );
        if (!exists) {
          imageBytesToAdd.add(resizedBytes);
        }
      }

      _images.addAll(imageBytesToAdd);

      // Retornamos true si al menos se agregó algo
      return imageBytesToAdd.isNotEmpty;
    } catch (e) {
      // ignore: avoid_print
      print('Error picking images from gallery: $e');
      return false;
    }
  }

  /// Igual que arriba, pero con la cámara
  Future<bool> pickImageFromCamera() async {
    try {
      if (_images.length >= maxImagesAllowed) {
        // ignore: avoid_print
        print('Reached the limit of $maxImagesAllowed images.');
        return false;
      }

      final picker = ImagePicker();
      final XFile? pickedFile = await picker.pickImage(source: ImageSource.camera);

      // Si es null, usuario canceló
      if (pickedFile == null) {
        return false;
      }

      Uint8List originalBytes = await pickedFile.readAsBytes();
      Uint8List resizedBytes = _processImage(originalBytes);

      // Descartar si sigue siendo >5MB
      if (resizedBytes.lengthInBytes > 5 * 1024 * 1024) {
        // ignore: avoid_print
        print('Camera image is > 5MB after resizing. Discarding.');
        return false;
      }

      final exists = _images.any(
        (imgBytes) => const ListEquality().equals(imgBytes, resizedBytes),
      );
      if (!exists) {
        _images.add(resizedBytes);
        return true;
      }
      return false;
    } catch (e) {
      // ignore: avoid_print
      print('Error picking image from camera: $e');
      return false;
    }
  }

  Uint8List _processImage(Uint8List inputBytes) {
    final img.Image? original = img.decodeImage(inputBytes);
    if (original == null) {
      // ignore: avoid_print
      print('Could not decode image. Returning original bytes.');
      return inputBytes;
    }

    const maxDimension = 1280;
    final width = original.width;
    final height = original.height;

    bool needsResize = width > maxDimension || height > maxDimension;
    img.Image finalImage = original;

    if (needsResize) {
      if (width > height) {
        finalImage = img.copyResize(original, width: maxDimension);
      } else {
        finalImage = img.copyResize(original, height: maxDimension);
      }
    }

    final jpgBytes = img.encodeJpg(finalImage, quality: 80);
    return Uint8List.fromList(jpgBytes);
  }

  void clearImageAtIndex(int index) {
    if (index >= 0 && index < _images.length) {
      _images.removeAt(index);
    }
  }

  void clearAllImages() {
    _images.clear();
  }
}
