import 'package:flutter/material.dart';
import 'package:mediminder/models/paciente.dart';
import 'package:mediminder/screens/home/listaInformes.dart';
import 'package:mediminder/screens/home/settings_form.dart';
import 'package:sizer/sizer.dart';

class PacienteDiseno extends StatelessWidget {
  final Paciente paciente;
  PacienteDiseno({this.paciente});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 2.0.h,horizontal: 3.0.h),
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 1.0.h,horizontal: 1.0.h),
        color: Colors.white,
        child: Column(
          children: <Widget>[
          ListTile(
          leading: Icon( //imagen medicamento?
            Icons.person
          ),
          title: Text(paciente.nombre,style: TextStyle(color: Colors.black),),
            subtitle: Text(paciente.id,style: TextStyle(color: Colors.black),),
        ),
            TextButton.icon(
              icon: Icon(Icons.add),
              label: Text("Agregar medicamento"),
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(Colors.black),
              ),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (context)=> SettingsForm(paciente: paciente)));

              },
            ),
            TextButton.icon(
              icon: Icon(Icons.arrow_forward_rounded),
              label: Text("Ver informes"),
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(Colors.black),
              ),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (context)=> listaInformes()));

              },
            ),
          ],
        ),
      ),
    );
  }
}
