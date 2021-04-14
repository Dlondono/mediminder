import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mediminder/models/paciente.dart';
import 'package:mediminder/models/userLocal.dart';
import '../models/paciente.dart';

class DatabaseService{
  //colecciones de firestore
  final String uid;
  DatabaseService({this.uid});
  final CollectionReference coleccionUsuarios = FirebaseFirestore.instance.collection("Usuarios");
  final CollectionReference coleccionPacientes = FirebaseFirestore.instance.collection("Pacientes");

  Future updateUserData(String nombre,String id, String tipo) async{
    return await coleccionUsuarios.doc(uid).set({
      "nombre": nombre,
      "id": id,
      "tipo": tipo,
    });
  }

  Future updatePacienteData(String id,String nombre, String uid) async{
    return await coleccionPacientes.doc(id).set({
      "cedula": id,
      "idSuper": uid,
      "nombre" : nombre,
    });
  }

  Future addMedicine(String id) async{
    return await coleccionPacientes.doc(id).update({
      "medicines":FieldValue.arrayUnion([
        {
          "cantidad": "11",
          "hora": "17:00",
          "medicina": "jarabe",
          "periodo": "7",
        }
      ])
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

  Stream<List<UserData>> get users{
    return coleccionPacientes.snapshots().map(_listaUsuariosFromSnapshot);
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
      "idSuper":uid,
      "medicines": FieldValue.arrayUnion([
        {
          "medicina": medicina,
          "cantidad": "30",
          "hora": "18:00",
          "periodo": "5",
        },
        {
          "medicina": "medicina2",
          "cantidad": "15",
          "hora": "20:00",
          "periodo": "5",
        },
      ]),
      }
      );
}

}
