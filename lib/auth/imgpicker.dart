import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImgPicker {
  final ImagePicker picker = ImagePicker();
  File? image;
  String? imgUrl;
  Future getImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (pickedFile != null) {
      image = File(pickedFile.path);
      imgUrl = pickedFile.path; // Lưu URL của ảnh vào biến imgUrl
    } else {
      print("No image selected");
    }
  }
}
