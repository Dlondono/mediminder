import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mediminder/services/auth.dart';

import '../wrapper.dart';


class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey= GlobalKey<FormState>();
  //text field para setState
  String email="";
  String password="";
  String error="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.blue[100],
      appBar: AppBar(
        backgroundColor: Colors.blue[600],
        elevation: 1.0,
        title: Text('Mediminder'),
        actions: <Widget>[
          TextButton.icon(
            icon: Icon(Icons.person),
            label: Text("Registrarse"),
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
                  validator: (val)=> val.isEmpty ? "Ingrese su correo":null,
                  onChanged: (val){
                  setState(()=>email=val);
                }
              ),
              SizedBox(height: 20.0),
              TextFormField(
                obscureText: true,
                validator: (val)=> val.length<6 ? "Su clave debe ser mayor a 6 caracteres":null,
                onChanged:(val){
                  setState(() => password = val);
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                child: Text("Iniciar sesion",
                style: TextStyle(color: Colors.black),
              ),
                onPressed: () async{
                  if(_formKey.currentState.validate()){
                    dynamic result= await _auth.signInEmailPass(email, password);
                    if(result==null){
                      setState(()=>error="Correo o clave no validos");
                    }
                    else{
                      Wrapper();
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
