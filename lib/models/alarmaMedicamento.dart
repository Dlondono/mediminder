class AlarmaMedicamento{
    String medicamentoNombre;
    String descripcion;
    int cantidad;
    DateTime hora;
    int periodo;
    String idPaciente;
    int dosis;

    AlarmaMedicamento({this.medicamentoNombre,this.descripcion,this.cantidad,this.hora, this.periodo, this.idPaciente,this.dosis});
    setTime(DateTime t){
        this.hora = t;
    }
}