import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo_application/app/data/databaseSQL.dart';
import 'package:todo_application/app/thems/themsCoustm.dart';

import 'app/modules/NotificationScreen/controllers/notification_screen_controller.dart';
import 'app/routes/app_pages.dart';

late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin1;

void main() async {
  await GetStorage.init();
  await db_connection_and_oprator().inilizeDataBase();
  WidgetsFlutterBinding.ensureInitialized();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('app_icon');
  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  flutterLocalNotificationsPlugin1 = flutterLocalNotificationsPlugin;
 WidgetsBinding.instance.addObserver(AppLifecycleObserver());
  runApp(MyApp());
}

class MyApp extends GetView<NotificationScreenController> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      themeMode: thems().currentthem,
      theme: thems.light,
      darkTheme: thems.dark,
    );
  }
}






class AppLifecycleObserver with WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.paused || state == AppLifecycleState.inactive) {
      DateTime  storedDate =DateTime.now().add(Duration(seconds: 50));

      if (storedDate != null) {

        DateTime now = DateTime.now();

        if (now.year == storedDate.year &&
            now.month == storedDate.month &&
            now.day == storedDate.day &&
            now.hour == storedDate.hour &&
            now.minute == storedDate.minute) {
        scheduleLocalNotification(now, flutterLocalNotificationsPlugin1);
        }
      }
    }
  }
    Future<void> scheduleLocalNotification(DateTime dateTime,
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var now = DateTime.now();
    var today = DateTime(now.year, now.month, now.day);

    if (true) {
      var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
        'your_channel_id',
        'your_channel_name',
        playSound: true,
        channelDescription: 'your_channel_description',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
      );

      var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
      );

      await flutterLocalNotificationsPlugin.show(
        0,
        'Today Event',
        'You have an event scheduled for today!',
        platformChannelSpecifics,
        payload: 'Today Event',
      );
    }
  }
}







