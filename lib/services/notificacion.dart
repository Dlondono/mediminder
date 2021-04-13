import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Notificacion extends StatefulWidget {
  @override
  _NotificacionState createState() => _NotificacionState();
}

class _NotificacionState extends State<Notificacion> {
  FlutterLocalNotificationsPlugin localNotification;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var androidInitialize=new AndroidInitializationSettings('ic_launcher');
    var initializationSettings=new InitializationSettings(android: androidInitialize);
    localNotification=new FlutterLocalNotificationsPlugin();
    localNotification.initialize(initializationSettings);
  }

  Future _showNotification() async{
    var androidDetails =new AndroidNotificationDetails(
        "channelId", "channelName", "Descripcion de la notificacion",
        importance: Importance.max,
        priority: Priority.high);
    var notificationDetails=new NotificationDetails(android: androidDetails);
    await localNotification.show(0, "Titulo", "body",
        notificationDetails,payload: 'test');

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("click para notificacion"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.alarm),
        onPressed: _showNotification,
      ),
    );
  }
}
