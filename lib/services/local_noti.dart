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
  Future<void> cancelarNotificaciones()async{
    await flutterLocalNotificationsPlugin.cancelAll();
  }
  Future<void> notiActivas()async{
   /* final List<ActiveNotification> activeNotifications=
        await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
    AndroidFlutterLocalNotificationsPlugin>()?.getActiveNotifications();
    print(activeNotifications.toString());
    */
    final List<PendingNotificationRequest> pending=
        await flutterLocalNotificationsPlugin.pendingNotificationRequests();
    for(var noti in pending) {
      print(noti.title);
    }
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
    this.flutterLocalNotificationsPlugin.initialize(
        initializationSettings);
  }

  Future<void> showNotification(String title,String medi) async {
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
        .show(0, title, medi, platformChannelSpecifics,
      //Payload es lo que se ejecuta al recibir clickear la notificación
    );
  }

  Future<void> myTimedNotification(String nombre, String descripcion, int p) async {
    final details = NotificationDetails(
      android: AndroidNotificationDetails("id", "name", descripcion,playSound: true,
          priority: Priority.max, importance: Importance.max),
    );
    final tz.TZDateTime now = new tz.TZDateTime(tz.local, aYear, aMonth, aDay, aHour, aMin);
    tz.TZDateTime scheduleDate = now.add(Duration(hours : p));
    await this.flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      nombre,
      descripcion,
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
    var bigTextStyleInformation=BigTextStyleInformation(description);
    final details = NotificationDetails(
      android: AndroidNotificationDetails("id", "name", "description",
          priority: Priority.max,
          importance: Importance.max,
          styleInformation:bigTextStyleInformation ),
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
  }

  tz.TZDateTime _nextinstanceOfDay() {
    tz.TZDateTime scheduleDate = _nextInstanceofTime();
    return scheduleDate;
  }

  _nextInstanceofTime() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduleDate =
    tz.TZDateTime(tz.local, aYear, aMonth, aDay, aHour, aMin);

    return scheduleDate;
  }
}
