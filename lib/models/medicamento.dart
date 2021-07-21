import 'package:flutter/material.dart';

class Medicamento{
  final String medicamentoNombre;
  final String idPaciente;
  int cantidad;
  int hora;
  int minuto;
  int periodo;
  final String recomendacion;
  final int dosis;
  final String uid;
  List<dynamic> listaHorasMed;
  int dia;
  int mes;
  int year;
  String tipo;
  String tipoHorario;
  int veces;
  String prioridad;
  int prio;

  Medicamento({this.medicamentoNombre,this.idPaciente,this.cantidad,
    this.hora,this.minuto,this.periodo, this.recomendacion, this.dosis,this.uid,
    this.dia,this.mes,this.year,this.prioridad,this.prio,this.tipo,this.tipoHorario,this.veces
  });

  setTime(int h, int m){
    hora = h;
    minuto = m;
  }

}