/*
   REGLAS DE INTEGRIDAD
   ====================
   Jugadores se relaciona con Clases: Jugadores.clase -> clases.codigo
   y con Puestos: Jugadores.puesto -> Puetos.codigo
   
   Se han creado las Foreign Key.
*/

drop database if exists Baloncesto;
create database if not exists Baloncesto;
use Baloncesto;

drop table if exists clases;
create table clases(
codigo char(3) primary key not null, /* Está formado por 3 letras mayúsculas, los únicos valores que puede tener este atributo son los que se han dado de alta */
grupo varchar(20) not null, /* Los únicos valores que puede tener este atributo son los que se han dado de alta */
nombre_tutor varchar(40), /* Los únicos valores que puede tener este atributo son los que se han dado de alta */
puntuacion int unsigned, /* Dos puntos por cada partido ganado*/
capitan char(7)
) engine = innodb;

drop table if exists puestos;
create table puestos( /* Los únicos registros que puede tener la tabla son los que se han dado de alta */
codigo tinyint unsigned  auto_increment key not null, /*  */
nombre varchar(10) not null, /* Los únicos valores que puede tener este atributo son los que se han dado de alta */
descripcion text null
) engine = innodb;

drop table if exists jugadores;
create table jugadores(
codalumno char(7) primary key not null,
nombre varchar(20) not null,
apellido varchar(20) not null,
tantos_marcados smallint unsigned default 0, 
puesto tinyint unsigned not null,
clase char(3) not null,
foreign key(clase) references clases(codigo)
on delete restrict
on update cascade,
foreign key(puesto) references puestos(codigo)
on delete restrict
on update cascade
) engine = innodb;





/* Las casas no pueden tener otro valor que no esté en esta relación */

insert into clases VALUES ("E1A","1 ESO A","FEDERICO PEREZ",6,"E1A137"),
                         ("E1B","1 ESO B","TERESA CANO",2,"E1B015"),
						 ("E2A","2 ESO A","JAVIER GONZALEZ",0,"E2A422"),
						 ("E2B","2 ESO B","PATRICIA SANCHEZ",4,"E2B327");

/* Las casas no pueden tener otro valor que no esté en esta relación */

insert into puestos set nombre = "BASE";   -- SON 1
insert into puestos set nombre = "ALERO";    -- SON 2
insert into puestos set nombre = "ALA-PIVOT";  -- SON 2
insert into puestos set nombre = "PIVOT";   -- SON 1
insert into puestos set nombre = "ESCOLTA";   -- SON 1

INSERT INTO jugadores VALUES ("E2A666","MEPHISTO","ROZCO",16,3,"E2A"),
                             ("E2A766","MERLIN","WIZARD",16,3,"E2A"),
                             ("E2A655","MORGANA","PENDRAGON",16,1,"E2A"),
                             ("E2A676","MELQUIADES","BUHO",20,2,"E2A"),
							               ("E2A686","GIOVANNI","BERTUCCIO",16,5,"E2A"),
							               ("E2A606","ANNA","KARENINA",16,1,"E2A"),
							               ("E2A696","AL","DEGEA",16,4,"E2A"),
                             ("E1A777","ALEPH","ONSO",16,3,"E1A"),
                             ("E1A666","OLGA","SCOTT",16,3,"E1A"),
                             ("E1A888","PAUVAR","ELA",16,1,"E1A"),
                             ("E1A776","MELVIN","SQUIRRELS",20,1,"E1A"),
							               ("E1A689","JOHNNY","BERTO",16,5,"E1A"),
							               ("E1A603","ENRIQUE","ALFARERO",16,2,"E1A"),
							               ("E1A016","ALBUS","DEKA",16,4,"E1A"),							               
							               ("E2B666","EMMET","BROWN",16,3,"E2B"),
                             ("E2B626","PHIL","LIP",16,3,"E2B"),
                             ("E2B636","LINUS","STROMBERG",16,1,"E2B"),
                             ("E2B676","PAUL","FONTOFTHE",20,2,"E2B"),
							               ("E2B686","ANGEL","BIGTABLES",16,5,"E2B"),
							               ("E2B606","OSKAR","KRUM",16,1,"E2B"),
							               ("E2B696","TITTO","LOPEZ",16,4,"E2B"),
							               ("E1B777","RUCH","WORTH",16,3,"E1B"),
                             ("E1B666","ALF","MELMAC",16,3,"E1B"),
                             ("E1B996","NAZARIUS","FLINT",16,1,"E1B"),
                             ("E1B776","MELVIN","MCFLY",20,2,"E1B"),
							               ("E1B689","LORDDARTH","VADER",16,1,"E1B"),
							               ("E1B603","DRACO","MALFOY",16,1,"E1B"),
							               ("E1B016","SEVERIUS","STUKA",16,4,"E1B");							 
