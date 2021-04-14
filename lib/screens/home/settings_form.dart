import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mediminder/models/paciente.dart';
import 'package:mediminder/models/userLocal.dart';
import 'package:mediminder/services/database.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  final Paciente paciente;
  SettingsForm({this.paciente});
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  Paciente _paciente;
  @override
  void initState() {
      _paciente = Paciente(id: this.widget.paciente.id);
      super.initState();
  }

  final _formKey=GlobalKey<FormState>();
  String _currentName;
  String _currentId;
  String _currentMeds;
  String _currentUid;

  @override
  Widget build(BuildContext context) {
    final user=Provider.of<UserLocal>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData Datos=snapshot.data;
            _currentUid = Datos.uid;
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
                    decoration: InputDecoration(border: OutlineInputBorder(),
                    hintText: "Nombre del paciente"
                    ),
                    initialValue: _paciente.nombre,
                    validator: (val) =>
                    val.isEmpty
                        ? "Por favor ingrese un nombre"
                        : null,
                    onChanged: (val) => setState(() => _currentName = val),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: InputDecoration(border: OutlineInputBorder(),
                      hintText: "Id del paciente"
                    ),
                    initialValue: _paciente.id,
                    validator: (val) =>
                    val.isEmpty
                        ? "Por favor ingrese la cedula del paciente"
                        : null,
                    onChanged: (val) => setState(() => _currentId = val),
                  ),
                  TextFormField(
                    decoration: InputDecoration(border: OutlineInputBorder(),
                        hintText: "Medicina del paciente"
                    ),
                    initialValue: _paciente.medicina,
                    validator: (val) =>
                    val.isEmpty
                        ? "Por favor ingrese la cedula del paciente"
                        : null,
                    onChanged: (val) => setState(() => _currentMeds = val),
                  ),
                  ElevatedButton(
                      child: Text(
                        "Actualizar",
                        style: TextStyle(color: Colors.black),

                      ),
                      onPressed: () async {
                        if(_formKey.currentState.validate()){
                         /* await DatabaseService(uid:  _paciente.id).updatePacienteData(
                            _currentId ?? _paciente.id,
                            _currentName ?? _paciente.nombre,
                            //_currentMeds ?? _paciente.medicina,
                            _currentUid ?? _paciente.idSuper,
                          ); */
                          await DatabaseService(uid: _paciente.id).addMedicine(_paciente.id);
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
