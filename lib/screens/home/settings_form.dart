import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mediminder/models/userLocal.dart';
import 'package:mediminder/services/database.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey=GlobalKey<FormState>();
  String _currentName;
  String _currentId;
  String _currentMeds;

  @override
  Widget build(BuildContext context) {
    final user=Provider.of<UserLocal>(context);
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
        UserData Datos=snapshot.data;
          return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text(
                  "Actualizar datos del paciente",
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  initialValue: Datos.nombre,
                  validator: (val) =>
                  val.isEmpty
                      ? "Por favor ingrese un nombre"
                      : null,
                  onChanged: (val) => setState(() => _currentName = val),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  initialValue: Datos.id,
                  validator: (val) =>
                  val.isEmpty
                      ? "Por favor ingrese la cedula del paciente"
                      : null,
                  onChanged: (val) => setState(() => _currentId = val),
                ),
                ElevatedButton(
                    child: Text(
                      "Actualizar",
                      style: TextStyle(color: Colors.black),

                    ),
                    onPressed: () async {
                      if(_formKey.currentState.validate()){
                        await DatabaseService(uid: user.uid).updateUserData(
                          _currentId ?? Datos.id,
                          _currentName ?? Datos.nombre,

                        );
                        Navigator.pop(context);
                      }
                    }
                ),

              ],
            ),
          );
        }else return null;
      }
    );
  }
}
