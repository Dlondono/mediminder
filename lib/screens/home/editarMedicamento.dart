import 'package:flutter/material.dart';
import 'package:mediminder/models/alarmaMedicamento.dart';
import 'package:mediminder/models/paciente.dart';
import 'package:mediminder/models/userLocal.dart';
import 'package:mediminder/services/database.dart';
import 'package:mediminder/shared/constants.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class editarMedicamento extends StatefulWidget {
  final AlarmaMedicamento medicamento;
  editarMedicamento({this.medicamento});

  @override
  _editarMedicamentoState createState() => _editarMedicamentoState();
}

class _editarMedicamentoState extends State<editarMedicamento> {
  AlarmaMedicamento medicamento;
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
  void initState() {
    medicamento = AlarmaMedicamento(medicamentoNombre:this.widget.medicamento.medicamentoNombre,
      descripcion:this.widget.medicamento.descripcion,cantidad:this.widget.medicamento.cantidad,
      hora:this.widget.medicamento.hora,periodo: this.widget.medicamento.periodo,
      idPaciente:this.widget.medicamento.idPaciente,dosis:this.widget.medicamento.dosis,
      uid:this.widget.medicamento.uid,dia: this.widget.medicamento.dia,
      mes:this.widget.medicamento.mes,year:this.widget.medicamento.year,
        tipo: this.widget.medicamento.tipo,tipoHorario: this.widget.medicamento.tipoHorario,
      veces: this.widget.medicamento.veces,prioridad: this.widget.medicamento.prioridad,
    );
    setInitialData(medicamento);
    super.initState();
  }
  Widget build(BuildContext context) {
    //setInitialData(medicamento);
    final user=Provider.of<UserLocal>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Editar "+widget.medicamento.medicamentoNombre,style: TextStyle(
          fontSize: 22.0,
           ),
        ),
        backgroundColor: Color.fromRGBO(9, 111, 167, 50),
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
                              SizedBox(height: 3.0.h),
                              DropdownButtonFormField(
                                value: _currentTipo??medicamento.tipo ,
                                items: tipoMedicamento.map((tipo) {
                                  return DropdownMenuItem(
                                    value: tipo,
                                    child:Text('$tipo'),
                                  );
                                }).toList(),
                                onChanged: (val) =>
                                    setState(() => _currentTipo = val),
                                decoration: textInputDecoraton.copyWith(
                                    hintText: medicamento.tipo.toString()),
                                validator: (val) =>
                                val.isEmpty
                                    ? "Por favor seleccione un tipo"
                                    : null,
                              ),
                              SizedBox(height: 2.0.h),
                              TextFormField(
                                initialValue: medicamento.medicamentoNombre,
                                decoration: textInputDecoraton.copyWith(hintText: "Nombre del medicamento"),
                                validator: (val) =>
                                val.isEmpty
                                    ? "Por favor ingrese un nombre"
                                    : null,
                                onChanged: (val) => setState(() => _currentName = val),
                              ),
                              SizedBox(height: 2.0.h),
                              DropdownButtonFormField(
                                value: _currentPrioridad??medicamento.prioridad,
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
                                initialValue: medicamento.cantidad.toString(),
                                keyboardType: TextInputType.number,
                                decoration: textInputDecoraton.copyWith(hintText: "Cantidad disponible del medicamento"),
                                validator: (val) =>
                                val.isEmpty
                                    ? "Por favor ingrese una unidad"
                                    : null,
                                onChanged: (val) => setState(() => _currentCantidad = val),
                              ),
                              SizedBox(height: 2.0.h),
                              TextFormField(
                                initialValue: medicamento.descripcion,
                                decoration: textInputDecoraton.copyWith(hintText: "Recomendaciones del medicamento"),
                                validator: (val) =>
                                val.isEmpty
                                    ? "Por favor ingrese las recomendaciones del medicamento"
                                    : null,
                                onChanged: (val) => setState(() => _currentRecomendacion = val),
                              ),
                              SizedBox(height: 2.0.h),
                              TextFormField(
                                initialValue: medicamento.dosis.toString(),
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
                                value: _currentTipoHorario??medicamento.tipoHorario ,
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
    if (_currentTipoHorario== 'Horas aproximadas') {
      return Container(
        child: Column(
          children:<Widget>[
            TextFormField(
              initialValue: _veces.toString()??medicamento.veces.toString(),
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
                  print(horas);
                  if(_formKey.currentState.validate()){
                    for(var hora in horas) {
                      await DatabaseService()
                          .editMedicine(
                        _currentName,
                        medicamento.idPaciente,
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
                        medicamento.uid
                      );
                    }
                    Navigator.pop(context);
                  }
                }
            ),
          ],
        ),
      );

    }else if(_currentTipoHorario=="Por periodo"||medicamento.tipoHorario =="Por periodo"){
      return Container(
        child: Column(
          children:<Widget>[
            ElevatedButton(
              child: Text("Seleccionar hora"),
              onPressed: _selectTim,
            ),
            SizedBox(height: 2.0.h),
            TextFormField(
              initialValue: _currentPeriodo??medicamento.periodo.toString(),
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
                  if(_formKey.currentState.validate()){
                    print(medicamento.uid+"medicamento uid en editar");
                    print(_currentName);
                    await DatabaseService()
                        .editMedicine(
                        _currentName??medicamento.medicamentoNombre,
                      medicamento.idPaciente,
                      _currentCantidad??medicamento.cantidad.toString(),
                      _currentHora??medicamento.hora.hour.toString(),
                      _currentMinuto??medicamento.hora.minute.toString(),
                      _currentPeriodo??medicamento.periodo.toString(),
                      _currentRecomendacion??medicamento.descripcion.toString(),
                      _currentDosis??medicamento.dosis.toString(),
                      _currentPrioridad??medicamento.prioridad,
                      _currentTipo??medicamento.tipo,
                      _currentTipoHorario??medicamento.tipoHorario,
                      _veces??medicamento.veces,
                      medicamento.uid
                    );
                    Navigator.pop(context);
                  }
                }
            ),
          ],
        ),
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
                onPressed:()=> _selectTime(i),
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
  void setInitialData(AlarmaMedicamento medicamento){
    _currentName=medicamento.medicamentoNombre;
    _currentPeriodo=medicamento.periodo.toString();
    _currentHora=medicamento.hora.hour.toString();
    _currentCantidad=medicamento.cantidad.toString();
    _currentMinuto=medicamento.hora.minute.toString();
    _currentRecomendacion=medicamento.descripcion;
    _currentDosis=medicamento.dosis.toString();
    _currentPrioridad=medicamento.prioridad;
    _currentTipoHorario=medicamento.tipoHorario;
    _currentTipo=medicamento.tipo;
    print(medicamento.medicamentoNombre.toString()+"medi.tipo");
    print(_currentRecomendacion.toString()+"current");
    _veces=medicamento.veces;
  }
}
