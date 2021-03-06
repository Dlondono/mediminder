import 'package:flutter/material.dart';
import 'package:mediminder/models/informes.dart';
import 'package:mediminder/models/paciente.dart';
import 'package:mediminder/screens/home/disenoInforme.dart';
import 'package:mediminder/services/database.dart';
import 'package:mediminder/shared/loading.dart';
import 'package:provider/provider.dart';

class listaInformes extends StatefulWidget {
  final String idPaciente;
  listaInformes({this.idPaciente});
  @override
  _listaInformesState createState() => _listaInformesState();
}
class _listaInformesState extends State<listaInformes> {

  String idPaciente;
  bool loading=false;
  final DatabaseService _database = DatabaseService();
  List<Informe> listaInformes,informes;
  Future getInformes()async{
    setState(() => loading = true);
    listaInformes=await _database.queryInformes(widget.idPaciente);
    if (this.mounted) {
      setState(() {
        informes = listaInformes;
        loading = false;
      });
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getInformes();
  }
  Widget numeroInformes(){
    if (informes != null) {
      if (informes.length == 0) {
        setState(() {
          loading = false;
        });
        return loading ? Loading() : Scaffold(
          backgroundColor: Color.fromRGBO(157, 221, 234, 50),
          body: Container(
            decoration: BoxDecoration(color: Color.fromRGBO(157, 221, 234, 50)),
            child: Center(
              child: Container(
                child: Text(
                  "Este paciente aun no tiene informes generados, "
                      "los informes se generan automáticamente "
                      "según el comportamiento del paciente",
                  style: TextStyle(fontSize: 18, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        );
      } else {
        return  Container(
          decoration: BoxDecoration(color: Color.fromRGBO(157, 221, 234, 50)),
          child: ListView.builder(
              itemCount: informes.length,
              itemBuilder: (context,index){
                return InformeDiseno(informe: informes[index]);
              }
          ),
        );
    }
    }else{
      setState(() {
        loading=true;
      });
      return Loading();
    }
  }
  @override
  Widget build(BuildContext context) {
    return loading? Loading(): Scaffold(
      appBar: AppBar(
        title: Text("Lista de informes"),
        backgroundColor: Color.fromRGBO(9, 111, 167, 50),

      ),
      body: numeroInformes(),
    );
  }
}
