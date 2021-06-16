import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mediminder/screens/authenticate/sign_in.dart';
import 'package:mediminder/screens/home/InterfazSupervisor.dart';
import 'package:mediminder/screens/home/vistaPaciente.dart';
import 'package:mediminder/services/auth.dart';
import 'package:mediminder/services/database.dart';

class Home extends StatelessWidget {
  final FirebaseAuth auth=FirebaseAuth.instance;
  FirebaseMessaging messaging;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.hasData && snapshot.data != null) {
            messaging = FirebaseMessaging.instance;
            messaging.getToken().then((value) async =>
            {
              await DatabaseService(uid:auth.currentUser.uid).addToken(value)
            }
            );
            return StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance.collection("Usuarios").doc(snapshot.data.uid).snapshots() ,
              builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
                if(snapshot.hasData && snapshot.data != null) {
                  final userDoc = snapshot.data;
                  final user = userDoc.data();
                  if(user['tipo'] == 'Supervisor') {
                    print("supervisor");
                    return InterfazSupervisor();
                  }else{
                    print("paciente");
                    return VistaPaciente();
                  }
                }else{
                  return Material(
                    child: Center(child: CircularProgressIndicator(),),
                  );
                }
              },
            );
          }
          return SignIn();
        }
    );
  }
}