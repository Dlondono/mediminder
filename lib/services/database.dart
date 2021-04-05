import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mediminder/models/paciente.dart';

class DatabaseService{
  //colecciones de firestore
  final String uid;
  DatabaseService({this.uid});
  final CollectionReference coleccionUsuarios = FirebaseFirestore.instance.collection("Usuarios");

  Future updateUserData(String nombre,String medicamento,String id) async{
    return await coleccionUsuarios.doc(uid).set({
      "nombre": nombre,
      "medicamento": medicamento,
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

  // actualizacion de pacientes a supervisor
  Stream<List<Paciente>> get pacientes{
    return coleccionUsuarios.snapshots().map(_listaPacientesFromSnapshot);
  }
}