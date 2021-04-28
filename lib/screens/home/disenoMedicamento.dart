import 'package:flutter/material.dart';
import 'package:mediminder/models/medicamento.dart';
import 'package:mediminder/services/local_noti.dart';
import 'package:mediminder/services/local_noti.dart';

class MedicamentoDiseno extends StatelessWidget {

  final Medicamento medicamento;
  final Notifications noti = new Notifications();
  MedicamentoDiseno({this.medicamento});
  //noti.init();
  //noti.showNotification("Mi notif");
  //noti.myTimedNotification();
  @override
  Widget build(BuildContext context) {
    noti.setTime(2021, 4, 28,medicamento.hora,medicamento.minuto);
    noti.scheduleweeklyNotification();
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
              title: Text(medicamento.medicamentoNombre),

            ),
            TextButton.icon(
              icon: Icon(Icons.medical_services),
              label: Text("ASD"),
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
