import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

class FileHelper {
  FileHelper._();

  static FileHelper get instance => FileHelper._();

  final ImagePicker _picker = ImagePicker();

  Future<File?> pickSingleFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null && (result.files.single.path ?? '').isNotEmpty) {
      File file = File(result.files.single.path ?? '');
      return file;
    } else {
      return null;
    }
  }

  // allowedExtensions: ['jpg', 'pdf', 'doc'],
  Future<List<File?>?> pickMultipleFiles(
      {List<String>? allowedExtensions}) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type:
            (allowedExtensions ?? []).isEmpty ? FileType.any : FileType.custom,
        allowedExtensions: allowedExtensions);

    if (result != null) {
      List<File?>? files = result.paths
          .where((element) => (element ?? '').isNotEmpty)
          .map((path) => File(path ?? ''))
          .toList();
      return files;
    } else {
      return null;
    }
  }

  Future<XFile?> pickImage(
      {ImageSource source = ImageSource.gallery, int quality = 60}) async {
    final XFile? image = await _picker.pickImage(
      source: source,
      imageQuality: quality,
    );
    if (image == null && Platform.isAndroid) {
      final listLostImage = await getLostData();
      if (listLostImage != null && listLostImage.isNotEmpty) {
        return listLostImage.first;
      }
    }
    return image;
  }

  Future<XFile?> pickImageFromCamera(
      {ImageSource source = ImageSource.camera, int quality = 60}) async {
    final XFile? image = await _picker.pickImage(
      source: source,
      imageQuality: quality,
    );
    if (image == null && Platform.isAndroid) {
      final listLostImage = await getLostData();
      if (listLostImage != null && listLostImage.isNotEmpty) {
        return listLostImage.first;
      }
    }
    return image;
  }

  Future<XFile?> pickVideo(
      {ImageSource source = ImageSource.gallery, Duration? maxDuration}) async {
    final XFile? video =
        await _picker.pickVideo(source: source, maxDuration: maxDuration);
    if (video == null && Platform.isAndroid) {
      final listLostVideo = await getLostData();
      if (listLostVideo != null && listLostVideo.isNotEmpty) {
        return listLostVideo.first;
      }
    }
    return video;
  }

  Future<List<XFile?>?> pickMultipleImages({int quality = 60}) async {
    final List<XFile?>? images =
        await _picker.pickMultiImage(imageQuality: quality);
    if (Platform.isAndroid) {
      final listLostImages = await getLostData();
      if (listLostImages != null && listLostImages.isNotEmpty) {
        images?.addAll(listLostImages);
      }
    }

    return images;
  }

  Future<List<XFile?>?> getLostData() async {
    final LostDataResponse response = await _picker.retrieveLostData();
    if (response.isEmpty) {
      return null;
    }
    return response.files;
  }

  bool isImageFile(List<File?>? files) {
    for (var i in files!) {
      if (i != null &&
          (i.path.contains(".jpg") ||
              i.path.contains(".apng") ||
              i.path.contains(".avif") ||
              i.path.contains(".gif") ||
              i.path.contains(".jpeg") ||
              i.path.contains(".jfif") ||
              i.path.contains(".pjp") ||
              i.path.contains(".png") ||
              i.path.contains(".webp") ||
              i.path.contains(".svg") ||
              i.path.contains(".pjpeg"))) {
        return true;
      }
    }
    return false;
  }
}
