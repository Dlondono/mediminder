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

  Medicamento({this.medicamentoNombre,this.idPaciente,this.cantidad,
    this.hora,this.minuto,this.periodo, this.recomendacion, this.dosis,this.uid,
    this.dia,this.mes,this.year});

  Medicamento.horas({this.medicamentoNombre,this.idPaciente,this.cantidad,
    this.listaHorasMed,this.recomendacion, this.dosis,this.uid,
    this.dia,this.mes,this.year});

  setTime(int h, int m){
    hora = h;
    minuto = m;
  }

}