import 'package:flutter/material.dart';
import 'package:mediminder/models/alarmaMedicamento.dart';
import 'package:mediminder/models/paciente.dart';
import 'package:mediminder/models/userLocal.dart';
import 'package:mediminder/screens/home/InterfazSupervisor.dart';
import 'package:mediminder/services/database.dart';
import 'package:mediminder/shared/constants.dart';
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
  int _prio;
  Validator validator = new Validator();

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
        prio: this.widget.medicamento.prio
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
        actions: <Widget>[
          TextButton.icon(
              icon: Icon(Icons.delete),
              label: Text("Borrar"),
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(Colors.white),
            ),
            onPressed: (){
                showDialog(
                    context: context,
                    builder:(context)=>AlertDialog(title: Text("Eliminar medicamento"),
                      content: Text("¿Desea borrar el medicamento?"),
                      actions: <Widget>[
                        ElevatedButton(
                          child: Text("Si"),
                          onPressed: ()async{
                            await DatabaseService().borrarMedicamento(widget.medicamento.uid);
                            Navigator.pop(context);
                            Navigator.pushReplacement(context, MaterialPageRoute(
                                builder: (context)=> InterfazSupervisor()));
                          },
                        ),
                        ElevatedButton(
                          child: Text("Cancelar"),
                        onPressed: (){
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                );
            },
          )
        ],
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
                                    validator.validarDato(val),
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
                              _formDosis(),
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
  Widget _formDosis(){
    if(_currentTipo=="Pastilla"){
      return Container(
        child: TextFormField(
          initialValue: medicamento.dosis.toString(),
          keyboardType: TextInputType.number,
          decoration: textInputDecoraton.copyWith
            (hintText: "Cuantas pastillas debe tomar por dosis"),
          validator: (val) =>
              validator.validarDato(val),
          onChanged: (val) => setState(() => _currentDosis = val),
        ),
      );
    }else if (_currentTipo=="Jarabe"){
      return Container(
        child: TextFormField(
          initialValue: medicamento.dosis.toString(),
          keyboardType: TextInputType.number,
          decoration: textInputDecoraton.copyWith(hintText: "Dosis a tomar en mililitros"),
          validator: (val) =>
              validator.validarDato(val),
          onChanged: (val) => setState(() => _currentDosis = val),
        ),
      );
    }
    else return Container(
      );
  }

  Widget _nuevoDropdown() {
    if(_currentPeriodo!=null){
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
                  if(_formKey.currentState.validate()){
                    print(medicamento.uid+"medicamento uid en editar");
                    print(_currentName+"name");
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
                      medicamento.uid,
                      _prio,
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
    _veces=medicamento.veces;
    _prio=medicamento.prio;
  }
}
