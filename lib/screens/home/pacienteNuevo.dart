import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mediminder/models/userLocal.dart';
import '../../services/database.dart';
import '../../services/auth.dart';

class PacienteNuevo extends StatefulWidget {
  @override
  _PacienteNuevoState createState() => _PacienteNuevoState();
}

class _PacienteNuevoState extends State<PacienteNuevo> {
  final FirebaseAuth auth=FirebaseAuth.instance;
  final DatabaseService _database = DatabaseService();
  final AuthService _auth = AuthService();
    final _formKey= GlobalKey<FormState>();
    //text field para setState
    String nombre="";
    String cedula="";
    String medicamento="";
    String codigo="";
    String error="";
    String correo="";

    @override
    Widget build(BuildContext context) {
      final User user= auth.currentUser;
      final uid=user.uid;
      return Scaffold(
        //backgroundColor: Colors.blue[100],
        appBar: AppBar(
          backgroundColor: Colors.blue[600],
          elevation: 1.0,
          title: Text('Registro paciente?'),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                TextFormField(
                    decoration: InputDecoration(border: OutlineInputBorder(),
                        hintText: "Correo"
                    ),
                    validator: (val)=> val.isEmpty ? "Ingrese el correo de su paciente":null,
                    onChanged: (val){
                      setState(()=>correo=val);
                    }
                ),
                SizedBox(height: 20.0),
                TextFormField(
                    decoration: InputDecoration(border: OutlineInputBorder(),
                        hintText: "Nombre"
                    ),
                    validator: (val)=> val.isEmpty ? "Ingrese el nombre de su paciente":null,
                    onChanged: (val){
                      setState(()=>nombre=val);
                    }
                ),
                SizedBox(height: 20.0),
                TextFormField(
                    decoration: InputDecoration(border: OutlineInputBorder(),
                        hintText: "Cedula"
                    ),
                    validator: (val)=> val.isEmpty ? "Ingrese la cedula de su paciente":null,
                    onChanged: (val){
                      setState(()=>cedula=val);
                    }
                ),
                SizedBox(height: 20.0),
                TextFormField(
                    decoration: InputDecoration(border: OutlineInputBorder(),
                        hintText: "Clave"
                    ),
                    obscureText: true,
                    validator: (val)=> val.length<6 ? "El codigo de acceso debe ser mayor a 6 caracteres":null,
                    onChanged: (val){
                      setState(()=>codigo=val);
                    }
                ),

                SizedBox(height: 20.0),
                ElevatedButton(
                  child: Text("Agregar",
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () async{
                    if(_formKey.currentState.validate()){
                      dynamic result= await _auth.registerEmailPassP(correo, codigo,nombre,cedula);
                      UserLocal user = result;
                      print(user.uid);
                      _database.addPaciente(nombre, cedula,uid,user.uid);
                      Navigator.pop(context);
                    }
                  },
                ),
                SizedBox(height: 15.0),
                Text(
                  error,
                  style: TextStyle(color: Colors.red),
                )
              ],
            ),
          ),
        ),
      );
    }

}
