import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mediminder/models/medicamento.dart';
import 'package:mediminder/models/paciente.dart';
import 'package:mediminder/models/userLocal.dart';

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
      );
    }).toList();
  }
  //userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    return UserData(
      uid: uid,
      nombre: snapshot.data()['nombre'],
      medicamento: snapshot.data()['medicamento'],
      id: snapshot.data()['id'],
    );
  }

  // actualizacion de pacientes a supervisor
  Stream<List<Paciente>> get pacientes{
    return coleccionPacientes.snapshots().map(_listaPacientesFromSnapshot);
  }

  //ger user doc stream
  Stream<UserData> get userData{
    return coleccionPacientes.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

  Future addPaciente(String nombre, String cedula, String medicina) async{
    return await coleccionPacientes.doc(cedula).set({
      "nombre": nombre,
      "cedula": cedula,
      "medicina": medicina});
}
}
