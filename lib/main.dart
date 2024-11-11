// import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:myapp/Screens/add_new_device_screen.dart';
import 'package:myapp/Screens/home_screen.dart';
import 'package:myapp/Services/navigation_service.dart';
// import 'package:flutter/foundation.dart' show kIsWeb;
// import 'package:sqflite_common_ffi/sqflite_ffi.dart';
void main() {
//  if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
//     // Initialize FFI for desktop platforms
//     sqfliteFfiInit();
//     databaseFactory = databaseFactoryFfi;
//   }
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: MaterialApp(
          title: 'Flutter Demo',
          navigatorKey: NavigationService.instance.navigatorKey,
          locale: const Locale('ar'),
          supportedLocales: const [Locale('en'), Locale('ar')],
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          theme: ThemeData(
            appBarTheme: AppBarTheme(
                backgroundColor: Color(0xFF1A237E),
                foregroundColor: Colors.white),
            fontFamily: 'vazir',
            colorScheme: ColorScheme.fromSeed(
                seedColor: const Color.fromARGB(255, 228, 55, 12)),
            useMaterial3: true,
            buttonTheme: ButtonThemeData(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
            ),
          ),
          home: const MyHomePage(title: 'Flutter Demo Home Page'),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: HomeScreen()),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF00796B),
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddNewDeviceScreen(),
            ),
          );
        },
        tooltip: 'افزودن دستگاه جدید',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
