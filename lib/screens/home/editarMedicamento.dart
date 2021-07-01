import 'package:flutter/material.dart';
import 'package:mediminder/models/alarmaMedicamento.dart';
import 'package:sizer/sizer.dart';

class editarMedicamento extends StatelessWidget {
  final AlarmaMedicamento medicamento;
  editarMedicamento({this.medicamento});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Editar "+medicamento.medicamentoNombre,style: TextStyle(
          fontSize: 22.0,
           ),
        ),
        backgroundColor: Color.fromRGBO(9, 111, 167, 50),
      ),
      body: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(157, 221, 234, 50)),
        child: Column(
          children: <Widget>[
            Card(
              margin: EdgeInsets.symmetric(vertical: 2.0.h, horizontal: 3.0.h),
              child: ListTile(
                //contentPadding: ,
                leading: Icon(Icons.medical_services),
                title: Text(medicamento.medicamentoNombre,
                    style: TextStyle(fontSize: 22,color: Colors.black)),
                subtitle: Text(medicamento.hora.hour.toString().padLeft(2, '0')
                    +":"+ medicamento.hora.minute.toString().padLeft(2, '0')
                    +"\n"+"Cantidad: "+this.medicamento.cantidad.toString()+"\n"+"\n"+medicamento.descripcion,
                    style: TextStyle(fontSize: 20,color: Colors.black)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
