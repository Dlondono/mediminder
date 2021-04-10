import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mediminder/models/userLocal.dart';
import 'package:mediminder/screens/authenticate/sign_in.dart';
import 'package:mediminder/screens/home/InterfazSupervisor.dart';
import 'package:mediminder/screens/home/vistaPaciente.dart';
import 'package:mediminder/services/auth.dart';
import 'package:mediminder/services/database.dart';
import 'package:provider/provider.dart';


class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.hasData && snapshot.data != null) {
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