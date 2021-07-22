import 'dart:ui';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mediminder/screens/home/home.dart';
import 'package:mediminder/services/auth.dart';
import 'package:mediminder/shared/constants.dart';
import 'package:mediminder/shared/loading.dart';
import 'package:sizer/sizer.dart';
import '../wrapper.dart';



class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool loading=false;
  final AuthService _auth = AuthService();
  final _formKey= GlobalKey<FormState>();
  //text field para setState
  String email="";
  String password="";
  String error="";
  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      //backgroundColor: Colors.blue[100],
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(9, 111, 167, 50),
        elevation: 15.0,

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
                SizedBox(height: 4.0.h),
                RichText(
                  text: TextSpan(
                      text: "Mediminder",
                      style: TextStyle(
                          fontSize: 30,color: Colors.black,fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,fontFamily:"Roboto",letterSpacing: 3
                      ),
                  ),
                ),
                SizedBox(height: 10.0.h),
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
                      loading=true;
                      dynamic result= await _auth.signInEmailPass(email, password);
                      if(result==null){
                        setState(()=>error="Correo o clave no validos");
                        loading=false;
                      }
                      else{
                        Wrapper();
                      }
                    }
                  },
                ),
                SizedBox(height: 2.0.h),
                Text(
                  error,
                  style: TextStyle(color: Colors.red),
                ),RichText(
                  text: TextSpan(
                      text: "No tiene una cuenta? \n",
                    style: TextStyle(
                        fontSize: 18,color: Colors.black
                    ),
                    children: <TextSpan>[
                      TextSpan(text: 'Registrese aca',
                      style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue.shade800),
                        recognizer: TapGestureRecognizer()..onTap=(){
                          widget.toggleView();
                        }

                      ),
                    ]
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
