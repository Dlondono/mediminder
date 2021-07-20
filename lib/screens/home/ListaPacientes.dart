import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mediminder/models/paciente.dart';
import 'package:mediminder/screens/home/disenoPaciente.dart';
import 'package:mediminder/shared/loading.dart';
import 'package:provider/provider.dart';
import '../../models/paciente.dart';
import 'package:mediminder/services/database.dart';
import '../../services/database.dart';

class Pacientes extends StatefulWidget {
  final String uid;
  Pacientes(this.uid);
  @override
  _PacientesState createState() => _PacientesState();
}

class _PacientesState extends State<Pacientes> {
  bool loading=false;
  final DatabaseService database=DatabaseService();
  final FirebaseAuth auth=FirebaseAuth.instance;
  List<Paciente> pacientes,pacs;
  Future getPacientes()async{
    setState(()=>loading=true);
    pacs=await database.queryPacientes(widget.uid);
    if(this.mounted) {
      setState(() {
        pacientes = pacs;
        loading=false;
      });
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPacientes();
  }
  @override
  Widget build(BuildContext context) {
    //final pacientes= Provider.of<List<Paciente>>(context)?? [];
    final User user= auth.currentUser;
    final uid=user.uid;
    //pacientes.removeWhere((item) => item.idSuper!=uid);

    return loading? Loading(): ListView.builder(
      itemCount: pacientes.length,
      itemBuilder: (context,index) {
         return PacienteDiseno(paciente: pacientes[index]);
        }
    );
  }
}
