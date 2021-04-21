import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mediminder/models/medicamento.dart';
import 'package:mediminder/models/paciente.dart';
import 'package:mediminder/models/userLocal.dart';
import '../models/paciente.dart';

class DatabaseService{
  //colecciones de firestore
  final String uid;
  DatabaseService({this.uid});
  final CollectionReference coleccionUsuarios = FirebaseFirestore.instance.collection("Usuarios");
  final CollectionReference coleccionPacientes = FirebaseFirestore.instance.collection("Pacientes");
  final CollectionReference coleccionMedicamentos = FirebaseFirestore.instance.collection("Medicamentos");

  Future updateUserData(String nombre,String id, String tipo) async{
    return await coleccionUsuarios.doc(uid).set({
      "nombre": nombre,
      "id": id,
      "tipo": tipo,
    });
  }

  Future addMedicine(String medicina,String id, String cantidad, String hora,  String minuto, String periodo) async{
    return await coleccionMedicamentos.add({
      "medicamentoNombre": medicina,
      "idPaciente": id,
      "cantidad": int.parse(cantidad),
      "hora": int.parse(hora),
      "minuto":int.parse(minuto),
      "periodo": int.parse(periodo),
    });
  }

  //convetir pacientes desde la snapshot de firebase
  List<Paciente> _listaPacientesFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return Paciente(
        nombre: doc.data()['nombre'] ?? "",
        id: doc.data()['cedula'] ?? "",
        idSuper: doc.data()['idSuper']??"",
      );
    }).toList();
  }

  List<Medicamento> _listaMedicamentosFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return Medicamento(
        medicamentoNombre: doc.data()['medicamentoNombre'] ?? "",
        idPaciente: doc.data()['idPaciente'] ?? "",
        cantidad: doc.data()['cantidad'] ?? "",
        hora: doc.data()['hora'] ?? "",
        minuto: doc.data()['minuto'] ?? "",
        periodo: doc.data()['periodo'] ?? "",
      );
    }).toList();
  }

  List<UserData> _listaUsuariosFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return UserData(
        nombre: doc.data()['nombre'] ?? "",
        uid: doc.data()['id'] ?? "",
        tipo: doc.data()['tipo']??"",
      );
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
      nombre:snapshot.data()['nombre']
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

  Stream<List<Medicamento>> get medicamentos{
    return coleccionMedicamentos.snapshots().map(_listaMedicamentosFromSnapshot);
  }

  Stream<List<UserData>> get users{
    return coleccionUsuarios.snapshots().map(_listaUsuariosFromSnapshot);
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

  Future addPaciente(String nombre, String cedula, String medicina,String uid) async{
    return await coleccionPacientes.doc(cedula).set({
      "nombre": nombre,
      "cedula": cedula,
      "idSuper":uid,
      }
      );
}

}
