import 'dart:developer';
import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';

Future<File> getCompressedImage(File ogFile, String targetPath) async {
  var result = await FlutterImageCompress.compressAndGetFile(
      ogFile.absolute.path, targetPath,
      quality: 88);
  File compressedFile = File(result!.path);
  log("${ogFile.lengthSync()}orignal length");
  log("${compressedFile.lengthSync()}result length");
  return compressedFile;
}
