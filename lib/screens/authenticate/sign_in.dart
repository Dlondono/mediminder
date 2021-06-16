import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mediminder/screens/home/home.dart';
import 'package:mediminder/services/auth.dart';
import 'package:mediminder/shared/constants.dart';

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
        backgroundColor: Color.fromRGBO(9, 111, 167, 50),
        elevation: 1.0,
        title: Text('Mediminder'),
        actions: <Widget>[
          TextButton.icon(
            icon: Icon(Icons.person),
            label: Text("Registrarse"),
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(Colors.white),
            ),
            onPressed: (){
              widget.toggleView();
          },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(color: Color.fromRGBO(157, 221, 234, 50)),
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                TextFormField(
                    decoration: textInputDecoraton.copyWith(hintText: "Correo"),
                    validator: (val)=> val.isEmpty ? "Ingrese su correo":null,
                    onChanged: (val){
                    setState(()=>email=val);
                  }
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: textInputDecoraton.copyWith(hintText: "Clave"),
                  obscureText: true,
                  validator: (val)=> val.length<6 ? "Su clave debe ser mayor a 6 caracteres":null,
                  onChanged:(val){
                    setState(() => password = val);
                  },
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Color.fromRGBO(9, 111, 167, 50)),
                  ),
                  child: Text("Iniciar sesión",
                    style: TextStyle(color: Colors.white,fontSize: 16),
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
      ),
    );
  }
}
