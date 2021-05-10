import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mediminder/models/paciente.dart';
import 'package:mediminder/models/userLocal.dart';
import 'package:mediminder/services/database.dart';
import 'package:mediminder/shared/constants.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

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
      //backgroundColor: Color.fromRGBO(157, 221, 234, 50),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(9, 111, 167, 50),
        title: Text('Nuevo medicamento'),
      ),
      //body: SingleChildScrollView(
        body: Container(
          //children:<Widget> [
            //Container(
              padding: EdgeInsets.symmetric(vertical: 2.0.h, horizontal: 5.0.h),
              color: Color.fromRGBO(157, 221, 234, 50),
              child: StreamBuilder<UserData>(
                  stream: DatabaseService(uid: user.uid).userData,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
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
                            SizedBox(height: 3.0.h),
                            TextFormField(
                              decoration: textInputDecoraton.copyWith(hintText: "Nombre del medicamento"),
                              //initialValue: _paciente.nombre,
                              validator: (val) =>
                              val.isEmpty
                                  ? "Por favor ingrese un nombre"
                                  : null,
                              onChanged: (val) => setState(() => _currentName = val),
                            ),
                            SizedBox(height: 2.0.h),
                            TextFormField(
                              decoration: textInputDecoraton.copyWith(hintText: "Cantidad disponible del medicamento"),
                              validator: (val) =>
                              val.isEmpty
                                  ? "Por favor ingrese una unidad"
                                  : null,
                              onChanged: (val) => setState(() => _currentCantidad = val),
                            ),
                            SizedBox(height: 2.0.h),
                            TextFormField(
                              decoration: textInputDecoraton.copyWith(hintText: "Hora del medicamento"),
                              validator: (val) =>
                              val.isEmpty
                                  ? "Por favor ingrese la hora del medicamento"
                                  : null,
                              onChanged: (val) => setState(() => _currentHora = val),
                            ),
                            SizedBox(height: 2.0.h),
                            TextFormField(
                              decoration: textInputDecoraton.copyWith(hintText: "Minuto del medicamento"),
                              validator: (val) =>
                              val.isEmpty
                                  ? "Por favor ingrese la hora del medicamento"
                                  : null,
                              onChanged: (val) => setState(() => _currentMinuto = val),
                            ),
                            SizedBox(height: 2.0.h),
                            TextFormField(
                              decoration: textInputDecoraton.copyWith(hintText: "Cada cuanto debe tomar el medicamento"),
                              validator: (val) =>
                              val.isEmpty
                                  ? "Por favor ingrese periodo del medicamento"
                                  : null,
                              onChanged: (val) => setState(() => _currentPeriodo = val),
                            ),
                            SizedBox(height: 2.0.h),
                            ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(Color.fromRGBO(9, 111, 167, 50)),
                                  foregroundColor: MaterialStateProperty.all(Colors.black),
                                ),
                                child: Text(
                                  "Actualizar",
                                  style: TextStyle(color: Colors.white),
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
           // ),
          //],
        ),
      //),
    );
  }
}
