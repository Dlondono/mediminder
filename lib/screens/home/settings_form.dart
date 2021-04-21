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
      _paciente = Paciente(id: this.widget.paciente.id, nombre: this.widget.paciente.nombre, idPaciente: this.widget.paciente.idPaciente);
      super.initState();
  }

  final _formKey=GlobalKey<FormState>();
  String _currentName;
  String _currentPeriodo;
  String _currentHora;
  String _currentCantidad;
  String _currentMinuto;

  @override
  Widget build(BuildContext context) {
    final user=Provider.of<UserLocal>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[600],

        title: Text('Nuevo medicamento'),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<UserData>(
            stream: DatabaseService(uid: user.uid).userData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                UserData Datos=snapshot.data;
                return Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Text(
                        _paciente.nombre,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration: InputDecoration(border: OutlineInputBorder(),
                        hintText: "Nombre del medicamento"
                        ),
                        //initialValue: _paciente.nombre,
                        validator: (val) =>
                        val.isEmpty
                            ? "Por favor ingrese un nombre"
                            : null,
                        onChanged: (val) => setState(() => _currentName = val),
                      ),
                      TextFormField(
                        decoration: InputDecoration(border: OutlineInputBorder(),
                            hintText: "Unidades del medicamento"
                        ),
                        validator: (val) =>
                        val.isEmpty
                            ? "Por favor ingrese una unidad"
                            : null,
                        onChanged: (val) => setState(() => _currentCantidad = val),
                      ),
                      TextFormField(
                        decoration: InputDecoration(border: OutlineInputBorder(),
                            hintText: "Hora del medicamento"
                        ),
                        //initialValue: _paciente.medicina,
                        validator: (val) =>
                        val.isEmpty
                            ? "Por favor ingrese la hora del medicamento"
                            : null,
                        onChanged: (val) => setState(() => _currentHora = val),
                      ),
                      TextFormField(
                        decoration: InputDecoration(border: OutlineInputBorder(),
                            hintText: "Minuto para tomar el medicamento"
                        ),
                        validator: (val) =>
                        val.isEmpty
                            ? "Por favor ingrese la hora del medicamento"
                            : null,
                        onChanged: (val) => setState(() => _currentMinuto = val),
                      ),
                      TextFormField(
                        decoration: InputDecoration(border: OutlineInputBorder(),
                            hintText: "Cada cuanto debe tomar el medicamento"
                        ),
                        validator: (val) =>
                        val.isEmpty
                            ? "Por favor ingrese periodo del medicamento"
                            : null,
                        onChanged: (val) => setState(() => _currentPeriodo = val),
                      ),
                      ElevatedButton(
                          child: Text(
                            "Actualizar",
                            style: TextStyle(color: Colors.black),

                          ),
                          onPressed: () async {
                            if(_formKey.currentState.validate()){
                              await DatabaseService()
                                  .addMedicine(_currentName,_paciente.idPaciente,_currentCantidad,_currentHora,_currentMinuto,_currentPeriodo);
                              Navigator.pop(context);
                            }
                          }
                      ),

                    ],
                  ),
                );
              }else return null;
            }
        ),
      ),
    );
  }
}
