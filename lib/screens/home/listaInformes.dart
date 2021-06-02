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
    //final informes=Provider.of<List<Informe>>(context)?? [];
    Informe inf=new Informe();
    inf.delay="delay";
    inf.nombreMedicamento="nombreMed";
    inf.idMedicamento="id";
    inf.fecha=DateTime.now();
    List<Informe> informes=[inf];

    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de informes"),
        backgroundColor: Color.fromRGBO(9, 111, 167, 50),
        actions: <Widget>[
          TextButton.icon(
            icon: Icon(Icons.person),
            label: Text("Salir"),
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(Colors.white),
            ),
            onPressed: ()async{
              //await _auth.signOut();
            },
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(157, 221, 234, 50)),
        child: ListView.builder(
          itemCount: informes.length,
          itemBuilder: (context,index){
            return InformeDiseno(informe: informes[index]);
          }
        ),
      ),
    );
  }
}
