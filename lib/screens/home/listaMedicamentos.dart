import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mediminder/models/alarmaMedicamento.dart';
import 'package:mediminder/models/medicamento.dart';
import 'package:mediminder/models/paciente.dart';
import 'package:mediminder/models/userLocal.dart';
import 'package:mediminder/screens/home/disenoMedicamento.dart';
import 'package:mediminder/screens/home/editarMedicamento.dart';
import 'package:mediminder/services/database.dart';
import 'package:mediminder/shared/loading.dart';
import 'package:provider/provider.dart';
import 'package:timezone/timezone.dart' as tz;

class Medicamentos extends StatefulWidget {
  final String id,tipo;
  Medicamentos(this.id,this.tipo);
  @override
  _MedicamentosState createState() => _MedicamentosState();
}

class _MedicamentosState extends State<Medicamentos> {
  bool loading=false;
  String msg1;
  final DatabaseService _database=DatabaseService();
  final FirebaseAuth auth=FirebaseAuth.instance;
  DateTime horaActualLocal = tz.TZDateTime.now(tz.local);
  List<Medicamento> medicamentos,meds;
  List<AlarmaMedicamento> alarmaLista = [];
  Future getMedicamentos()async{
    setState(() {
      loading=true;
    });
    meds=await _database.queryMedicamentos(widget.id);
    if(this.mounted) {
      setState(() {
        medicamentos = meds;
        loading=false;
      });
    }
    }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMedicamentos();
  }
  @override
  Widget build(BuildContext context) {
    final uid=widget.id;
    final String tipo=widget.tipo;
    alarmaLista = [];
    AlarmaMedicamento medi;

    if(tipo=="supervisor"){
      msg1 = "El paciente aun no tiene registrado ningun medicamento, "
          "porfavor registre algun medicamento antes de realizar una consulta.";
    }
    if(tipo=="paciente"){
      msg1 = "Aun no tiene medicamentos registrados, "
          "para registrar un medicamento contacte a su cuidador.";
  }
    for(var item in medicamentos??[]){
      if (item.periodo != null) {
        DateTime horaNueva = new DateTime(item.year,
            item.mes, item.dia, item.hora, item.minuto);
        DateTime t,now;
        now=DateTime.now().add(Duration(hours: -2));
        t = DateTime.parse(item.year.toString() +
            item.mes.toString().padLeft(2, '0')
            + item.dia.toString().padLeft(2, '0') + " " + horaNueva.hour.toString().padLeft(2,'0')
            + ":" + horaNueva.minute.toString().padLeft(2,'0') + ":" + "00");
        if(t.isBefore(now)){
          //dia y mes antes
          item.dia =now.day;
          item.mes=now.month;
          t = DateTime.parse(item.year.toString() +
              item.mes.toString().padLeft(2, '0')
              + item.dia.toString().padLeft(2, '0') + " " + horaNueva.hour.toString().padLeft(2,'0')
              + ":" + horaNueva.minute.toString().padLeft(2,'0') + ":" + "00");
          if(t.isBefore(now)){
            //item.dia=now.day+1;
            t = DateTime.parse(item.year.toString() +
                item.mes.toString().padLeft(2, '0')
                + item.dia.toString().padLeft(2, '0') + " " + horaNueva.hour.toString().padLeft(2,'0')
                + ":" + horaNueva.minute.toString().padLeft(2,'0') + ":" + "00");
            if(t.isBefore(now)){
              item.mes=now.month+1;
              t = DateTime.parse(item.year.toString() +
                  item.mes.toString().padLeft(2, '0')
                  + item.dia.toString().padLeft(2, '0') + " " + horaNueva.hour.toString().padLeft(2,'0')
                  + ":" + horaNueva.minute.toString().padLeft(2,'0') + ":" + "00");
            }
          }
        }

        medi = new AlarmaMedicamento(medicamentoNombre: item.medicamentoNombre,
            descripcion: item.recomendacion,
            cantidad: item.cantidad,
            hora: t,
            periodo: item.periodo,
            idPaciente: item.idPaciente,
            dosis: item.dosis,
            uid: item.uid,
            dia: item.dia,
            mes: item.mes,
            year: item.year,
            tipo: item.tipo,
            tipoHorario: item.tipoHorario,
            prioridad: item.prioridad,
            prio: item.prio,
            veces:item.veces,
        );
        alarmaLista.add(medi);
      }else {
        return Container(
          child: Text("ERROR "),
        );
      }
      };
    alarmaLista.sort((alarmaA, alarmaB) => alarmaA.hora.isBefore(alarmaB.hora)? 0:1);
    return _numeroMedicamentos();

  }

  Widget _numeroMedicamentos(){
    if(medicamentos!=null){
      if(alarmaLista.length==0){
        setState(() {
          loading = false;
        });
        return loading ? Loading() : Scaffold(
          backgroundColor: Color.fromRGBO(157, 221, 234, 50),
          body: Container(
            decoration: BoxDecoration(color: Color.fromRGBO(157, 221, 234, 50)),
              child: Column(
                children: [
                  Container(
                    child: Text(
                      msg1,
                          style: TextStyle(fontSize: 18, color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
          ),
        );
      }else{
        return Container(
          child: loading?Loading(): ListView.builder(
              itemCount: alarmaLista.length,
              itemBuilder: (context,index) {
                return MedicamentoDiseno(alarmaLista[index],widget.tipo);
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
}
