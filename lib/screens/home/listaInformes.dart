import 'package:flutter/material.dart';
import 'package:mediminder/models/informes.dart';
import 'package:mediminder/models/paciente.dart';
import 'package:mediminder/screens/home/disenoInforme.dart';
import 'package:provider/provider.dart';

class listaInformes extends StatefulWidget {
  final Paciente paciente;
  listaInformes({this.paciente});
  @override
  _listaInformesState createState() => _listaInformesState();
}

class _listaInformesState extends State<listaInformes> {
  @override
  Widget build(BuildContext context) {
    final informes=Provider.of<List<Informe>>(context)?? [];

    return ListView.builder(
      itemCount: informes.length,
      itemBuilder: (context,index){
        return InformeDiseno(informe: informes[index]);
      }
    );
  }
}
