import 'package:flutter/material.dart';
import 'package:mediminder/screens/home/listaMedicamentos.dart';
import 'package:mediminder/services/auth.dart';
import 'package:mediminder/main.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mediminder/services/notificacion.dart';
class VistaPaciente extends StatefulWidget {
  @override
  _VistaPacienteState createState() => _VistaPacienteState();
}

class _VistaPacienteState extends State<VistaPaciente> {
  FlutterLocalNotificationsPlugin localNotification;
  final AuthService _auth=AuthService();
  Future showNotification() async{
    var androidDetails =new AndroidNotificationDetails(
        "channelId", "channelName", "Descripcion de la notificacion",
        importance: Importance.max,
        priority: Priority.high);
    var notificationDetails=new NotificationDetails(android: androidDetails);
    await localNotification.show(0, "Titulo icono", "body",
        notificationDetails,payload: 'test');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: ,
      appBar: AppBar(
        title: Text("Mediminder paciente"),
        backgroundColor: Colors.blue,
        actions: <Widget>[
          TextButton.icon(
            icon: Icon(Icons.person),
            label: Text("Salir"),
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(Colors.black),
            ),
            onPressed: ()async{
              await _auth.signOut();
            },
          )
        ],
      ),
      body: Container(
          child: Column(
            children: <Widget>[
              //Expanded(child: Medicamentos()),
              TextButton.icon(
                icon: Icon(Icons.medical_services),
                label: Text("Medicamentos"),
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(Colors.black),
                ),

                onPressed:(){

                  Navigator.push(context, MaterialPageRoute(builder: (context)=> Notificacion()));
                },
              )
            ],
          )

      ),
    );
  }
}
