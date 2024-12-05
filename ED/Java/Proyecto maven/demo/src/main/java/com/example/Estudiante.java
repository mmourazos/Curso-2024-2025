package com.example;

import java.text.DateFormat;

public class Estudiante {
  private String nombre;
  private String apellidos;
  private String dni;
  private Date fecha_nacimiento;

  public Estudiante(String nombre, String apellidos, String dni, String fecha_nacimiento) {
    this.nombre = nombre;
    this.apellidos = apellidos;
    this.dni = dni;
    this.fecha_nacimiento = new Date(DateFormat.getDateInstance().parse(fecha_nacimiento));
  };


  public String getNombre(){
    return this.nombre;
  }

  public String getApellidos(){
    return this.apellidos;
  }

  public String getDni(){
    return this.dni;
  }

  public String getFecha_nacimiento(){
    return DateFormat.getDateInstance().format(this.fecha_nacimiento);
  }

}
