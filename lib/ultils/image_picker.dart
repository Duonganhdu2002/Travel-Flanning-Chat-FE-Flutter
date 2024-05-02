import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

bool isImagePickerActive = false;

Future<Uint8List?> pickCustomImage(ImageSource source) async {
  if (isImagePickerActive) {
    return null;
  }

  isImagePickerActive = true;

  try {
    final ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: source);
    if (file != null) {
      return await file.readAsBytes();
    } else {
      debugPrint("Không có ảnh được chọn!");
      return null;
    }
  } catch (e) {
    return null;
  } finally {
    isImagePickerActive = false;
  }
}
