import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mediminder/models/alarmaMedicamento.dart';
import 'package:mediminder/models/medicamento.dart';
import 'package:mediminder/models/paciente.dart';
import 'package:mediminder/models/userLocal.dart';
import 'package:mediminder/screens/home/disenoMedicamento.dart';
import 'package:mediminder/services/database.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;


class Medicamentos extends StatefulWidget {
  final String id;
  Medicamentos({this.id});
  @override
  _MedicamentosState createState() => _MedicamentosState();
}

class _MedicamentosState extends State<Medicamentos> {
  final DatabaseService database=DatabaseService();
  final FirebaseAuth auth=FirebaseAuth.instance;
  DateTime t = tz.TZDateTime.now(tz.local);
  @override
  Widget build(BuildContext context) {
    //final users= Provider.of<List<UserData>>(context)?? [];
    final medicamentos= Provider.of<List<Medicamento>>(context)?? [];
    final User user= auth.currentUser;
    final uid=user.uid;
    List<AlarmaMedicamento> alarmaLista = [];
    AlarmaMedicamento medi;
    medicamentos.removeWhere((item) => item.idPaciente!=uid);
    medicamentos.forEach((item) {
      DateTime horaNueva = new DateTime(t.year,t.month,t.day,item.hora,item.minuto);
      while(t.hour>horaNueva.hour && t.day==horaNueva.day){
            horaNueva = horaNueva.add(Duration(hours: item.periodo));
      }
      if(t.hour==horaNueva.hour && t.minute>horaNueva.minute){
        horaNueva = horaNueva.add(Duration(hours: item.periodo));
      }
     medi = new AlarmaMedicamento(medicamentoNombre:item.medicamentoNombre,
         descripcion:item.recomendacion,cantidad:item.cantidad,hora:horaNueva,
         periodo:item.periodo,idPaciente:item.idPaciente,dosis: item.dosis,uid: item.uid,
       dia: item.dia,mes: item.mes,year: item.year
     );
     alarmaLista.add(medi);
    });
    alarmaLista.sort((alarmaA, alarmaB) => alarmaA.hora.isBefore(alarmaB.hora) ? 0:1);

    return ListView.builder(
        itemCount: alarmaLista.length,
        itemBuilder: (context,index) {
          return MedicamentoDiseno(medicamento: alarmaLista[index]);
        }
    );
  }
}
