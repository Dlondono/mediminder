import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mediminder/models/paciente.dart';
import 'package:mediminder/services/auth.dart';
import 'package:mediminder/services/database.dart';
import 'package:provider/provider.dart';
import 'package:mediminder/screens/home/ListaPacientes.dart';
import 'package:mediminder/screens/home/pacienteNuevo.dart';

import 'ListaPacientes.dart';

class Home extends StatelessWidget {
  final AuthService _auth=AuthService();
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Paciente>>.value(
      value: DatabaseService().pacientes,
      child: Scaffold(
        //backgroundColor: ,
        appBar: AppBar(
          title: Text("Mediminder supervisor"),
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
                Expanded(child: Pacientes()),


                TextButton.icon(
                  icon: Icon(Icons.person),
                  label: Text("Agregar"),
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(Colors.black),
                  ),

                  onPressed:(){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> PacienteNuevo()));

                  },
                )
              ],
            )

          ),
        ),
      );

  }
}