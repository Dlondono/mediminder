import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mediminder/models/paciente.dart';
import 'package:mediminder/screens/home/disenoPaciente.dart';
import 'package:provider/provider.dart';

class Pacientes extends StatefulWidget {
  @override
  _PacientesState createState() => _PacientesState();
}

class _PacientesState extends State<Pacientes> {
  @override
  Widget build(BuildContext context) {
    final pacientes= Provider.of<List<Paciente>>(context)?? [];

    return ListView.builder(
      itemCount: pacientes.length,
      itemBuilder: (context,index){
        return PacienteDiseno(paciente: pacientes[index]);
      },
    );
  }
}
