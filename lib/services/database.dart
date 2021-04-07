import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:mediminder/models/medicamento.dart';
import 'package:mediminder/models/paciente.dart';
import 'package:mediminder/models/userLocal.dart';

import '../models/paciente.dart';
import '../models/paciente.dart';
import '../models/paciente.dart';

class DatabaseService{
  //colecciones de firestore
  final String uid;
  DatabaseService({this.uid});
  final CollectionReference coleccionUsuarios = FirebaseFirestore.instance.collection("Usuarios");
  final CollectionReference coleccionPacientes = FirebaseFirestore.instance.collection("Pacientes");

  Future updateUserData(String nombre,String id) async{
    return await coleccionUsuarios.doc(uid).set({
      "nombre": nombre,
      "id": id,
    });
  }
  //convetir pacientes desde la snapshot de firebase
  List<Paciente> _listaPacientesFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return Paciente(
        nombre: doc.data()['nombre'] ?? "",
        id: doc.data()['id'] ?? "",
        idSuper: doc.data()['idSuper']??"",
      );
    }).toList();
  }
  //userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    return UserData(
      uid: uid,
      nombre: snapshot.data()['nombre'],
      //medicamento: snapshot.data()['medicamento'],
      id: snapshot.data()['id'],
    );
  }
  Paciente _pacienteDataFromSnapshot(DocumentSnapshot snapshot){
    return Paciente(
      idSuper:snapshot.data()['uid'],
      id: snapshot.data()['cedula'],
      nombre:snapshot.data()['nombre']
    );
    }

    List<Paciente> pacienteFromQuery(QuerySnapshot snapshot){
      //QuerySnapshot snapshot=
      //await FirebaseFirestore.instance.collection("Pacientes").where('uid',isEqualTo: uid).get()
      return snapshot.docs.map(
              (doc)=> Paciente(
                id: doc['id'],
                idSuper: doc['uid'],
                ),

      );

    }


  // actualizacion de pacientes a supervisor
  Stream<List<Paciente>> get pacientes{
    return coleccionPacientes.snapshots().map(_listaPacientesFromSnapshot);
  }
  Stream<Paciente> get paciente{
    return coleccionPacientes.doc(uid).snapshots().map(_pacienteDataFromSnapshot);
  }

  //ger user doc stream
  Stream<UserData> get userData{
    return coleccionUsuarios.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

  Future addPaciente(String nombre, String cedula, String medicina,String uid) async{
    return await coleccionPacientes.doc(cedula).set({
      "nombre": nombre,
      "cedula": cedula,
      "medicina": medicina,
      "idSuper":uid}
      );
}
}
