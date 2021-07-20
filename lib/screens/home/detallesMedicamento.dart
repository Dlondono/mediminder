import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mediminder/models/alarmaMedicamento.dart';
import 'package:mediminder/models/informes.dart';
import 'package:mediminder/models/paciente.dart';
import 'package:mediminder/models/supervisor.dart';
import 'package:mediminder/services/database.dart';
import 'package:mediminder/services/local_noti.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

class detallesMedicamento extends StatefulWidget {
  final AlarmaMedicamento medicamento;
  detallesMedicamento({this.medicamento});

  @override
  _detallesMedicamentoState createState() => _detallesMedicamentoState();
}

class _detallesMedicamentoState extends State<detallesMedicamento> {
  final DatabaseService _database=DatabaseService();
  final Notifications noti = new Notifications();
  final Informe informe=new Informe();
  final url = "https://fcm.googleapis.com/fcm/send";
  Paciente pac,paciente;
  String token,idSuper;
  Supervisor sup,supervisor;
  Future getPaciente()async{
    pac=await _database.queryPaciente(widget.medicamento.idPaciente);
    if(this.mounted) {
      setState(() {
        paciente=pac;
      });
      }
    print(paciente.idSuper);
    getToken();
  }
  Future getToken()async{
    sup=await _database.querySupervisores(paciente.idSuper);
    if(this.mounted) {
      setState(() {
        supervisor=sup;
        });
    }
    print(supervisor.token);
  }

  Future<void> sendPushMessage() async {
    final msg = jsonEncode({"to": supervisor.token,
      "notification": {
        "title": "Probando fcm api",
        "body": "Body notificacion fcm"
      },
      "data": {
        "medicamento": "Medicina"
      }});
    try {
      var response = await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization' : 'Key=AAAAhrjgfCE:APA91bHwxTFEQ1jU0ZCxAXfzT3jjNn4i48sYRtlUq4EFglcp21w4nTRUBsz6VjhAgdzuyqSrunmE3J63tmVaslarxqoM500fyKJHdy5jTYakcTaIWlIGb0gZQwwbhFjl8fDANJWcPlZO'
        },
        body: msg,
      );
      print('FCM request for device sent!');
      print(response);
    } catch (e) {
      print(e);
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPaciente();
    }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.medicamento.medicamentoNombre,style: TextStyle(
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
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              margin: EdgeInsets.symmetric(vertical: 1.0.h, horizontal: 3.0.h),
              child: ListTile(
                //contentPadding: ,
                leading: Icon(Icons.medical_services),
                title: Text(widget.medicamento.medicamentoNombre,
                    style: TextStyle(fontSize: 22,color: Colors.black)),
                subtitle: Text(widget.medicamento.hora.hour.toString().padLeft(2, '0')
                    +":"+ widget.medicamento.hora.minute.toString().padLeft(2, '0')
                    +"\n"+"Cantidad: "+this.widget.medicamento.cantidad.toString()+"\n"+"\n"+widget.medicamento.descripcion,
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
                if(widget.medicamento.periodo!=null) {
                  widget.medicamento.hora = widget.medicamento.hora.add(Duration(hours: widget.medicamento.periodo));
                }
                    /*noti.setTime(medicamento.hora.year, medicamento.hora.month
                        , medicamento.dia, medicamento.hora.hour,
                        medicamento.hora.minute);
                    noti.scheduleweeklyNotification(medicamento.idPaciente,
                        medicamento.medicamentoNombre, medicamento.descripcion);
                     */
                  else {
                  widget.medicamento.hora = widget.medicamento.hora.add(
                      Duration(days: 1));
                  }

                this.widget.medicamento.cantidad=this.widget.medicamento.cantidad-1;
                _database.updateCantidad(this.widget.medicamento.cantidad,widget.medicamento.uid);
                if(this.widget.medicamento.cantidad<=5){
                  noti.showNotification("Quedan pocas unidades de "+this.widget.medicamento.medicamentoNombre);
                }
                if(this.widget.medicamento.cantidad<=0){
                  this.widget.medicamento.cantidad=0;
                }
                _database.updateMedicine(widget.medicamento.hora.month,widget.medicamento.hora.day,
                    widget.medicamento.hora.hour,widget.medicamento.hora.minute,
                    widget.medicamento.cantidad, widget.medicamento.uid);
                String delay=informe.calcularDelay(widget.medicamento.hora, DateTime.now());
                informe.crearInforme(widget.medicamento.idPaciente, "nombrePaciente",
                    widget.medicamento, delay);
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
                sendPushMessage();
                widget.medicamento.hora = widget.medicamento.hora.add(const Duration(minutes: 5));
                noti.setTime(widget.medicamento.hora.year, widget.medicamento.hora.month, widget.medicamento.hora.day, widget.medicamento.hora.hour, widget.medicamento.hora.minute);
                noti.scheduleweeklyNotification(widget.medicamento.idPaciente,widget.medicamento.medicamentoNombre,widget.medicamento.descripcion);
                _database.updateMedicine(widget.medicamento.mes,widget.medicamento.dia,widget.medicamento.hora.hour,
                    widget.medicamento.hora.minute, widget.medicamento.cantidad, widget.medicamento.uid);
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
