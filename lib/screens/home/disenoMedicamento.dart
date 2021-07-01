import 'package:flutter/material.dart';
import 'package:mediminder/models/alarmaMedicamento.dart';
import 'package:mediminder/models/medicamento.dart';
import 'package:mediminder/screens/home/detallesMedicamento.dart';
import 'package:mediminder/services/local_noti.dart';
import 'package:sizer/sizer.dart';

class MedicamentoDiseno extends StatelessWidget {
  final AlarmaMedicamento medicamento;
  int hora;
  final Notifications noti = new Notifications();
  MedicamentoDiseno({this.medicamento});
  String formato = "am";
  @override
  Widget build(BuildContext context) {
    noti.cancelarNotificaciones();
    if(medicamento.listaHoras==null) {
      noti.setTime(
          medicamento.year, medicamento.mes, medicamento.dia,
          medicamento.hora.hour, medicamento.hora.minute);
      noti.scheduleweeklyNotification(
          medicamento.idPaciente, medicamento.medicamentoNombre,
          medicamento.descripcion);
      hora = medicamento.hora.hour;

      if (hora > 12) {
        hora = hora - 12;
        formato = "pm";
      }
      if (hora == 12) {
        formato = "pm";
      }
      if (hora == 0) {
        hora = 12;
        formato = "am";
      }
    }else{
      print("YA NO ENTRO ACA");
      List<String> listaHorasString;
      String horaString;
      DateTime t;
      horaString =medicamento.listaHoras.toString().replaceAll(new RegExp(r'[^0-9,]'),'');
      listaHorasString=horaString.split(',');
      for(String horaList in listaHorasString){
        t=DateTime.parse(medicamento.year.toString()+medicamento.mes.toString().padLeft(2,'0')
            +medicamento.dia.toString().padLeft(2,'0')+" "+horaList[0]+horaList[1]+":"+horaList[2]+horaList[3]+":"+"00");

        medicamento.setTime(t);
        noti.setTime(
            medicamento.year, medicamento.mes, medicamento.dia,
            t.hour, t.minute);
        noti.scheduleweeklyNotification(
            medicamento.idPaciente, medicamento.medicamentoNombre,
            medicamento.descripcion);
      }
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
                title: Text(medicamento.dia.toString()+"Medicamento: " +medicamento.medicamentoNombre,
                  style: TextStyle(fontSize: 20,color: Colors.black)),
                subtitle: Text("Cantidad disponible: " + medicamento.cantidad.toString()
                    + "\n" + "Dosis a tomar: " + medicamento.dosis.toString(),
                  style: TextStyle(fontSize: 18,color: Colors.black)) ,
                ),
              TextButton.icon(
                icon: Icon(Icons.medical_services),
                label: Text("Hora de medicamento: " + medicamento.hora.hour.toString() +
                    ":" + medicamento.hora.minute.toString().padLeft(2,'0') + " " ),
                  style: ButtonStyle(
                    textStyle: MaterialStateProperty.all(TextStyle(fontSize: 18,color: Colors.black)),
                    foregroundColor: MaterialStateProperty.all(Colors.black),
                  ),
                onPressed: (){
                  noti.notiActivas();
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
