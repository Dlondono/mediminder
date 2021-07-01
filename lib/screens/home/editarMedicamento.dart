import 'package:flutter/material.dart';
import 'package:mediminder/models/alarmaMedicamento.dart';

class editarMedicamento extends StatelessWidget {
  final AlarmaMedicamento medicamento;
  editarMedicamento({this.medicamento});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Editar "+medicamento.medicamentoNombre,style: TextStyle(
          fontSize: 22.0,
           ),
        ),
        backgroundColor: Color.fromRGBO(9, 111, 167, 50),
      ),
      body: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(157, 221, 234, 50)),
      ),
    );
  }
}
