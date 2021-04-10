import 'package:flutter/material.dart';
import 'package:mediminder/screens/home/listaMedicamentos.dart';
import 'package:mediminder/services/auth.dart';

class VistaPaciente extends StatefulWidget {
  @override
  _VistaPacienteState createState() => _VistaPacienteState();
}

class _VistaPacienteState extends State<VistaPaciente> {

  final AuthService _auth=AuthService();
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

                },
              )
            ],
          )

      ),
    );
  }
}
