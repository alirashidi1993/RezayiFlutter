import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/Repos/device_repository.dart';
import 'package:myapp/Services/snackbar_service.dart';
import 'package:myapp/controllers/device_controller.dart';

class DeviceSettingsDialog extends StatelessWidget {
  final DeviceController deviceController = Get.put(DeviceController());

  final _moveTimeController = TextEditingController();
  final _autoCloseTimeController = TextEditingController();

  void closeDialog(BuildContext context) {
    Navigator.pop(context);
  }

  Future<void> updateDeviceSettings(BuildContext context) async {
    try {
      await deviceController
          .updateDeviceSettings(_moveTimeController.text,_autoCloseTimeController.text);
      Navigator.pop(context);
      SnackbarService(context).ShowSuccessMessage('تنظیمات با موفقیت ذخیره شد');
    } catch (e) {
      SnackbarService(context).ShowErrorMessage('خطا! لطفا دوباره امتحان کنید');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'تنظیمات پیشرفته',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            Table(
              children: [
                TableRow(
                  children: [
                    TableCell(
                      child: Obx(
                        () {
                          if (deviceController.currentDevice.value == null) {
                            return CircularProgressIndicator();
                          } else {
                            var moveTime = deviceController
                                    .currentDevice.value?.moveTime
                                    .toString() ??
                                '';
                            _moveTimeController.text = moveTime;
                            return TextFormField(
                              controller: _moveTimeController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'زمان حرکت',
                                border: OutlineInputBorder(),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(
                      child: SizedBox(height: 10),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(
                      child: Obx(
                        () {
                          if (deviceController.currentDevice.value == null) {
                            return CircularProgressIndicator();
                          } else {
                            _autoCloseTimeController.text = deviceController
                                    .currentDevice.value?.autoCloseTime
                                    .toString() ??
                                '';
                            return TextFormField(
                              controller: _autoCloseTimeController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'زمان بسته شدن خودکار',
                                border: OutlineInputBorder(),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(
                      child: SizedBox(
                        height: 30,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    updateDeviceSettings(context);
                  },
                  style: ElevatedButton.styleFrom(
                    textStyle: TextStyle(fontSize: 16, fontFamily: 'vazir'),
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)),
                  ),
                  child: Text('ذخیره'),
                ),
                ElevatedButton(
                  onPressed: () {
                    closeDialog(context);
                  },
                  style: ElevatedButton.styleFrom(
                    textStyle: TextStyle(fontSize: 16, fontFamily: 'vazir'),
                    backgroundColor: Color(0xff6c757d),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)),
                  ),
                  child: Text('بستن'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
