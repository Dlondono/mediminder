import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mediminder/models/paciente.dart';
import 'package:mediminder/screens/home/disenoMedicamento.dart';
import 'package:mediminder/services/database.dart';
import 'package:provider/provider.dart';

class Medicamentos extends StatefulWidget {
  @override
  _MedicamentosState createState() => _MedicamentosState();
}

class _MedicamentosState extends State<Medicamentos> {

  final DatabaseService database=DatabaseService();
  final FirebaseAuth auth=FirebaseAuth.instance;
  
  @override
  Widget build(BuildContext context) {
    final pacientes= Provider.of<List<Paciente>>(context)?? [];
    final User user= auth.currentUser;
    final uid=user.uid;
    pacientes.removeWhere((item) => item.id!=uid);

    return ListView.builder(
        itemCount: pacientes.length,
        itemBuilder: (context,index) {
          return MedicamentoDiseno(paciente: pacientes[index]);
        }
    );
  }
}
