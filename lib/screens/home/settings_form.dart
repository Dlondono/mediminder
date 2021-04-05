import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey=GlobalKey<FormState>();
  final List<String> medicamentos=["acetaminofen","aspirina"];

  String _currentName;
  String _currentId;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children:<Widget> [
          Text(
            "Actualizar datos del paciente",
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 20.0),
          TextFormField(
            validator: (val)=> val.isEmpty?"Por favor ingrese un nombre":null,
            onChanged: (val)=>setState(()=>_currentName=val),
          ),
          SizedBox(height: 20.0),
          TextFormField(
            validator: (val)=> val.isEmpty?"Por favor ingrese la cedula del paciente":null,
            onChanged: (val)=>setState(()=>_currentId=val),
          ),
          ElevatedButton(
            child: Text(
              "Actualizar",
              style: TextStyle(color: Colors.black),

            ),
            onPressed: ()async{
              print(_currentName);
              print(_currentId);
            }
          ),

        ],
      ),
    );
  }
}
