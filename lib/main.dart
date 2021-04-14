import 'package:flutter/material.dart';
import 'package:mediminder/models/userLocal.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mediminder/screens/wrapper.dart';
import 'package:mediminder/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelKey: 'basic',
          channelName: 'name',
          channelDescription: 'description',
          defaultColor: Color(0xFF9D50DD),
          ledColor: Colors.white
        )
      ]
  );
  AwesomeNotifications().isNotificationAllowed().then((isAllowed){
    if(!isAllowed){
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  }
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserLocal>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
