import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class Pacientes extends StatefulWidget {
  @override
  _PacientesState createState() => _PacientesState();
}

class _PacientesState extends State<Pacientes> {
  @override
  Widget build(BuildContext context) {
    final pacientes= Provider.of<QuerySnapshot>(context);
    //print(pacientes.docs);
    for(var doc in pacientes.docs){
      print(doc.data());
    }
    return Container(

    );
  }
}
