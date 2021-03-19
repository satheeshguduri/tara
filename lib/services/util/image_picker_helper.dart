import 'package:image_picker/image_picker.dart';

class ImagePickerHelper {

  //returns the path of the camera image
  static Future<String> takeImageFromCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    return pickedFile?.path;
  }
}
