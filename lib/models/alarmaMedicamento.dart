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
    String prioridad;
    int prio;
    String tipo;
    String tipoHorario;
    int veces;
    List<dynamic> listaHoras;
    //String uidDatabase;

    AlarmaMedicamento({this.medicamentoNombre,this.descripcion,this.cantidad,
        this.hora, this.periodo, this.idPaciente,this.dosis,this.uid,
        this.dia,this.mes,this.year,this.prioridad,this.prio,this.tipo,this.tipoHorario,this.veces
    });

    setTime(DateTime t){
        this.hora = t;
    }
}