import 'package:flutter/material.dart';
import 'package:mediminder/models/informes.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';

class InformeDiseno extends StatelessWidget {
  final Informe informe;
  InformeDiseno({this.informe});
  String fecha;
  void formatoFecha(){
    fecha=informe.fecha.toString();
    if(fecha!=null){
      fecha=fecha.substring(0,fecha.length-7);
    }
  }
  @override
  Widget build(BuildContext context) {
    formatoFecha();
    return  Padding(
      padding: EdgeInsets.symmetric(vertical: 1.0.h, horizontal: 1.0.h),
      child: GestureDetector(//padding
        onTap: (){
        },
        child: Card(
          color: Color.fromRGBO(255, 255, 255, 50),
          margin: EdgeInsets.symmetric(vertical: 1.0.h, horizontal: 3.0.h),
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text(informe.nombreMedicamento+ "\n" +informe.delay+" horas tarde" "\n"
                    +fecha,
                    style: TextStyle(fontSize: 20,color: Colors.black)),
                ),

            ],
          ),
        ),
      ),
    );
  }
}
