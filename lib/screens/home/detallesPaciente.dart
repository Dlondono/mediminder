import 'package:flutter/material.dart';
import 'package:mediminder/models/medicamento.dart';
import 'package:mediminder/models/paciente.dart';
import 'package:mediminder/screens/home/listaMedicamentos.dart';
import 'package:mediminder/services/database.dart';
import 'package:provider/provider.dart';

class detallesPaciente extends StatefulWidget {
  final Paciente paciente;
  detallesPaciente({this.paciente});
  @override
  _detallesPacienteState createState() => _detallesPacienteState();
}

class _detallesPacienteState extends State<detallesPaciente> {
  @override
  void initState(){
    super.initState();
  }
  Widget build(BuildContext context) {
    Paciente paciente=widget.paciente;
    return StreamProvider.value(
      value: DatabaseService().medicamentos,
      child: Scaffold(
          appBar: AppBar(
          title: Text("Medicamentos de "+paciente.nombre,style: TextStyle(
          fontSize: 22.0,
          ),
        ),
      backgroundColor: Color.fromRGBO(9, 111, 167, 50),
      ),
        body: Container(
            decoration: BoxDecoration(color: Color.fromRGBO(157, 221, 234, 50)),
            child: Column(
              children: <Widget>[
                Expanded(child: Medicamentos(widget.paciente.idPaciente,"supervisor")),
              ],
            )
        ),
      ),
    );
  }
}
