import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mediminder/models/alarmaMedicamento.dart';
import 'package:mediminder/models/medicamento.dart';
import 'package:mediminder/screens/home/detallesMedicamento.dart';
import 'package:mediminder/screens/home/editarMedicamento.dart';
import 'package:mediminder/services/database.dart';
import 'package:mediminder/services/local_noti.dart';
import 'package:sizer/sizer.dart';

class MedicamentoDiseno extends StatelessWidget {
  final AlarmaMedicamento medicamento;
  final String rol;
  int hora;
  final Notifications noti = new Notifications();
  MedicamentoDiseno(this.medicamento,this.rol);
  String formato = "am";
  final FirebaseAuth auth=  FirebaseAuth.instance;
  final DatabaseService _database=DatabaseService();
  @override
  Widget build(BuildContext context) {
    final User user=auth.currentUser;
      noti.cancelarNotificaciones();
      if (medicamento.listaHoras == null) {
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
      }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.0.h, horizontal: 1.0.h),
      child: GestureDetector(//padding
        onTap: (){
          if(rol=="paciente") {
            Navigator.push(context, MaterialPageRoute(
                builder: (context) =>
                    detallesMedicamento(medicamento: medicamento)));
          }else{
            //_database.queryMedicamentos(medicamento.idPaciente);
            Navigator.push(context, MaterialPageRoute(
                builder: (context) =>
                    editarMedicamento(medicamento: medicamento)));
          }
            },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
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
                label: Text("Hora de medicamento: " + medicamento.hora.hour.toString() +
                    ":" + medicamento.hora.minute.toString().padLeft(2,'0')),
                  style: ButtonStyle(
                    textStyle: MaterialStateProperty.all(TextStyle(fontSize: 18,color: Colors.black)),
                    foregroundColor: MaterialStateProperty.all(Colors.black),
                  ),
                onPressed: (){
                  if(rol=="paciente") {
                    //noti.notiActivas();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) =>
                            detallesMedicamento(medicamento: medicamento,)));
                  }else{
                    //editar medicamento
                  }
                  },
              ),
             // _editar(),
            ],
          ),
        ),
      ),
    );
  }
  Widget _editar(){
    if(rol=="supervisor"){
      return Positioned(
        top: 0,
        right: 0,
        child: IconButton(
          onPressed: (){

          },
          icon: Icon(Icons.more_vert_sharp
          ),
        ),
      );
    }else{
      return Container();
    }
  }
}
