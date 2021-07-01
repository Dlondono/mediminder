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
  List<AlarmaMedicamento> alarmaLista = [];
  @override
  Widget build(BuildContext context) {
    //final users= Provider.of<List<UserData>>(context)?? [];
    final medicamentos= Provider.of<List<Medicamento>>(context)?? [];
    final User user= auth.currentUser;
    final uid=user.uid;
    alarmaLista = [];
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
        DateTime t,now;
        now=DateTime.now();
        t = DateTime.parse(item.year.toString() +
            item.mes.toString().padLeft(2, '0')
            + item.dia.toString().padLeft(2, '0') + " " + horaNueva.hour.toString().padLeft(2,'0')
            + ":" + horaNueva.minute.toString().padLeft(2,'0') + ":" + "00");
        if(t.isBefore(now)){
          item.dia =now.day;
          item.mes=now.month;
          t = DateTime.parse(item.year.toString() +
              item.mes.toString().padLeft(2, '0')
              + item.dia.toString().padLeft(2, '0') + " " + horaNueva.hour.toString().padLeft(2,'0')
              + ":" + horaNueva.minute.toString().padLeft(2,'0') + ":" + "00");
          if(t.isBefore(now)){
            item.dia=now.day+1;
            t = DateTime.parse(item.year.toString() +
                item.mes.toString().padLeft(2, '0')
                + item.dia.toString().padLeft(2, '0') + " " + horaNueva.hour.toString().padLeft(2,'0')
                + ":" + horaNueva.minute.toString().padLeft(2,'0') + ":" + "00");
            if(t.isBefore(now)){
              item.mes=now.month+1;
              t = DateTime.parse(item.year.toString() +
                  item.mes.toString().padLeft(2, '0')
                  + item.dia.toString().padLeft(2, '0') + " " + horaNueva.hour.toString().padLeft(2,'0')
                  + ":" + horaNueva.minute.toString().padLeft(2,'0') + ":" + "00");
            }
          }
        }
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
        List<String> listaHorasString;
        DateTime t,now;
        now=DateTime.now();
        String horaString;
        horaString =item.listaHorasMed.toString().replaceAll(new RegExp(r'[^0-9,]'),'');
        listaHorasString=horaString.split(',');
        for(String horaList in listaHorasString) {
          t = DateTime.parse(item.year.toString() +
              item.mes.toString().padLeft(2, '0')
              + item.dia.toString().padLeft(2, '0') + " " + horaList[0] +
              horaList[1] + ":" + horaList[2] + horaList[3] + ":" + "00");
          if(t.isBefore(now)){
            item.dia =now.day;
            item.mes=now.month;
            t = DateTime.parse(item.year.toString() +
                item.mes.toString().padLeft(2, '0')
                + item.dia.toString().padLeft(2, '0') + " " + horaList[0] +
                horaList[1] + ":" + horaList[2] + horaList[3] + ":" + "00");
            if(t.isBefore(now)){
              item.dia=now.day+1;
              t = DateTime.parse(item.year.toString() +
                  item.mes.toString().padLeft(2, '0')
                  + item.dia.toString().padLeft(2, '0') + " " + horaList[0] +
                  horaList[1] + ":" + horaList[2] + horaList[3] + ":" + "00");
              if(t.isBefore(now)){
                item.mes=now.month+1;
                t = DateTime.parse(item.year.toString() +
                    item.mes.toString().padLeft(2, '0')
                    + item.dia.toString().padLeft(2, '0') + " " + horaList[0] +
                    horaList[1] + ":" + horaList[2] + horaList[3] + ":" + "00");
              }
            }
          }
          mediH =
          new AlarmaMedicamento(medicamentoNombre: item.medicamentoNombre,
            descripcion: item.recomendacion,
            cantidad: item.cantidad,
            hora: t,
            //listaHoras: item.listaHorasMed,
            idPaciente: item.idPaciente,
            dosis: item.dosis,
            uid: item.uid,
            dia: item.dia,
            mes: item.mes,
            year: item.year,
          );
          alarmaLista.add(mediH);
        }
      }else {
        return Container(
          child: Text("ERROR"),
        );
      }
      print(alarmaLista.length);
    });
        alarmaLista.sort((alarmaA, alarmaB) => alarmaA.hora.isBefore(alarmaB.hora) ? 0:1);
        closestDate();
        return ListView.builder(
            itemCount: alarmaLista.length,
            itemBuilder: (context,index) {
              return MedicamentoDiseno(medicamento: alarmaLista[index]);
            }
        );
  }
  void closestDate(){
    DateTime today=DateTime.now();
    final closestDateTimeToNow= alarmaLista.reduce((a,b)=>
        a.hora.difference(today).abs() <b.hora.difference(today).abs()?a:b);
    print(closestDateTimeToNow.hora.hour);
    print("wtf");
  }
}
