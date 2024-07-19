import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:uroutines/services/background.dart';
import 'package:uroutines/utility/db.dart';
import 'screens/welcomescreen.dart';

DateTime today = DateTime.now();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DbHelper.initDb();
  await GetStorage.init();
  await initializeService();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'uRoutines',
      theme: ThemeData(
        primaryColor: const Color(0xFF202328),
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(secondary: const Color(0xFF63CF93))
            .copyWith(background: const Color(0xFF12171D)),
      ),
      home: WelcomeScreen(),
    );
  }
}
