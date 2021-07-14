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
  final String id,tipo;
  Medicamentos(this.id,this.tipo);
  @override
  _MedicamentosState createState() => _MedicamentosState();
}

class _MedicamentosState extends State<Medicamentos> {
  final FirebaseAuth auth=FirebaseAuth.instance;
  DateTime horaActualLocal = tz.TZDateTime.now(tz.local);
  List<AlarmaMedicamento> alarmaLista = [];
  @override
  Widget build(BuildContext context) {
    final medicamentos= Provider.of<List<Medicamento>>(context)?? [];
    //final User user= auth.currentUser;
    final uid=widget.id;
    final String tipo=widget.tipo;
    alarmaLista = [];
    AlarmaMedicamento medi;
    medicamentos.removeWhere((item) => item.idPaciente!=uid);
    medicamentos.forEach((item) {
      if (item.periodo != null) {
        DateTime horaNueva = new DateTime(item.year,
            item.mes, item.dia, item.hora, item.minuto);
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
            hora: t,
            periodo: item.periodo,
            idPaciente: item.idPaciente,
            dosis: item.dosis,
            uid: item.uid,
            dia: item.dia,
            mes: item.mes,
            year: item.year,
            tipo: item.tipo,
            tipoHorario: item.tipoHorario,
            prioridad: item.prioridad,
            veces:item.veces,
        );
        alarmaLista.add(medi);

      } else if (item.listaHorasMed != null) {

         } else if (item.listaHorasMed != null) {

        List<String> listaHorasString,listaDiasString;
        DateTime t,now;
        now=DateTime.now();
        String horaString,diasString;
        horaString =item.listaHorasMed[0].toString().replaceAll(new RegExp(r'[^0-9,]'),'');
        listaHorasString=horaString.split(',');
        diasString=item.listaHorasMed[1].toString().replaceAll(new RegExp(r'[^0-9,]'),'');
        listaDiasString=diasString.split(',');
        int i=0;
        for(String horaList in listaHorasString) {
          int dia=int.parse(listaDiasString[i]);
          i++;
          t = DateTime.parse(item.year.toString() +
              item.mes.toString().padLeft(2, '0')
              + item.dia.toString().padLeft(2, '0') + " " + horaList[0] +
              horaList[1] + ":" + horaList[2] + horaList[3] + ":" + "00");
          if(t.isBefore(now.add(Duration(hours: 1)))){
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
          medi =
          new AlarmaMedicamento(medicamentoNombre: item.medicamentoNombre,
            descripcion: item.recomendacion,
            cantidad: item.cantidad,
            hora: t,
            //listaHoras: item.listaHorasMed,
            idPaciente: item.idPaciente,
            dosis: item.dosis,
            uid: item.uid,
            dia: dia,
            mes: item.mes,
            year: item.year,
          );
          alarmaLista.add(medi);
        }
      }else {
        return Container(
          child: Text("ERROR"),
        );
      }
      });
    alarmaLista.sort((alarmaA, alarmaB) => alarmaA.hora.isBefore(alarmaB.hora)? 0:1);

    //closestDate();
        return ListView.builder(
            itemCount: alarmaLista.length,
            itemBuilder: (context,index) {
              return MedicamentoDiseno(alarmaLista[index],tipo);
            }
        );
  }
  void closestDate(){
    DateTime today=DateTime.now();
    final closestDateTimeToNow= alarmaLista.reduce((a,b)=>
        a.hora.difference(today).abs() <b.hora.difference(today).abs()?a:b);
  }
}
