import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/Models/Device.dart';
import 'package:myapp/Repos/device_repository.dart';
import 'package:myapp/Widgets/confirmation_box.dart';
import 'package:myapp/Widgets/device_control_dialog.dart';
import 'package:myapp/Widgets/device_settings_dialog.dart';
import 'package:myapp/controllers/device_controller.dart';

class DeviceListGridView extends StatefulWidget {
  @override
  _DeviceListGridViewState createState() {
    return _DeviceListGridViewState();
  }
}

class _DeviceListGridViewState extends State<DeviceListGridView> {
  final DeviceController deviceController = Get.put(DeviceController());
  late Future<List<Device>> _devices;
  Future<List<Device>> fetchDevicesAsync() async {
    return await DeviceRepository().getAllDevices();
  }

  Future<void> deleteDevice(int? id) async {
    await DeviceRepository().deleteDevice(id);
    setState(() {
      _devices = fetchDevicesAsync();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchDevicesAsync(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.data?.isEmpty ?? true) {
          return Center(
            child: Text(
              'دستگاهی یافت نشد',
              style: TextStyle(fontFamily: 'vazir'),
            ),
          );
        } else if (snapshot.hasData) {
          return Table(
            border: TableBorder.all(color: Colors.grey, width: 0.5),
            columnWidths: const {
              0: FlexColumnWidth(1.5),
              1: FlexColumnWidth(1),
              2: FlexColumnWidth(1),
              3: FlexColumnWidth(1),
            },
            children: [
              TableRow(
                  decoration: BoxDecoration(color: Colors.grey[100]),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'نام دستگاه',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                          textAlign: TextAlign.center),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                          textAlign: TextAlign.center),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                          textAlign: TextAlign.center),
                    )
                  ]),
              for (var device in snapshot.requireData)
                TableRow(
                  children: [
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: GestureDetector(
                          onTap: () {
                            deviceController.initializeCurrentDevice(device.id);
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Devicecontroldialog();
                              },
                            );
                          },
                          child: Text(
                            device.name,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 4),
                        child: ElevatedButton(
                          onPressed: () {
                            deviceController.initializeCurrentDevice(device.id);
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return DeviceSettingsDialog();
                              },
                            );
                          },
                          style: ButtonStyle(
                            fixedSize: WidgetStateProperty.all(Size(70, 40)),
                            backgroundColor:
                                WidgetStateProperty.all(Color(0xFF4CAF50)),
                            foregroundColor:
                                WidgetStateProperty.all(Colors.white),
                            shape: WidgetStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                          child: Icon(Icons.settings),
                        ),
                      ),
                    ),
                    TableCell(
                        child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 4),
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                  fixedSize:
                                      WidgetStateProperty.all(Size(70, 40)),
                                  backgroundColor: WidgetStateProperty.all(
                                      Color(0xFFFFC107)),
                                  foregroundColor:
                                      WidgetStateProperty.all(Colors.black),
                                  minimumSize:
                                      WidgetStateProperty.all(Size(100, 40)),
                                  shape: WidgetStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0)))),
                              child: Icon(Icons.edit),
                            ))),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.fill,
                      child: Center(
                        child: ElevatedButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return ConfirmationBox(
                                    title: 'حذف دستگاه',
                                    content: 'آیا از حذف دستگاه مطمن هستید؟',
                                    onConfirm: () async {
                                      await deleteDevice(device.id);
                                    },
                                    onCancel: () {},
                                  );
                                });
                          },
                          style: ButtonStyle(
                              fixedSize: WidgetStateProperty.all(Size(70, 40)),
                              foregroundColor:
                                  WidgetStateProperty.all(Colors.white),
                              backgroundColor:
                                  WidgetStateProperty.all(Color(0xFFF44336)),
                              shape: WidgetStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(8.0)))),
                          child: Icon(Icons.delete),
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          );
        } else {
          return Center(
            child: Text(
              'دستگاهی یافت نشد',
              style: TextStyle(fontFamily: 'vazir'),
            ),
          );
        }
      },
    );
  }
}
