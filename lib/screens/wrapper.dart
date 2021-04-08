import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mediminder/models/userLocal.dart';
import 'package:mediminder/screens/authenticate/authenticate.dart';
import 'package:mediminder/screens/home/home.dart';
import 'package:mediminder/services/database.dart';
import 'package:provider/provider.dart';
import 'home/inicio.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //user para provider
    final user=Provider.of<UserLocal>(context);

    // return either Home or Authentic widget
    if(user==null) {
      return Authenticate();
    }else{
      //print(userD.tipo);
      //print(userD.uid);
      return Home();
    }
  }
}
