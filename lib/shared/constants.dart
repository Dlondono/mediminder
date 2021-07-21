import 'package:flutter/material.dart';

const textInputDecoraton=InputDecoration(

  border: OutlineInputBorder(),
  hintStyle: TextStyle(color: Colors.black),
  fillColor: Colors.white,
  filled: true,
  enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white,width: 2.0)
  ),
  focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black,width: 2.0)
  ),
);

class Validator extends StatefulWidget {
  String validarDato(String s){
    String msg;
    try{
      int num = int.parse(s);
      msg = null;
    } on FormatException catch(_){
      msg = "Por favor ingrese los datos correctamente";
    }
    return msg;
  }
  @override
  _ValidatorState createState() => _ValidatorState();

}

class _ValidatorState extends State<Validator> {

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
