import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mediminder/models/paciente.dart';
import 'package:mediminder/models/userLocal.dart';
import 'package:mediminder/services/database.dart';
import 'package:mediminder/shared/constants.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class MedicamentoNuevo extends StatefulWidget {
  final Paciente paciente;
  MedicamentoNuevo({this.paciente});
  @override
  _MedicamentoNuevoState createState() => _MedicamentoNuevoState();
}

class _MedicamentoNuevoState extends State<MedicamentoNuevo> {
  Paciente _paciente;
  @override
  void initState() {
      _paciente = Paciente(id: this.widget.paciente.id, nombre: this.widget.paciente.nombre,
          idPaciente: this.widget.paciente.idPaciente);
      super.initState();
  }
  final _formKey=GlobalKey<FormState>();
  String _currentName;
  String _currentPeriodo;
  String _currentHora;
  String _currentCantidad;
  String _currentMinuto;
  String _currentRecomendacion;
  String _currentDosis;
  String _currentPrioridad;
  String _currentTipoHorario;
  int _veces;
  String _currentTipo;

  final List<String> prioridades=['1 - Prioridad máxima',
    '2 - Prioridad media','3 - Prioridad normal'];
  final List<String> horario=['Horas aproximadas','Por periodo'];
  final List<String> tipoMedicamento=['Pastilla','Jarabe'];
  final List<TimeOfDay> horas=[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(9, 111, 167, 50),
        title: Text('Nuevo medicamento'),
      ),
        body: SingleChildScrollView(
          child:  Container(
            padding: EdgeInsets.symmetric(vertical: 2.0.h, horizontal: 5.0.h),
            color: Color.fromRGBO(157, 221, 234, 50),
                        child: Form(
                          key: _formKey,
                          child: Row(
                            children:<Widget>[
                              Expanded(
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
                                  DropdownButtonFormField(
                                    value: _currentTipo ,
                                    items: tipoMedicamento.map((tipo) {
                                      return DropdownMenuItem(
                                        value: tipo,
                                        child:Text('$tipo'),
                                      );
                                    }).toList(),
                                    onChanged: (val) =>
                                        setState(() => _currentTipo = val),
                                    decoration: textInputDecoraton.copyWith(
                                        hintText: "Tipo medicamento"),
                                    validator: (val) =>
                                    val.isEmpty
                                        ? "Por favor seleccione un tipo"
                                        : null,
                                  ),
                                  SizedBox(height: 2.0.h),
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
                                  DropdownButtonFormField(
                                    value: _currentPrioridad ,
                                      items: prioridades.map((prior) {
                                        return DropdownMenuItem(
                                          value: prior,
                                          child:Text('$prior'),
                                        );
                                      }).toList(),
                                    onChanged: (val) =>
                                        setState(() => _currentPrioridad = val),
                                    decoration: textInputDecoraton.copyWith(
                                        hintText: "Prioridad"),
                                    validator: (val) =>
                                    val.isEmpty
                                        ? "Por favor seleccione una prioridad"
                                        : null,
                                  ),
                                  SizedBox(height: 2.0.h),
                                  TextFormField(
                                    keyboardType: TextInputType.number,
                                    decoration: textInputDecoraton.copyWith(
                                        hintText: "Cantidad disponible del medicamento"),
                                    validator: (val) =>
                                    val.isEmpty
                                        ? "Por favor ingrese un numero"
                                        : null,
                                    onChanged: (val) => setState(() => _currentCantidad = val),
                                  ),
                                  SizedBox(height: 2.0.h),
                                  TextFormField(
                                    decoration: textInputDecoraton.copyWith(hintText: "Recomendaciones del medicamento"),
                                    validator: (val) =>
                                    val.isEmpty
                                        ? "Por favor ingrese las recomendaciones del medicamento"
                                        : null,
                                    onChanged: (val) => setState(() => _currentRecomendacion = val),
                                  ),
                                  SizedBox(height: 2.0.h),
                                  TextFormField(
                                    keyboardType: TextInputType.number,
                                    decoration: textInputDecoraton.copyWith(hintText: "Dosis a tomar"),
                                    validator: (val) =>
                                    val.isEmpty
                                        ? "Por favor ingrese la dosis correspondiente"
                                        : null,
                                    onChanged: (val) => setState(() => _currentDosis = val),
                                  ),
                                  SizedBox(height: 2.0.h),
                                  DropdownButtonFormField(
                                    value: _currentTipoHorario ,
                                    items: horario.map((hor) {
                                      return DropdownMenuItem(
                                        value: hor,
                                        child:Text('$hor'),
                                      );
                                    }).toList(),
                                    onChanged: (val) =>
                                        setState(() => _currentTipoHorario = val),
                                    decoration: textInputDecoraton.copyWith(
                                        hintText: "Horario"),
                                    validator: (val) =>
                                    val.isEmpty
                                        ? "Por favor seleccione una opción"
                                        : null,
                                  ),
                                  SizedBox(height: 2.0.h),
                                  _nuevoDropdown(),
                                ],
                              ),
                            ),
                            ],
                          ),
                        ),
          ),
        ),
    );
  }
  Widget _nuevoDropdown() {
    if (_currentTipoHorario == 'Horas aproximadas') {
      return Container(
        child: Column(
          children:<Widget>[
            TextFormField(
            keyboardType: TextInputType.number,
            decoration: textInputDecoraton.copyWith(
                hintText: "Cuantas veces al dia"),
            validator: (val) =>
            val.isEmpty
                ? "Por favor ingrese el numero de veces que debe tomar el medicamento al dia"
                : null,
            onChanged: (val) => setState(() => _veces = int.parse(val)),
            ),
            SizedBox(height: 2.0.h),
            _forCampo(),
            ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color.fromRGBO(9, 111, 167, 50)),
                  foregroundColor: MaterialStateProperty.all(Colors.black),
                ),
                child: Text(
                  "Guardar medicamento",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  try {
                    if (_formKey.currentState.validate()) {
                      for (var hora in horas) {
                        await DatabaseService()
                            .addMedicine(
                          _currentName,
                          _paciente.idPaciente,
                          _currentCantidad,
                          hora.hour.toString(),
                          hora.minute.toString(),
                          "24",
                          _currentRecomendacion,
                          _currentDosis,
                          _currentPrioridad,
                          _currentTipo,
                          _currentTipoHorario,
                          _veces,
                        );
                      }
                      Navigator.pop(context);
                    }
                  }on FormatException catch(_){
                    final snackBar=SnackBar(content: Text("Error en el formato de numeros"));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                }
            ),
          ],
        ),

      );

    }else if(_currentTipoHorario=="Por periodo"){
      return Container(
        child: Column(
          children:<Widget>[
            ElevatedButton(
              child: Text("Seleccionar hora"),
              onPressed: _selectTim,
            ),
            TextFormField(
          decoration: textInputDecoraton.copyWith(hintText: "Cada cuanto debe tomar el medicamento"),
          validator: (val) =>
          val.isEmpty
          ? "Por favor ingrese periodo del medicamento" : null,
        onChanged: (val) => setState(() => _currentPeriodo = val),
            ),
        SizedBox(height: 2.0.h),
            ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color.fromRGBO(9, 111, 167, 50)),
                  foregroundColor: MaterialStateProperty.all(Colors.black),
                ),
                child: Text(
                  "Guardar medicamento",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  print(horas);
                  if(_formKey.currentState.validate()){
                    await DatabaseService()
                     .addMedicine(
                      _currentName,
                      _paciente.idPaciente,
                      _currentCantidad,
                      _currentHora,
                      _currentMinuto,
                      _currentPeriodo,
                      _currentRecomendacion,
                      _currentDosis,
                      _currentPrioridad,
                      _currentTipo,
                      _currentTipoHorario,
                      _veces,
                    );
                        Navigator.pop(context);
                  }
                }
            ),
          ],
        ),
      );
    }else{
      return Container(
        height: MediaQuery.of(context).size.height,
      );
    }
  }

  Widget _forCampo(){
    if(_veces!=null) {
      return Container(
        child: Column(
          children: <Widget>[
            for(int i=0;i<_veces;i++)
              ElevatedButton(
                child: Text("Seleccionar hora "+(i+1).toString()),
                onPressed:(){
                  _selectTime(i);

                },
              ),
              SizedBox(height: 2.0.h)
          ],
        ),
      );

    }else{
      return Container(
        color: Color.fromRGBO(157, 221, 234, 50),
        height: MediaQuery.of(context).size.height,
      );
    }
  }
  void _selectTime(int i) async{
    TimeOfDay _time=TimeOfDay(hour: 8, minute: 0);
    final TimeOfDay newTime=await showTimePicker(
        context: context,
        initialTime: _time,
    );
  if(newTime!=null){
    setState(() {
      _time=newTime;
      if(horas.isNotEmpty) {
        horas.removeAt(i);
      }
      horas.insert(i,_time);
    });
    }
  }
  void _selectTim() async{
    TimeOfDay _time=TimeOfDay(hour: 8, minute: 0);
    final TimeOfDay newTime=await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if(newTime!=null){
      setState(() {
        _time=newTime;
        _currentHora=_time.hour.toString();
        _currentMinuto=_time.minute.toString();
      });
    }
  }
}
