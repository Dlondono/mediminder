import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mediminder/models/userLocal.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mediminder/screens/wrapper.dart';
import 'package:mediminder/services/auth.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

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
class notificacionMain extends StatefulWidget {
  @override
  _notificacionMainState createState() => _notificacionMainState();
}

class _notificacionMainState extends State<notificacionMain> {

  FlutterLocalNotificationsPlugin localNotification;
  void initState() {
    // TODO: implement initState
    super.initState();
    var androidInitialize=new AndroidInitializationSettings('ic_launcher');
    var initializationSettings=new InitializationSettings(android: androidInitialize);
    localNotification=new FlutterLocalNotificationsPlugin();
    localNotification.initialize(initializationSettings);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("click para notificacion"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.alarm),

      ),
    );
  }
}

