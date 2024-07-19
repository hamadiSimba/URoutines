import 'dart:async';
import 'dart:ui';
import 'package:get/get.dart';
import 'package:uroutines/services/notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import '../model/sessions.dart';
import '../utility/db.dart';

Future<void> initializeService() async {
  final service = FlutterBackgroundService();
  await service.configure(
    iosConfiguration: IosConfiguration(
      autoStart: true,
      onForeground: onStart,
      onBackground: iosOnBackground,
    ),
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      isForegroundMode: true,
      autoStart: true,
    ),
  );
}

@pragma("vm:entry-point")
Future<bool> iosOnBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  return true;
}

List<Sessions> allModules = [];
DateTime leo = DateTime.now();
DateTime fixedtoday = DateTime.now();
int tomorrow = DateTime.now().day + 1;
int counter = 0;
int dayList = 0;
int day = 0;
final _notifyHelper = Get.put(NotifyHelper());

@pragma("vm:entry-point")
void onStart(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  await DbHelper.initDb();
  await GetStorage.init();
  refreshModules();

  service.on("refreshSession").listen((event) {
    refreshModules();
  });

  Timer.periodic(const Duration(seconds: 1), (timer) {
    leo = DateTime.now();
    fixedtoday = DateTime.now();

    Map<String, dynamic> data = {
      'today': leo.toString(),
    };

    service.invoke("updateTime", data);

    if (tomorrow == leo.day) {
      refreshModules();
      tomorrow = leo.day + 1;
    }

    for (int i = 0; i < allModules.length; i++) {
      if (fixedtoday
              .difference(DateTime.parse(
                  "${DateTime.now().year}-${changeDate(DateTime.now().month)}-${changeDate(dayList)} ${allModules[i].startTime!}"))
              .inMinutes ==
          0) {
        if (counter == 0) {
          _notifyHelper.showNotification(
              id: allModules[i].id!,
              title: "Session (by ${allModules[i].courseLecturer}):",
              body:
                  "${allModules[i].courseName} (${allModules[i].courseCode}) is started!");
          runApp(NotifyScreen());
          counter++;
        }
      } else if (fixedtoday
              .difference(DateTime.parse(
                  "${DateTime.now().year}-${changeDate(DateTime.now().month)}-${changeDate(dayList)} ${allModules[i].startTime!}"))
              .inMinutes ==
          5) {
        counter = 0;
      }
    }
  });
}

refreshModules() async {
  List<Sessions> x = await DbHelper.sessionsQuery(DateFormat.E().format(leo));
  allModules = x;
  dayList = leo.day;
}

String changeDate(int num) {
  if (num > 9) {
    return "$num";
  } else {
    return "0$num";
  }
}

class NotifyScreen extends StatelessWidget {
  NotifyScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'uRoutines',
      theme: ThemeData(
        primaryColor: const Color(0xFF202328),
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(secondary: const Color(0xFF63CF93))
            .copyWith(background: const Color(0xFF12171D)),
      ),
      home: Scaffold(
        body: Container(
          height: 420,
          width: 200.0,
          color: Colors.white,
          child: const Center(
            child: Text("Session Started!"),
          ),
        ),
      ),
    );
  }
}
