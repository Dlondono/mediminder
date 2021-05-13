import 'package:flutter/material.dart';
import 'package:mediminder/models/medicamento.dart';
import 'package:mediminder/services/local_noti.dart';
import 'package:sizer/sizer.dart';

class detallesMedicamento extends StatelessWidget {
  final Medicamento medicamento;
  detallesMedicamento({this.medicamento});
  final Notifications noti = new Notifications();
  @override
  Widget build(BuildContext context) {
    DateTime t = noti.localTime();
    DateTime t2 = new DateTime(t.year,t.month,t.day,medicamento.hora,medicamento.minuto);
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
                subtitle: Text(medicamento.hora.toString()+":"+ medicamento.minuto.toString()
                    +"\n"+"\n"+medicamento.recomendacion,
                    style: TextStyle(fontSize: 20,color: Colors.black)),
              ),
            ),
            SizedBox(height: 2.0.h),
            TextButton.icon(
              icon: Icon(Icons.check,color: Colors.white,),
              label: Text("Ya me lo tomé",style: TextStyle(
                  fontSize: 20,color: Colors.white
              ),),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color.fromRGBO(9, 111, 167, 50)),
                foregroundColor: MaterialStateProperty.all(Colors.black),
              ),
              onPressed:(){
                t2 = t2.add(Duration(hours: medicamento.periodo));
                noti.setTime(t2.year, t2.month, t2.day, t2.hour, t2.minute);
                noti.scheduleweeklyNotification(medicamento.idPaciente,medicamento.medicamentoNombre,medicamento.recomendacion);
                medicamento.setTime(t2.hour, t2.minute);
                Navigator.pop(context);
              },
            ),
            SizedBox(height: 2.0.h),
            TextButton.icon(
              icon: Icon(Icons.check,color: Colors.white,),
              label: Text("Posponer",style: TextStyle(
                  fontSize: 20,color: Colors.white
              ),),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color.fromRGBO(9, 111, 167, 50)),
                foregroundColor: MaterialStateProperty.all(Colors.black),
              ),
              onPressed:(){
                t2 = t2.add(const Duration(minutes: 5));
                noti.setTime(t2.year, t2.month, t2.day, t2.hour, t2.minute);
                noti.scheduleweeklyNotification(medicamento.idPaciente,medicamento.medicamentoNombre,medicamento.recomendacion);
                medicamento.setTime(t2.hour, t2.minute);
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
