package gal.xunta.edu.app;

import com.fasterxml.jackson.databind.ObjectMapper;

/**
 * Hello world!
 *
 */
public class App {
  public static void main(String[] args) {
    // Cadena para probar Jackson.
    String json_str =
        "{\"nombre\":\"Manuel\",\"apellidos\":\"Piñeiro\",\"dni\":\"12345678\",\"fecha_nacimiento\":\"1990-01-01\"}";

    ObjectMapper mapper = new ObjectMapper();
    System.out.println("Hello World!");
  }
}
