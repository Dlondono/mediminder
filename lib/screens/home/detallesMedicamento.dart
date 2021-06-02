import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mediminder/models/alarmaMedicamento.dart';
import 'package:mediminder/models/informes.dart';
import 'package:mediminder/services/database.dart';
import 'package:mediminder/services/local_noti.dart';
import 'package:sizer/sizer.dart';

class detallesMedicamento extends StatelessWidget {
  final AlarmaMedicamento medicamento;
  detallesMedicamento({this.medicamento});
  final DatabaseService _database=DatabaseService();
  final Notifications noti = new Notifications();
  final Informe informe=new Informe();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(medicamento.medicamentoNombre,style: TextStyle(
          fontSize: 22.0,
          ),
        ),
        backgroundColor: Color.fromRGBO(9, 111, 167, 50),
      ),
      body: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(157, 221, 234, 50)),
        child: Column(
          children:<Widget> [
            Container(
              width: 60.0.w,
              height: 30.0.h,
              child:Image.asset('assets/Medico.png'),
            ),
            SizedBox(height: 2.0.h),
            Card(
              margin: EdgeInsets.symmetric(vertical: 1.0.h, horizontal: 3.0.h),
              child: ListTile(
                //contentPadding: ,
                leading: Icon(Icons.medical_services),
                title: Text(medicamento.medicamentoNombre,
                    style: TextStyle(fontSize: 22,color: Colors.black)),
                subtitle: Text(medicamento.hora.hour.toString()+":"+ medicamento.hora.minute.toString()
                    +"\n"+"Cantidad: "+this.medicamento.cantidad.toString()+"\n"+"\n"+medicamento.descripcion,
                    style: TextStyle(fontSize: 20,color: Colors.black)),
              ),
            ),
            SizedBox(height: 2.0.h),
            TextButton.icon(
              icon: Icon(Icons.check,color: Colors.white,),
              label: Text("Ya me lo tomé",style: TextStyle(
                  fontSize: 20,color: Colors.white
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color.fromRGBO(9, 111, 167, 50)),
                foregroundColor: MaterialStateProperty.all(Colors.black),
              ),
              onPressed:(){
                if(medicamento.hora.hour+medicamento.periodo>23){
                  medicamento.dia=medicamento.dia+1;
                }
                medicamento.hora = medicamento.hora.add(Duration(hours: medicamento.periodo));
                noti.setTime(medicamento.hora.year, medicamento.hora.month
                    , medicamento.dia, medicamento.hora.hour, medicamento.hora.minute);
                noti.scheduleweeklyNotification(medicamento.idPaciente,
                    medicamento.medicamentoNombre,medicamento.descripcion);
                this.medicamento.cantidad=this.medicamento.cantidad-1;
                _database.updateCantidad(this.medicamento.cantidad,medicamento.uid);
                if(this.medicamento.cantidad<=5){
                  noti.showNotification("Quedan pocas unidades de "+this.medicamento.medicamentoNombre);
                }
                if(this.medicamento.cantidad<=0){
                  this.medicamento.cantidad=0;
                }
                _database.updateMedicine(medicamento.dia,medicamento.hora.hour,
                    medicamento.hora.minute, medicamento.cantidad, medicamento.uid);
                String delay=informe.calcularDelay(medicamento.hora, DateTime.now());
                informe.crearInforme(medicamento.idPaciente, "nombrePaciente",
                    medicamento, delay);
                Navigator.pop(context);
                },
            ),
            SizedBox(height: 2.0.h),
            TextButton.icon(
              icon: Icon(Icons.timer,color: Colors.white,),
              label: Text("Posponer",style: TextStyle(
                  fontSize: 20,color: Colors.white
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color.fromRGBO(9, 111, 167, 50)),
                foregroundColor: MaterialStateProperty.all(Colors.black),
              ),
              onPressed:(){
                medicamento.hora = medicamento.hora.add(const Duration(minutes: 5));
                noti.setTime(medicamento.hora.year, medicamento.hora.month, medicamento.hora.day, medicamento.hora.hour, medicamento.hora.minute);
                noti.scheduleweeklyNotification(medicamento.idPaciente,medicamento.medicamentoNombre,medicamento.descripcion);
                _database.updateMedicine(medicamento.dia,medicamento.hora.hour,
                    medicamento.hora.minute, medicamento.cantidad, medicamento.uid);
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
