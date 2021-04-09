import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mediminder/Registropaciente2.0.dart';
import 'package:mediminder/XDRegistropaciente.dart';
import 'package:mediminder/models/userLocal.dart';
import 'package:mediminder/screens/authenticate/authenticate.dart';
import 'package:mediminder/screens/authenticate/sign_in.dart';
import 'package:mediminder/screens/home/home.dart';
import 'package:mediminder/services/database.dart';
import 'package:provider/provider.dart';
import 'home/inicio.dart';

class Wrapper extends StatelessWidget {
  String tipo;
  @override
  UserLocal userGlob;
  Widget build(BuildContext context) {
    //user para provider
    final user=Provider.of<UserLocal>(context);
    userGlob=user;

    // return either Home or Authentic widget
    if(user==null) {
      return Authenticate();
    }else{
      buscarTipo();
      if(userGlob.uid!=null) {
        print("inicio");
        print(userGlob.tipo);
        print(userGlob.uid);
        print("fin");
      }

      print(user.uid);
      if(tipo=="Supervisor"){
        print(user);
        return XDRegistropaciente();
      }
      else if(tipo=="Paciente"){
        print("paciente");
        return Registropaciente();
      }else{
        print("hpat");
        return Home();
      }
    }
  }

  void verificar(String t){
    this.tipo = t;
    return;
  }
  void buscarTipo() async{
    await FirebaseFirestore.instance.collection(
        "Usuarios").doc(userGlob.uid).get().then((value) => {verificar(value["tipo"])});
    print("tardeee");
  }
}
