import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mediminder/models/medicamento.dart';
import 'package:mediminder/screens/home/listaMedicamentos.dart';
import 'package:mediminder/services/auth.dart';
import 'package:mediminder/services/database.dart';
import 'package:mediminder/services/local_noti.dart';
import 'package:provider/provider.dart';

class VistaPaciente extends StatefulWidget {
  @override
  _VistaPacienteState createState() => _VistaPacienteState();
}

class _VistaPacienteState extends State<VistaPaciente> {
  final FirebaseAuth auth=  FirebaseAuth.instance;
  final AuthService _auth=AuthService();
  @override
  Widget build(BuildContext context) {
  final User user=auth.currentUser;
  final String uid=user.uid;

  final CollectionReference coleccion = FirebaseFirestore.instance.collection("Usuarios");
        return StreamProvider<List<Medicamento>>.value(
          value: DatabaseService().medicamentos,
          child: Scaffold(
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
                    Expanded(child: Medicamentos()),
                    TextButton.icon(
                      icon: Icon(Icons.medical_services),
                      label: Text("Medicamentos"),
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all(Colors.black),
                      ),
                      onPressed:(){
                        final Notifications noti = new Notifications();
                        //noti.init();
                        //noti.setTime(2021, 4, 27, 17, 21);
                        //noti.scheduleweeklyNotification();
                        //noti.showNotification("Mi notif");
                        //noti.myTimedNotification();
                      },
                    ),
                  ],
                )
            ),
          ),
        );
      }
}
