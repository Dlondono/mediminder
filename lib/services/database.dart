import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mediminder/models/alarmaMedicamento.dart';
import 'package:mediminder/models/informes.dart';
import 'package:mediminder/models/medicamento.dart';
import 'package:mediminder/models/paciente.dart';
import 'package:mediminder/models/supervisor.dart';
import 'package:mediminder/models/userLocal.dart';
import '../models/paciente.dart';

class DatabaseService{
  //colecciones de firestore
  final String uid;
  DatabaseService({this.uid});
  final CollectionReference coleccionUsuarios = FirebaseFirestore.instance.collection("Usuarios");
  final CollectionReference coleccionPacientes = FirebaseFirestore.instance.collection("Pacientes");
  final CollectionReference coleccionMedicamentos = FirebaseFirestore.instance.collection("Medicamentos");
  final CollectionReference coleccionInformes=FirebaseFirestore.instance.collection("Informes");

  Future queryMedicamentos(String idPaciente)async{
    List<Medicamento> listaMedicamentos=[];
    var result=await coleccionMedicamentos.where("idPaciente",isEqualTo: idPaciente).get();
    //result.docs.forEach((doc){
      for (var doc in result.docs) {
        Medicamento med = new Medicamento(
          medicamentoNombre: doc.data()['medicamentoNombre'] ?? "",
          idPaciente: doc.data()['idPaciente'] ?? "",
          cantidad: doc.data()['cantidad'] ?? "",
          hora: doc.data()['hora'] ?? "",
          minuto: doc.data()['minuto'] ?? "",
          periodo: doc.data()['periodo'] ?? "",
          recomendacion: doc.data()['recomendacion'] ?? "",
          dosis: doc.data()['dosis'] ?? "",
          uid: doc.id,
          tipo: doc.data()['tipo'],
          tipoHorario: doc.data()['tipoHorario'],
          veces: doc.data()['veces'],
          prioridad: doc.data()['prioridad'],
          prio: doc.data()['prio'] ?? "",
          dia: doc.data()['dia'] ?? "",
          mes: doc.data()['mes'] ?? "",
          year: doc.data()['año'] ?? "",
        );
        listaMedicamentos.add(med);
      }
    return listaMedicamentos;
  }
  Future queryPacientes(String idSuper)async{
    List<Paciente> listaPacientes=[];
    var result=await coleccionPacientes.where("idSuper",isEqualTo: idSuper).get();
      for(var doc in result.docs){
        Paciente paciente=new  Paciente(
          idSuper:doc.data()['uid'],
          id: doc.data()['cedula'],
          nombre:doc.data()['nombre'],
          idPaciente: doc.data()['uidPac'],
        );
        listaPacientes.add(paciente);
      }
      return listaPacientes;
  }
  Future querySupervisor(String uid)async{
    var doc = await FirebaseFirestore.instance.doc("Usuarios/$uid").get();
    return Supervisor(
      token:doc.data()['token'],
      id: doc.data()['id: '],
      nombre:doc.data()['nombre'],
      );
  }
  Future queryPaciente(String idPaciente)async{
    var result=await coleccionPacientes.where("uidPac",isEqualTo: idPaciente).get();
    for(var doc in result.docs) {
      Paciente pac=new Paciente(
        nombre: doc.data()['nombre'] ?? "",
        id: doc.data()['cedula'] ?? "",
        idSuper: doc.data()['idSuper'] ?? "",
        idPaciente: doc.data()['uidPac'] ?? "",
      );
      return pac;
      }
  }
  Future queryInformes(String idPaciente)async{
    List<Informe> listaInformes=[];
    var result=await coleccionInformes.where("idPaciente",isEqualTo: idPaciente).get();
    for (var doc in result.docs){
      Informe informe=new Informe(
        fecha: doc.data()['fecha']??"",
        delay: doc.data()['delay']??"",
        idPaciente: doc.data()['idPaciente']??"",
        nombreMedicamento: doc.data()['nombreMedicamento']??"",
        idMedicamento: doc.data()['idMedicamento']??"",
      );
      listaInformes.add(informe);
    }
    return listaInformes;
  }

  Future updateUserData(String nombre,String id, String tipo) async{
    return await coleccionUsuarios.doc(uid).set({
      "nombre": nombre,
      "id": id,
      "tipo": tipo,
    });
  }

  Future addMedicine(String medicina,String id, String cantidad, String hora,
      String minuto, String periodo, String recomendacion, String dosis,String prioridad,
      String tipo,String tipoHorario,int veces
      ) async{
    Random random=new Random();
    int rnd=random.nextInt(100);
    String idR=id+rnd.toString();
    return await coleccionMedicamentos.doc(idR).set({
      "medicamentoNombre": medicina,
      "idPaciente": id,
      "cantidad": int.parse(cantidad),
      "hora": int.parse(hora),
      "minuto":int.parse(minuto),
      "periodo": int.parse(periodo),
      "recomendacion": recomendacion,
      "dosis": int.parse(dosis),
      "uid":idR,
      "veces":veces,
      "tipo":tipo,
      "prioridad":prioridad,
      "prio": 1,
      "tipoHorario":tipoHorario,
      "dia":DateTime.now().day,
      "mes":DateTime.now().month,
      "año":DateTime.now().year,
    });
  }
  Future editMedicine(String medicina,String id, String cantidad, String hora,
      String minuto, String periodo, String recomendacion, String dosis,String prioridad,
      String tipo,String tipoHorario,int veces,String uid,int prio
      ) async{
    return await coleccionMedicamentos.doc(uid).set({
      "medicamentoNombre": medicina,
      "idPaciente": id,
      "cantidad": int.parse(cantidad),
      "hora": int.parse(hora),
      "minuto":int.parse(minuto),
      "periodo": int.parse(periodo),
      "recomendacion": recomendacion,
      "dosis": int.parse(dosis),
      "uid":uid,
      "veces":veces,
      "prio":prio,
      "tipo":tipo,
      "prioridad":prioridad,
      "tipoHorario":tipoHorario,
      "dia":DateTime.now().day,
      "mes":DateTime.now().month,
      "año":DateTime.now().year,
    });
  }


