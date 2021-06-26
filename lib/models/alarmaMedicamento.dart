import 'package:flutter/material.dart';

class AlarmaMedicamento{
    String medicamentoNombre;
    String descripcion;
    int cantidad;
    DateTime hora;
    int periodo;
    String idPaciente;
    int dosis;
    String uid;
    int dia;
    int mes;
    int year;
    List<dynamic> listaHoras;

    AlarmaMedicamento({this.medicamentoNombre,this.descripcion,this.cantidad,
        this.hora, this.periodo, this.idPaciente,this.dosis,this.uid,
        this.dia,this.mes,this.year
    });
    AlarmaMedicamento.horas({this.medicamentoNombre,this.descripcion,this.cantidad,
        this.listaHoras, this.idPaciente,this.dosis,this.uid,
        this.dia,this.mes,this.year
    });
    setTime(DateTime t){
        this.hora = t;
    }
}