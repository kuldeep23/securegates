import 'dart:developer';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import 'compress_image.dart';

Future<File> pickNewImage(bool gallery) async {
  File? primeImage;
  ImagePicker picker = ImagePicker();
  XFile? pickedFile;

  if (gallery) {
    pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
  } else {
    pickedFile = await picker.pickImage(
      source: ImageSource.camera,
    );
  }

  if (pickedFile != null) {
    var bytes = File(pickedFile.path);
    var enc = await bytes.readAsBytes();
    log("${enc.lengthInBytes} 5555555555555555555555");
    if (enc.lengthInBytes > 37000) {
      File t = await getCompressedImage(
          File(pickedFile.path), "${pickedFile.path}kk.jpeg");
      primeImage = t;
      Fluttertoast.showToast(
          msg: "Selected successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
    } else {
      primeImage = File(pickedFile.path);
      Fluttertoast.showToast(
          msg: "Selected successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
    }
  } else {
    Fluttertoast.showToast(
        msg: "No Image Selected!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        fontSize: 16.0);
  }
  return primeImage!;
}
