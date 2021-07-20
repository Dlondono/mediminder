import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mediminder/models/userLocal.dart';
import 'package:mediminder/screens/home/InterfazSupervisor.dart';
import 'package:mediminder/screens/home/ListaPacientes.dart';
import 'package:mediminder/shared/constants.dart';
import '../../services/database.dart';
import '../../services/auth.dart';
import 'package:sizer/sizer.dart';

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
      bool loading=false;
      final User user= auth.currentUser;
      final uidActual=user.uid;
      return Scaffold(
        //backgroundColor: Colors.teal[100],
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(9, 111, 167, 50),
          elevation: 1.0,
          title: Text('Nuevo paciente'),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            color: Color.fromRGBO(157, 221, 234, 50),
            padding: EdgeInsets.symmetric(vertical: 1.0.h, horizontal: 5.0.h),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20.0),
                  TextFormField(
                      decoration: textInputDecoraton.copyWith(hintText: "Correo"),
                      validator: (val)=> val.isEmpty ? "Ingrese el correo de su paciente":null,
                      onChanged: (val){
                        setState(()=>correo=val);
                      }
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                      decoration: textInputDecoraton.copyWith(hintText: "Nombre"),
                      validator: (val)=> val.isEmpty ? "Ingrese el nombre de su paciente":null,
                      onChanged: (val){
                        setState(()=>nombre=val);
                      }
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                      decoration: textInputDecoraton.copyWith(hintText: "Cedula"),
                      validator: (val)=> val.isEmpty ? "Ingrese la cedula de su paciente":null,
                      onChanged: (val){
                        setState(()=>cedula=val);
                      }
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                      decoration: textInputDecoraton.copyWith(hintText: "Clave"),
                      obscureText: true,
                      validator: (val)=> val.length<6 ? "El codigo de acceso debe ser mayor a 6 caracteres":null,
                      onChanged: (val){
                        setState(()=>codigo=val);
                      }
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Color.fromRGBO(9, 111, 167, 50)),
                        ),
                        child: Text("Agregar",
                          style: TextStyle(color: Colors.white,fontSize: 16),
                        ),
                        onPressed: () async{
                          if(_formKey.currentState.validate()){
                            setState(() {
                              loading=true;
                            });
                            dynamic result= await _auth.registerEmailPassP
                              (correo, codigo,nombre,cedula);
                            if(result==null){
                              setState(() {
                                loading=false;
                                error="error";

                              });
                            }
                            UserLocal user = result;
                            _database.addPaciente(nombre, cedula,uidActual,user.uid);
                            Navigator.pushReplacement(context, MaterialPageRoute(
                                builder: (context)=> InterfazSupervisor()));
                          }
                        },
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Color.fromRGBO(9, 111, 167, 50)),
                        ),
                        child: Text(
                          "Cancelar",style: TextStyle(color: Colors.white,fontSize: 16),
                      ),onPressed:() {
                        Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context)=> InterfazSupervisor()));
                      },
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }

}
