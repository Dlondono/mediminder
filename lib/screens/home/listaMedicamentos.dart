import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mediminder/models/alarmaMedicamento.dart';
import 'package:mediminder/models/medicamento.dart';
import 'package:mediminder/models/paciente.dart';
import 'package:mediminder/models/userLocal.dart';
import 'package:mediminder/screens/home/disenoMedicamento.dart';
import 'package:mediminder/services/database.dart';
import 'package:provider/provider.dart';
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
  DateTime horaActualLocal = tz.TZDateTime.now(tz.local);
  @override
  Widget build(BuildContext context) {
    //final users= Provider.of<List<UserData>>(context)?? [];
    final medicamentos= Provider.of<List<Medicamento>>(context)?? [];
    final User user= auth.currentUser;
    final uid=user.uid;
    List<AlarmaMedicamento> alarmaLista = [];
    AlarmaMedicamento medi;
    AlarmaMedicamento mediH;
    medicamentos.removeWhere((item) => item.idPaciente!=uid);
    medicamentos.forEach((item) {
      if (item.periodo != null) {
        DateTime horaNueva = new DateTime(item.year,
            item.mes, item.dia, item.hora, item.minuto);
        if (horaNueva.isBefore(horaActualLocal)) {
          while (horaActualLocal.hour > horaNueva.hour &&
              horaActualLocal.day == horaNueva.day) {
            horaNueva = horaNueva.add(Duration(hours: item.periodo));
            if (horaActualLocal.day > horaNueva.day) {
              horaNueva.add(Duration(days: 1));
            }
          }
        }
        if (horaActualLocal.hour == horaNueva.hour &&
            horaActualLocal.minute > horaNueva.minute) {
          horaNueva = horaNueva.add(Duration(hours: item.periodo));
        }
        print("BBBBBBBBBBBBBBBBBBB");
        print(item.periodo.toString()+"periodo");
        print(item.listaHorasMed.toString()+"");
        print(item.hora);
        print("BBBBBBBBBBBBBBBBB");

        medi = new AlarmaMedicamento(medicamentoNombre: item.medicamentoNombre,
            descripcion: item.recomendacion,
            cantidad: item.cantidad,
            hora: horaNueva,
            periodo: item.periodo,
            idPaciente: item.idPaciente,
            dosis: item.dosis,
            uid: item.uid,
            dia: item.dia,
            mes: item.mes,
            year: item.year,
        );
        alarmaLista.add(medi);
      } else if (item.listaHorasMed != null) {
        print("AAAAAAAAAAAAAAA");
        print(item.periodo.toString()+"periodo");
        print(item.listaHorasMed.toString()+"");
        print(item.medicamentoNombre);
        print(item.year);
        print("AAAAAAAAAAAAAAA");
        mediH = new AlarmaMedicamento.horas(medicamentoNombre: item.medicamentoNombre,
            descripcion: item.recomendacion,
            cantidad: item.cantidad,
            listaHoras: item.listaHorasMed,
            idPaciente: item.idPaciente,
            dosis: item.dosis,
            uid: item.uid,
            dia: item.dia,
            mes: item.mes,
            year: item.year,
        );
        print(medi.year.toString()+"YEAR STRING MEDI");
        print(item.listaHorasMed);
        alarmaLista.add(mediH);
        print(alarmaLista.length);
      } else {
        return Container(
          child: Text("no hora"),
        );
      }
    });
        //alarmaLista.sort((alarmaA, alarmaB) => alarmaA.hora.isBefore(alarmaB.hora) ? 0:1);
        return ListView.builder(
            itemCount: alarmaLista.length,
            itemBuilder: (context,index) {
              return MedicamentoDiseno(medicamento: alarmaLista[index]);
            }
        );
  }
}
