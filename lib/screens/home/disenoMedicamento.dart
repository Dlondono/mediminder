import 'package:flutter/material.dart';
import 'package:mediminder/models/medicamento.dart';
import 'package:mediminder/screens/home/detallesMedicamento.dart';
import 'package:mediminder/services/local_noti.dart';
import 'package:sizer/sizer.dart';

class MedicamentoDiseno extends StatelessWidget {
  DateTime t;
  final Medicamento medicamento;
  final Notifications noti = new Notifications();
  MedicamentoDiseno({this.medicamento});
  int hora;
  int minuto;
  int dia;
  String formato = "am";
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
        if(hora+medicamento.periodo<=23) {
          hora = hora + medicamento.periodo;
        }
        else{
          int cstn = 24-hora;
          int c = medicamento.periodo - cstn;
          hora = c;
          t = t.add(const Duration(days: 1));
        }}
    }
    medicamento.setTime(hora, minuto);
    noti.setTime(t.year, t.month, t.day,hora,minuto);
    noti.scheduleweeklyNotification(medicamento.idPaciente,medicamento.medicamentoNombre,medicamento.recomendacion);
    noti.myTimedNotification(medicamento.medicamentoNombre,medicamento.recomendacion,medicamento.periodo);

    if(hora>12){
      hora = hora - 12;
      formato = "pm";
    }
    if(hora==12){
      formato = "pm";
    }
    if(hora==0){
      hora = 12;
      formato = "am";
    }
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.0.h, horizontal: 1.0.h),
      child: GestureDetector(//padding
        onTap: (){
            Navigator.push(context, MaterialPageRoute(
                builder: (context)=> detallesMedicamento(medicamento:medicamento)));
          },
        child: Card(
          color: Color.fromRGBO(255, 255, 255, 50),
          margin: EdgeInsets.symmetric(vertical: 1.0.h, horizontal: 3.0.h),
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text("Medicamento: " +medicamento.medicamentoNombre,
                  style: TextStyle(fontSize: 20,color: Colors.black)),
                subtitle: Text("Cantidad disponible: " + medicamento.cantidad.toString()
                    + "\n" + "Dosis a tomar: " + medicamento.dosis.toString(),
                  style: TextStyle(fontSize: 18,color: Colors.black)) ,
                ),
              TextButton.icon(
                icon: Icon(Icons.medical_services),
                label: Text("Hora de medicamento: " + hora.toString() +
                    ":" + minuto.toString() + " " + formato),
                  style: ButtonStyle(
                    textStyle: MaterialStateProperty.all(TextStyle(fontSize: 18,color: Colors.black)),
                    foregroundColor: MaterialStateProperty.all(Colors.black),
                  ),
                onPressed: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context)=>
                          detallesMedicamento(medicamento: medicamento,)));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
