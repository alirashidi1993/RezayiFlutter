import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/Models/Device.dart';
import 'package:myapp/controllers/device_controller.dart';
import 'package:myapp/controllers/icon_controller.dart';

class Devicecontroldialog extends StatelessWidget {
  final IconController controller = Get.put(IconController());
  final DeviceController deviceController = Get.put(DeviceController());
  late Device device;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Obx(() {
                    if (deviceController.currentDevice.value == null) {
                      return CircularProgressIndicator();
                    } else {
                      return Text(
                        deviceController.currentDevice.value?.name ?? '',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      );
                    }
                  }),
                ),
                SizedBox(
                  width: 140,
                  height: 140,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amberAccent,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Icon(Icons.arrow_upward),
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: 140,
                  height: 140,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[600],
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Icon(
                      Icons.square,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: 140,
                  height: 140,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amberAccent,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Icon(Icons.arrow_downward),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 50,
                  height: 50,
                  child: Obx(
                    () => IconButton(
                      onPressed: () {
                        controller.toggleIcon();
                      },
                      icon: Icon(
                        controller.deviceIsLocked.value
                            ? Icons.lock
                            : Icons.lock_open,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
