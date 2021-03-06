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
  String error="";
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
  Validator validator = new Validator();

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
                                    onChanged: (val) {
                                      setState(() => _currentTipo = val);
                                      FocusScope.of(context).requestFocus(new FocusNode());
                                    },
                                    decoration: textInputDecoraton.copyWith(
                                        hintText: "Tipo medicamento"),
                                    validator: (val) =>
                                    val.isEmpty
                                        ? "Por favor seleccione un tipo"
                                        : null,
                                  ),
                                  SizedBox(height: 2.0.h),
                                  TextFormField(
                                    textInputAction: TextInputAction.next,
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
                                    onChanged: (val) {
                                        setState(() => _currentPrioridad = val);
                                      FocusScope.of(context).requestFocus(new FocusNode());
                                      },
                                    decoration: textInputDecoraton.copyWith(
                                        hintText: "Prioridad"),
                                    validator: (val) =>
                                    val.isEmpty
                                        ? "Por favor seleccione una prioridad"
                                        : null,
                                  ),
                                  SizedBox(height: 2.0.h),
                                  _formCantidad(),
                                  TextFormField(
                                    maxLines: null,
                                    textInputAction: TextInputAction.next,
                                    decoration: textInputDecoraton.copyWith(
                                        hintText: "Recomendaciones del medicamento",
                                    hintMaxLines: 2 ),
                                    validator: (val) =>
                                    val.isEmpty
                                        ? "Por favor ingrese las recomendaciones del medicamento"
                                        : null,
                                    onChanged: (val) => setState(() => _currentRecomendacion = val),
                                  ),
                                  SizedBox(height: 2.0.h),
                                  _formDosis(),
                                  DropdownButtonFormField(
                                    value: _currentTipoHorario ,
                                    items: horario.map((hor) {
                                      return DropdownMenuItem(
                                        value: hor,
                                        child:Text('$hor'),
                                      );
                                    }).toList(),
                                    onChanged: (val) {
                                        setState(() => _currentTipoHorario = val);
                                        FocusScope.of(context).requestFocus(new FocusNode());
                                        },
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
              textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            decoration: textInputDecoraton.copyWith(
                hintText: "Cuantas veces al dia"),
            validator: (val) =>
                validator.validarDato(val),
            onChanged: (val) => setState(() => _veces = int.parse(val)),
            ),
            SizedBox(height: 2.0.h),
            _forCampo(),
            Text(
              error,
              style: TextStyle(color: Colors.red),
            ),
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
                  if(horas.length==0||horas.length==null){
                    setState(()=>error="Por favor seleccione al menos 1 hora");
                  }
                    if (_formKey.currentState.validate()&&horas.length!=0) {
                      setState(() {
                        error="";
                      });
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
              onPressed:() {
                _selectTim();
                FocusScope.of(context).requestFocus(new FocusNode());
              },
            ),
            TextFormField(
              textInputAction: TextInputAction.next,
          keyboardType: TextInputType.number,
          decoration: textInputDecoraton.copyWith(hintText: "Cada cuanto debe tomar el medicamento (horas)",
          hintMaxLines: 2),
          validator: (val) =>
              validator.validarDato(val),
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
                  }else{
                    setState(() {
                      error="Por favor corrija los datos";
                    });
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
  Widget _formCantidad(){
    if(_currentTipo=="Pastilla"){
      return Container(
        child: Column(
          children: [
            TextFormField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              decoration: textInputDecoraton.copyWith(
                  hintText: "Cantidad disponible de pastillas"),
              validator: (val) =>
                  validator.validarDato(val),
              onChanged: (val) => setState(() => _currentCantidad = val),
            ),
            SizedBox(height: 2.0.h),
          ],
        ),
      );
    }else if (_currentTipo=="Jarabe"){
      return Container(
        child: Column(
          children: [
            TextFormField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              decoration: textInputDecoraton.copyWith(
                  hintText: "Cantidad disponible en mililitros"),
              validator: (val) =>
                  validator.validarDato(val),
              onChanged: (val) => setState(() => _currentCantidad = val),
            ),
            SizedBox(height: 2.0.h),
          ],
        ),
      );
    }
    else return Container(
      );
  }
  Widget _formDosis(){
    if(_currentTipo=="Pastilla"){
      return Container(
        child: Column(
          children: [
            TextFormField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              decoration: textInputDecoraton.copyWith(
                  hintText: "Cuantas pastillas debe tomar por dosis",
              hintMaxLines: 2),
              validator: (val) =>
                  validator.validarDato(val),
              onChanged: (val) => setState(() => _currentDosis = val),
            ),
            SizedBox(height: 2.0.h),
          ],
        ),
      );
    }else if (_currentTipo=="Jarabe"){
      return Container(
        child: Column(
          children: [
            TextFormField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              decoration: textInputDecoraton.copyWith(hintText: "Dosis a tomar en mililitros"),
              validator: (val) =>
                  validator.validarDato(val),
              onChanged: (val) => setState(() => _currentDosis = val),
            ),
            SizedBox(height: 2.0.h),
          ],
        ),
      );
    }
    else return Container(
      );
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
                  FocusScope.of(context).requestFocus(new FocusNode());
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
      horas.add(_time);
      error="";
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
        error="";
      });
    }else{
      setState(() {
        error="null";
      });
    }
  }
}