  Future updateMedicine(int mes,int dia,int hora,int minuto,int cantidad,String id, int prio) async{
    return await coleccionMedicamentos.doc(id).update({
      "cantidad": cantidad,
      "hora":hora,
      "minuto":minuto,
      "dia":dia,
      "mes":mes,
      "prio": prio,
    });
  }
  Future updateCantidad(int cantidad,String medUid) async{
    return await coleccionMedicamentos.doc(medUid).update({
      "cantidad":cantidad,
    });
  }

  Future addInforme(String id,AlarmaMedicamento medicamento,String delay) async{
    Random random=new Random();
    int rnd=random.nextInt(100);
    String idR=id+rnd.toString();
    return await coleccionInformes.doc(idR).set({
      "idMedicamento": medicamento.uid,
      "nombreMedicamento":medicamento.medicamentoNombre,
      "idPaciente":medicamento.idPaciente,
      "fecha":medicamento.hora.toString(),
      "delay":delay
    });
  }
  List<Informe> _listaInformesFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return Informe(
        nombreMedicamento: doc.data()['idMedicamento'] ?? "",
        fecha: doc.data()['fecha']??"",
        idMedicamento: doc.data()['nombreMedicamento'] ?? "",
        delay: doc.data()['delay']??"",
      );
    }).toList();
  }
  //convetir pacientes desde la snapshot de firebase
  List<Paciente> _listaPacientesFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return Paciente(
        nombre: doc.data()['nombre'] ?? "",
        id: doc.data()['cedula'] ?? "",
        idSuper: doc.data()['idSuper']??"",
        idPaciente: doc.data()['uidPac']??"",
      );
    }).toList();
  }

  List<Medicamento> _listaMedicamentosFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      if(doc.data()['periodo']!=null) {
        return Medicamento(
          medicamentoNombre: doc.data()['medicamentoNombre'] ?? "",
          idPaciente: doc.data()['idPaciente'] ?? "",
          cantidad: doc.data()['cantidad'] ?? "",
          hora: doc.data()['hora'] ?? "",
          minuto: doc.data()['minuto'] ?? "",
          periodo: doc.data()['periodo'] ?? "",
          recomendacion: doc.data()['recomendacion'] ?? "",
          dosis: doc.data()['dosis'] ?? "",
          uid: doc.id,
          tipo: doc.data()['tipo'],
          tipoHorario: doc.data()['tipoHorario'],
          veces: doc.data()['veces'],
          prioridad: doc.data()['prioridad'],
          prio: doc.data()['prio'],
          dia: doc.data()['dia'] ?? "",
          mes: doc.data()['mes'] ?? "",
          year: doc.data()['año'] ?? "",
        );
      }
    }).toList();
  }

  //userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    return UserData(
      uid: uid,
      nombre: snapshot.data()['nombre'],
      id: snapshot.data()['id'],
      tipo: snapshot.data()['tipo'],
    );
  }

  Paciente _pacienteDataFromSnapshot(DocumentSnapshot snapshot){
    return Paciente(
      idSuper:snapshot.data()['uid'],
      id: snapshot.data()['cedula'],
      nombre:snapshot.data()['nombre'],
      idPaciente: snapshot.data()['uidPac'],
    );
    }

  Medicamento _medicamentoDataFromSnapshot(DocumentSnapshot snapshot){
    return Medicamento(
        medicamentoNombre: snapshot.data()['medicamentoNombre'],
        idPaciente: snapshot.data()['idPaciente'],
        cantidad: snapshot.data()['cantidad'],
        hora: snapshot.data()['hora'],
        minuto: snapshot.data()['minuto'],
        periodo: snapshot.data()['periodo'],
        recomendacion: snapshot.data()['recomendacion'],
        dosis: snapshot.data()['dosis'],
      uid: snapshot.id,
    );
  }

    List<Paciente> pacienteFromQuery(QuerySnapshot snapshot){
      return snapshot.docs.map(
              (doc)=> Paciente(
                id: doc['id'],
                idSuper: doc['uid'],
                idPaciente: doc['uidPac'],
                ),
      );
    }

  Stream<List<Medicamento>> get medicamentos{
    return coleccionMedicamentos.snapshots().map(_listaMedicamentosFromSnapshot);
  }

  Stream<List<Informe>> get informes{
    return coleccionInformes.snapshots().map(_listaInformesFromSnapshot);
  }

  Stream<Paciente> get paciente{
    return coleccionPacientes.doc(uid).snapshots().map(_pacienteDataFromSnapshot);
  }

  Stream<Medicamento> get medicamento{
    return coleccionMedicamentos.doc(uid).snapshots().map(_medicamentoDataFromSnapshot);
  }

  //ger user doc stream
  Stream<UserData> get userData{
    return coleccionUsuarios.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

  Future addPaciente(String nombre, String cedula,String uid,String uidPac) async{
    return await coleccionPacientes.doc(uidPac).set({
      "nombre": nombre,
      "cedula": cedula,
      "idSuper":uid,
      "uidPac": uidPac,
      }
      );
}
  Future addToken(String token) async{
    return await coleccionUsuarios.doc(uid).update({
      "token": token,
    });
  }

}
