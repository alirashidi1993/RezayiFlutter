import 'package:flutter/material.dart';
import 'package:myapp/Models/Device.dart';
import 'package:myapp/Services/navigation_service.dart';
import 'package:myapp/Repos/device_repository.dart';
import 'package:myapp/main.dart';

class AddNewDeviceScreen extends StatefulWidget {
  const AddNewDeviceScreen({super.key});

  @override
  State<StatefulWidget> createState() => _AddNewDeviceScreenState();
}

class _AddNewDeviceScreenState extends State<AddNewDeviceScreen> {
  final _nameController = TextEditingController();
  final _numberController = TextEditingController();
  final _passwordController = TextEditingController();

  Future _submitData() async {
    final String name = _nameController.text;
    final String password = _passwordController.text;
    final String number = _numberController.text;

    if (name.isEmpty ||
        password.isEmpty ||
        number.toString().length < 11) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("اطلاعات را کامل پر کنید"),
        backgroundColor: Colors.redAccent,
      ));
      return;
    }
    final deviceRepository = DeviceRepository();

    final newDevice = Device(name: name, number: number, password: password);
    await deviceRepository.insertDevice(newDevice);

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("با موفقیت ثبت شد"), backgroundColor: Colors.green));
    _nameController.clear();
    _passwordController.clear();
    _nameController.clear();
    NavigationService.instance.navigateToRoute(
      MaterialPageRoute(
        builder: (context) => MyHomePage(title: 'دستگاه ها'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("تعریف دستگاه جدید")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                  labelText: "نام دستگاه:",
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.info)),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _numberController,
              keyboardType: TextInputType.number,
              maxLength: 11,
              decoration: InputDecoration(
                  labelText: "شماره:",
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.numbers)),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                    labelText: "رمز ورود:",
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.password)),
                obscureText: true),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                ElevatedButton(
                  onPressed: () {
                    _submitData();
                  },
                  style: ButtonStyle(
                    padding: WidgetStateProperty.all(EdgeInsets.all(16)),
                    backgroundColor: WidgetStateProperty.all(Colors.teal),
                    foregroundColor: WidgetStateProperty.all(Colors.white),
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  child: Text('ثبت دستگاه'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyHomePage(
                          title: 'دستگاه ها',
                          key: null,
                        ),
                      ),
                    );
                  },
                  style: ButtonStyle(
                    padding: WidgetStateProperty.all(EdgeInsets.all(16)),
                    backgroundColor: WidgetStateProperty.all(Colors.grey),
                    foregroundColor: WidgetStateProperty.all(Colors.white),
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  child: Text('بازگشت'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
