import 'dart:math';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'dart:developer' as dev;

class Notifications {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  new FlutterLocalNotificationsPlugin();
  int aYear;
  int aMonth;
  int aDay;
  int aHour;
  int aMin;
  setTime(int year, int month, int day, int hour, int min) {
    aYear = year;
    aMonth = month;
    aDay = day;
    aHour = hour;
    aMin = min;
    var alarmDate = aYear.toString() +
        "," +
        aMonth.toString() +
        "," +
        aDay.toString() +
        "," +
        aHour.toString() +
        ":" +
        aMin.toString();
    dev.log('alarm Date:$alarmDate');
  }

  init() async {
    final String currentTimeZone =
    await FlutterNativeTimezone.getLocalTimezone();
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    // ignore: todo
    //TODO:iosConfig
    //const IOSInitializationSettings()
    final InitializationSettings initializationSettings =
    InitializationSettings(
      android: initializationSettingsAndroid,
      //IOS
      ////MACOS
    );
    this.flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> showNotification(String title) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      "Your channel",
      "channel name",
      "channel description",
      priority: Priority.max,
      importance: Importance.max,
    );
    //Channel IOS
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );
    await this
        .flutterLocalNotificationsPlugin
        .show(0, title, "Notificación inmediata", platformChannelSpecifics
      //Payload es lo que se ejecuta al recibir clickear la notificación
    );
  }

  Future<void> myTimedNotification(int s) async {
    final details = NotificationDetails(
      android: AndroidNotificationDetails("id", "name", "description",
          priority: Priority.max, importance: Importance.max),
    );
    final tz.TZDateTime now = localTime();
    tz.TZDateTime scheduleDate = now.add(Duration(seconds: 5));
    await this.flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      "Notificación de tiempo",
      "5 segundos",
      scheduleDate,
      details,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
    );
  }

  tz.TZDateTime localTime(){
    return tz.TZDateTime.now(tz.local);
  }

  Future<void> scheduleweeklyNotification(String id,String name,String description) async {
    var random= new Random();
    var idR=random.nextInt(50);
    final details = NotificationDetails(
      android: AndroidNotificationDetails("id", "name", "description",
          priority: Priority.max, importance: Importance.max),
    );
    await this.flutterLocalNotificationsPlugin.zonedSchedule(
      idR,
      name,
      description,
      _nextinstanceOfDay(),
      details,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
    );
    print(idR);
  }

  tz.TZDateTime _nextinstanceOfDay() {
    tz.TZDateTime scheduleDate = _nextInstanceofTime();
    return scheduleDate;
  }

  _nextInstanceofTime() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduleDate =
    tz.TZDateTime(tz.local, aYear, aMonth, aDay, aHour, aMin);

//SI el día ya pasó
    if (scheduleDate.isBefore(now)) {
      scheduleDate = scheduleDate.add(Duration(days: 1));
    }
    return scheduleDate;
  }
}
