import 'package:flutter/material.dart';
import 'package:mediminder/models/medicamento.dart';
import 'package:mediminder/models/paciente.dart';
import 'package:mediminder/screens/home/detallesPaciente.dart';
import 'package:mediminder/screens/home/listaInformes.dart';
import 'package:mediminder/screens/home/settings_form.dart';
import 'package:mediminder/services/database.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class PacienteDiseno extends StatelessWidget {
  final Paciente paciente;
  PacienteDiseno({this.paciente});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Medicamento>>.value(
      value:DatabaseService().medicamentos,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 1.0.h,horizontal: 2.0.h),
          child: GestureDetector(//padding
            onTap: (){

              Navigator.push(context, MaterialPageRoute(
              builder: (context)=> detallesPaciente(paciente: paciente)));
              },
      child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
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
              ButtonBar(
                alignment: MainAxisAlignment.spaceBetween,
                children:<Widget>[
                  TextButton.icon(
                    icon: Icon(Icons.add),
                    label: Text("Agregar medicamento"),
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(Colors.black),
                    ),
                    onPressed: ()async{
                      await Navigator.push(context, MaterialPageRoute(
                          builder: (BuildContext context) {
                            return SettingsForm(paciente: paciente);
                          }
                          ));
                    },
                  ),
                  TextButton.icon(
                    icon: Icon(Icons.arrow_forward_rounded),
                    label: Text("Informes"),
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(Colors.black),
                    ),
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context)=> listaInformes()));
                    },
                  ),
                ]
              ),
            ],
          ),
        ),
      ),
      ),
    );
  }
}
