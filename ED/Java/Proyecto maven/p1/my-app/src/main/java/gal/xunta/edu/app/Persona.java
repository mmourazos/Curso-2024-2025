package gal.xunta.edu.app;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class Persona {
    private String nombre;
    private String apellidos;
    private String dni;
    private Date fecha_nacimiento;

    public Persona(String nombre, String apellidos, String dni, String fecha_nacimiento) {
        SimpleDateFormat df = new SimpleDateFormat("dd-mm-YYYY");

        this.nombre = nombre;
        this.apellidos = apellidos;
        this.dni = dni;
        try {
            this.fecha_nacimiento = df.parse(fecha_nacimiento);
        } catch (ParseException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }
}
