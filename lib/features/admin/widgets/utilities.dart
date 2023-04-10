import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:file_picker/file_picker.dart';

import 'package:flutter/material.dart';

Future<List<File>> pickImage() async {
  List<File> images = [];
  try {
    var files = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: true);
    if (files != null && files.files.isNotEmpty) {
      for (int i = 0; i < files.files.length; i++) {
        images.add(File(files.files[i].path!));
      }
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  return images;
}
