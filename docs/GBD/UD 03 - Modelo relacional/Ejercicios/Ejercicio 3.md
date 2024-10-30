# Ejercicio 3

<!-- toc -->

- [Enunciado](#enunciado)
- [Entidades y atributos](#entidades-y-atributos)
- [Diagrama entidad-relación](#diagrama-entidad-relacion)

<!-- tocstop -->

## Enunciado

Se desea diseñar la base de datos de un Instituto. En la base de datos se desea guardar los datos de los **profesores** del Instituto (<ins>DNI, nombre, dirección y teléfono</ins>). Los **profesores** _imparten_ **módulos**, y cada **módulo** tiene un <ins>código y un nombre</ins>. Cada **alumno** está _matriculado_ en uno o varios **módulos**. De cada **alumno** se desea guardar el <ins>nº de expediente, nombre, apellidos y fecha de nacimiento</ins>. Los **profesores** pueden _impartir_ varios **módulos**, pero un **módulo** sólo puede ser _impartido_ por un **profesor**. Un curso tiene varios módulos y cada curso (código de curso) se _organiza_ en uno o más grupo de alumnos, uno de los cuales es el delegado del grupo.

## Entidades y atributos

Lista de entidades y sus atributos:

* **Profesor**
  * DNI
  * Nombre
  * Dirección
  * teléfono
* **Módulo**
  * Código
  * Nombre
* **Alumno**
  * Nº de expediente
  * Nombre
  * Apellidos
  * Fecha de nacimiento
* **Curso**
  * Código de curso
* **Grupo**
  * Letra

## Diagrama entidad-relación

```mermaid
erDiagram

Profesor {
  string DNI pk
  string Nombre
  string Direccion
  int Telefono
 }

Modulo {
  string Codigo pk
  string Nombre
}

Alumno {
  int NExpediente pk
  string Nombre
  string Apellidos
  date FechaDeNacimiento
}

Profesor ||--o{ Modulo : Imparte

Alumno }|--|{ Modulo : Matriculado

Modulo }|--|| Curso : Organiza

Curso ||--o{ Grupo : Organiza

Curso {
  string CodigoCurso pk
}

Grupo {
  string Letra pk
  string codigoCurso pk,fk
  int NExpedienteDelegado fk
}

Alumno ||--o| Grupo : Delegado

Alumno }|--|{ Grupo : Pertenece
```

## Modelo relacional / tablas

Lista de tablas (relaciones) y sus atributos (claves primarias subrayadas y foráneas en cursiva):

* **Profesor** con atributos DNI (clave primaria), Nombre, Dirección, Teléfono
* **Modulo** Código (clave primaria), Nombre, DNI Profesor (clave foránea), Código de curso (clave foránea).

* **Profesor** (<ins>DNI</ins>, Nombre, Dirección, Teléfono)
* **Modulo** (<ins>Código</ins>, Nombre, _DNI Profesor_, _Código de curso_)
* **Alumno** (<ins>Nº de expediente</ins>, Nombre, Apellidos, Fecha de nacimiento)
* **Curso** (<ins>Código de curso</ins>)
* **Grupo** (<ins>Letra</ins>, <ins>_Código de curso_</ins>, _Nº de expediente delegado_)

* **Matricula** (<ins>_Nº de expediente_</ins>, <ins>_Código_</ins>)
* **Pertenece a grupo** (<ins>_Nº de expediente_</ins>, <ins>_Letra_</ins><ins>, _Código de curso_</ins>)

```mermaid
erDiagram

Profesor {
  string DNI pk
  string Nombre
  string Direccion
  int Telefono
 }

Modulo {
  string Codigo pk
  string Nombre
  string DNIProfesor fk
  string CodCurso fk
 }

Alumno {
  int NExpediente pk
  string Nombre
  string Apellidos
  date FechaDeNacimiento
}

Profesor ||--o{ Modulo : Imparte

Alumno ||--|{ Matricula : Tiene

Matricula }|--|| Modulo : Tiene

Modulo }|--|| Curso : Organiza

Curso ||--o{ Grupo : Organiza

Curso {
  string CodigoCurso pk
}

Grupo {
  string Letra pk
  string CodigoCurso pk,fk
  int NExpedienteDelegado fk
}

Alumno ||--o| Grupo : Delegado

Alumno ||--|{ PerteneceAGrupo: Esta

Grupo ||--|{ PerteneceAGrupo: Contiene

Matricula {
  int NExpediente pk, fk
  string CodModulo pk, fk 
}

PerteneceAGrupo {
  int NExpediente pk, fk
  string Letra pk, fk
  string CodCurso pk, fk
}
```
