import 'package:flutter/material.dart';
import 'package:mediminder/models/medicamento.dart';
import 'package:mediminder/services/local_noti.dart';

class MedicamentoDiseno extends StatelessWidget {
  DateTime t;
  final Medicamento medicamento;
  final Notifications noti = new Notifications();
  MedicamentoDiseno({this.medicamento});
  int hora;
  int minuto;
  int dia;
  @override
  Widget build(BuildContext context) {
    t=noti.localTime();
    hora = medicamento.hora;
    minuto = medicamento.minuto;
    dia = t.day;
    while(t.hour>hora && dia==t.day){
      if(hora+medicamento.periodo<=23) {
        hora = hora + medicamento.periodo;
      }
      else{
        int cstn = 24-hora;
        int c = medicamento.periodo - cstn;
        hora = c;
        t = t.add(const Duration(days: 1));
      }
    }

    if(hora == t.hour){
      if(t.minute>minuto){
        hora = hora + medicamento.periodo;
      }
    }
    noti.setTime(t.year, t.month, t.day,hora,minuto);
    noti.scheduleweeklyNotification(medicamento.idPaciente,medicamento.medicamentoNombre,medicamento.idPaciente);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.0,horizontal: 20.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: Column(
          children: <Widget>[
            ListTile(
              leading: Icon( //imagen medicamento?
                  Icons.person
              ),
              title: Text("Medicamento: " +medicamento.medicamentoNombre),
              subtitle: Text("Cantidad disponible: " + medicamento.cantidad.toString()),

            ),
            TextButton.icon(
              icon: Icon(Icons.medical_services),
              label: Text("Hora de toma de medicamento: " + hora.toString() + ":" + minuto.toString()),
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(Colors.black),
              ),
              onPressed: (){
              },
            ),
          ],
        ),
      ),
    );
  }
}
