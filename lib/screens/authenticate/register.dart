import 'package:flutter/material.dart';
import 'package:mediminder/services/auth.dart';
class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey= GlobalKey<FormState>();
  //text field para setState
  String email="";
  String password="";
  String nombre="";
  String id="";
  String error="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.blue[100],
      appBar: AppBar(
        backgroundColor: Colors.blue[600],
        elevation: 1.0,
        title: Text('Registro supervisor?'),
        actions: <Widget>[
          TextButton.icon(
            icon: Icon(Icons.person),
            label: Text("Iniciar sesion"),
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(Colors.black),
            ),
            onPressed: (){
              widget.toggleView();
            },
          )
        ],
      ),
      body: Container(
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
                validator: (val)=> val.isEmpty ? "Ingrese su correo":null,
                  onChanged: (val){
                    setState(()=>email=val);
                  }
              ),
              SizedBox(height: 20.0),
              TextFormField(
                  decoration: InputDecoration(border: OutlineInputBorder(),
                      hintText: "Nombre"
                  ),
                  validator: (val)=> val.isEmpty ? "Nombre":null,
                  onChanged: (val){
                    setState(()=>nombre=val);
                  }
              ),
              SizedBox(height: 20.0),
              TextFormField(
                  decoration: InputDecoration(border: OutlineInputBorder(),
                      hintText: "Identificacion"
                  ),
                  validator: (val)=> val.isEmpty ? "Identificacion":null,
                  onChanged: (val){
                    setState(()=>id=val);
                  }
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: InputDecoration(border: OutlineInputBorder(),
                    hintText: "Clave "
                ),
                obscureText: true,
                validator: (val)=> val.length<6 ? "Su clave debe ser mayor a 6 caracteres":null,
                onChanged:(val){
                  setState(() => password = val);
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                child: Text("Registrarse",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () async{
                  if(_formKey.currentState.validate()){
                    dynamic result= await _auth.registerEmailPass(email, password,nombre,id);
                    if(result==null){
                      setState(()=>error="Correo o clave no validos");
                    }
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
