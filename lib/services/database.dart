import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{
  //colecciones de firestore
  final String uid;
  DatabaseService({this.uid});
  final CollectionReference coleccionUsuarios = FirebaseFirestore.instance.collection("Usuarios");

  Future updateUserData(String nombre,String medicamento) async{
    return await coleccionUsuarios.doc(uid).set({
      "nombre": nombre,
      "medicamento": medicamento,
    });
  }
  // actualizacion de pacientes a supervisor
  Stream<QuerySnapshot> get pacientes{
    return coleccionUsuarios.snapshots();
  }
}