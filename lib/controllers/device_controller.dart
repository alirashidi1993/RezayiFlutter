import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/Models/Device.dart';
import 'package:myapp/Repos/device_repository.dart';

class DeviceController extends GetxController {
  Rxn currentDevice = Rxn<Device>();
  Rx buildContext = Rx(BuildContext);

  Future<void> updateDeviceSettings(
      String? moveTime, String? autoCloseTime) async {
    if (currentDevice.value != null) {
      currentDevice.value.moveTime = int.tryParse(moveTime ?? '0');
      currentDevice.value.autoCloseTime = int.tryParse(autoCloseTime ?? '0');
      await DeviceRepository().updateDevice(currentDevice.value);
    }
  }

  Future<void> initializeCurrentDevice(int? id) async {
    currentDevice.value = await DeviceRepository().getById(id);
  }
}
