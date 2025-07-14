import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';

class CameraContoller extends GetxController
{
    Rx<XFile?>  returnimage = Rx<XFile?>(null);
    Future<void> camera() async
    {
      final pickimage = await ImagePicker().pickImage(source: ImageSource.camera);
      if(pickimage != null)
        {
            returnimage.value = pickimage;
        }
    }
}

