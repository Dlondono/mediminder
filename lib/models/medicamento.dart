class Medicamento{
  final String medicamentoNombre;
  final String idPaciente;
  int cantidad;
  int hora;
  int minuto;
  final int periodo;
  final String recomendacion;
  final int dosis;
  final String uid;

  Medicamento({this.medicamentoNombre,this.idPaciente,this.cantidad,
    this.hora,this.minuto,this.periodo, this.recomendacion, this.dosis,this.uid});
  setTime(int h, int m){
    hora = h;
    minuto = m;
  }

}