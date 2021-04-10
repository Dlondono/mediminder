import 'package:flutter/material.dart';
import 'package:mediminder/models/paciente.dart';

class MedicamentoDiseno extends StatelessWidget {

  final Paciente paciente;
  MedicamentoDiseno({this.paciente});
  @override
  Widget build(BuildContext context) {

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
              title: Text(paciente.medicina),
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
