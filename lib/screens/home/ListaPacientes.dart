import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mediminder/models/paciente.dart';
import 'package:mediminder/screens/home/disenoPaciente.dart';
import 'package:provider/provider.dart';
import '../../models/paciente.dart';
import 'package:mediminder/services/database.dart';
import '../../services/database.dart';

class Pacientes extends StatefulWidget {
  @override
  _PacientesState createState() => _PacientesState();
}

class _PacientesState extends State<Pacientes> {
  final DatabaseService database=DatabaseService();
  final FirebaseAuth auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final pacientes= Provider.of<List<Paciente>>(context)?? [];
    final User user= auth.currentUser;
    final uid=user.uid;
    pacientes.removeWhere((item) => item.idSuper!=uid);

    return ListView.builder(
      itemCount: pacientes.length,
      itemBuilder: (context,index) {
         return PacienteDiseno(paciente: pacientes[index]);
        }
    );
  }
}
