import 'package:flutter/material.dart';
import 'package:mediminder/XDRegistropaciente.dart';
import 'package:mediminder/models/paciente.dart';
import 'package:mediminder/screens/home/settings_form.dart';

import 'pacienteNuevo.dart';

class PacienteDiseno extends StatelessWidget {
  final Paciente paciente;
  PacienteDiseno({this.paciente});

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel(){
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 20.0),
          child: SettingsForm(paciente: paciente),
        );
      });
    }
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
          title: Text(paciente.nombre),
        ),
            TextButton.icon(
              icon: Icon(Icons.settings),
              label: Text("Editar"),
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(Colors.black),
              ),

              onPressed: (){
                _showSettingsPanel();
              },
            ),
          ],
        ),
      ),
    );
  }
}
