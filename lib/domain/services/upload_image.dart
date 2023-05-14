import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class UploadImage {
  static Future<String> byFireBase(String imagePath) async {
    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference root = FirebaseStorage.instance.ref();
    Reference dirImages = root.child('images');
    Reference fileUpload = dirImages.child(uniqueFileName);
    await fileUpload.putFile(File(imagePath));
    return await fileUpload.getDownloadURL();
  }
}
