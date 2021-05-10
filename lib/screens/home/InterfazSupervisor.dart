import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mediminder/models/paciente.dart';
import 'package:mediminder/services/auth.dart';
import 'package:mediminder/services/database.dart';
import 'package:provider/provider.dart';
import 'package:mediminder/screens/home/ListaPacientes.dart';
import 'package:mediminder/screens/home/pacienteNuevo.dart';
import '../../services/auth.dart';
import 'ListaPacientes.dart';

class InterfazSupervisor extends StatelessWidget {
  final AuthService _auth=AuthService();
  final FirebaseAuth auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final User user= auth.currentUser;
    final uid=user.uid;
    return StreamProvider<List<Paciente>>.value(
      value: DatabaseService().pacientes,
      child: Scaffold(
        //backgroundColor: ,
        appBar: AppBar(
          title: Text("Mediminder supervisor"),
          backgroundColor: Color.fromRGBO(9, 111, 167, 50),
          actions: <Widget>[
            TextButton.icon(
              icon: Icon(Icons.person),
              label: Text("Salir"),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color.fromRGBO(9, 111, 167, 50)),
                foregroundColor: MaterialStateProperty.all(Colors.black),
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
                Expanded(child: Pacientes()),
                TextButton.icon(
                  icon: Icon(Icons.person,color: Colors.white,),
                  label: Text("Agregar nuevo paciente",style: TextStyle(
                    color: Colors.white,
                    ),
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Color.fromRGBO(9, 111, 167, 50)),
                      foregroundColor: MaterialStateProperty.all(Colors.black),
                    ),
                  onPressed:(){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> PacienteNuevo()));
                  },
                )
              ],
            ),
          ),
        ),
      );

  }
}