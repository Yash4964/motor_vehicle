import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CameraContoller extends GetxController {
  Rx<XFile?> returnimage = Rx<XFile?>(null);
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImageOption(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () async {
                  Navigator.of(context).pop();
                  final pickedImage =
                  await _picker.pickImage(source: ImageSource.camera);
                  if (pickedImage != null) {
                    returnimage.value = pickedImage;
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () async {
                  Navigator.of(context).pop();
                  final pickedImage =
                  await _picker.pickImage(source: ImageSource.gallery);
                  if (pickedImage != null) {
                    returnimage.value = pickedImage;
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
