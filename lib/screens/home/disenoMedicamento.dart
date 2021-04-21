import 'package:flutter/material.dart';
import 'package:mediminder/models/medicamento.dart';
import 'package:mediminder/models/paciente.dart';

class MedicamentoDiseno extends StatelessWidget {

  final Medicamento medicamento;
  MedicamentoDiseno({this.medicamento});
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
