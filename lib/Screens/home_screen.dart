import 'package:flutter/material.dart';
import 'package:myapp/Models/Device.dart';
import 'package:myapp/Repos/device_repository.dart';

import 'package:myapp/Widgets/device_list_grid_view.dart';

class HomeScreen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('دستگاه ها'),),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DeviceListGridView(),
        ),
      
    );
  }

}