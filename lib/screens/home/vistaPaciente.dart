import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mediminder/models/medicamento.dart';
import 'package:mediminder/screens/home/listaMedicamentos.dart';
import 'package:mediminder/services/auth.dart';
import 'package:mediminder/services/database.dart';
import 'package:mediminder/services/local_noti.dart';
import 'package:provider/provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class VistaPaciente extends StatefulWidget {
  @override
  _VistaPacienteState createState() => _VistaPacienteState();
}

class _VistaPacienteState extends State<VistaPaciente> {
  final FirebaseAuth auth=  FirebaseAuth.instance;
  final AuthService _auth=AuthService();
  final Notifications noti=new Notifications();
  @override
  Widget build(BuildContext context) {
    noti.cancelarNotificaciones();
    final User user=auth.currentUser;
  final String uid=user.uid;
  final CollectionReference coleccion = FirebaseFirestore.instance.collection("Usuarios");
        return Scaffold(
            //backgroundColor: Colors.blue[300],
            appBar: AppBar(
              elevation: 15,
              title: Text("Lista de medicamentos"),
              backgroundColor: Color.fromRGBO(9, 111, 167, 50),
              actions: <Widget>[
                TextButton.icon(
                  icon: Icon(Icons.person),
                  label: Text("Salir"),
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  onPressed: ()async{
                    await _auth.signOut();
                  },
                )
              ],
            ),
            body: Container(
                decoration: BoxDecoration(color: Color.fromRGBO(157, 221, 234, 50)),
                child: Column(
                  children: <Widget>[
                    Expanded(child: Medicamentos(uid,"paciente")),
                  ],
                )
            ),
        );
      }
}
