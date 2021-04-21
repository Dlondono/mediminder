import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mediminder/models/medicamento.dart';
import 'package:mediminder/models/paciente.dart';
import 'package:mediminder/models/userLocal.dart';
import 'package:mediminder/screens/home/disenoMedicamento.dart';
import 'package:mediminder/services/database.dart';
import 'package:provider/provider.dart';

class Medicamentos extends StatefulWidget {
  final String id;
  Medicamentos({this.id});
  @override
  _MedicamentosState createState() => _MedicamentosState();
}

class _MedicamentosState extends State<Medicamentos> {

  final DatabaseService database=DatabaseService();
  final FirebaseAuth auth=FirebaseAuth.instance;
  
  @override
  Widget build(BuildContext context) {
    //final users= Provider.of<List<UserData>>(context)?? [];
    final medicamentos= Provider.of<List<Medicamento>>(context)?? [];
    final User user= auth.currentUser;
    final uid=user.uid;
    medicamentos.removeWhere((item) => item.idPaciente!=uid);
    
    return ListView.builder(
        itemCount: medicamentos.length,
        itemBuilder: (context,index) {
          return MedicamentoDiseno(medicamento: medicamentos[index]);
        }
    );
  }
}
