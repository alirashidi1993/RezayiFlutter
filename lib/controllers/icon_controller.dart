import 'package:get/get.dart';

class IconController extends GetxController{

  var deviceIsLocked=false.obs;

  void toggleIcon()
  {
    deviceIsLocked.value=!deviceIsLocked.value;
  }
}