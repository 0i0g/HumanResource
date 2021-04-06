import 'package:Mobile/src/injector/injector.dart';
import 'package:Mobile/src/ui/login/login_page.dart';
import 'package:Mobile/src/ui/main/home_page/manage_attendance/manage_attendace.dart';
import 'package:Mobile/src/ui/main/home_page/manage_request/manage_request_page.dart';
import 'package:Mobile/src/ui/main/home_page/manage_task/manage_task_page.dart';
import 'package:Mobile/src/ui/main/home_page/manage_task/task_info/task_info_page.dart';
import 'package:Mobile/src/ui/main/main_page.dart';
import 'package:Mobile/src/ui/register/register_page.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await setupLocator();
    runApp(MyApp());
  } catch (err, stacktrace) {
    print('err: $err & $stacktrace');
  }
}

class MyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    '/': (context) => MainPage(),
    '/login': (context) => LoginPage(),
    '/register': (context) => RegisterPage(),
    '/managetask': (context) => ManageTaskPage(),
    '/manageattendance': (context) => ManageAttendance(),
    '/taskinfo': (context) => TaskInfoPage(),
    '/managerequest': (context) => ManageRequestPage(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: routes,
    );
  }
}
