# Tarea 3: Modelo entidad-relación: App de recetas

Representa utilizando el diagrama de entidad-relación (notación Crow's Foot) el siguiente caso:

Estamos desarrollando una aplicación de móvil que funciona como un libro de recetas. La aplicación permitirá, entre otras cosas, filtrar recetas por ingredientes. De cada receta se desea guardar su nombre, una descripción, los ingredientes, el tiempo de preparación y el tiempo de cocinado. También se desea saber las calorías de cada receta, para lo que hemos de conocer también la cantidad de cada ingrediente. La aplicación también desea guardar la fecha en la que el usuario registre la realización de una receta, para que puea llevar un control de las recetas que ha preparado y cuando. De este modo se podrá ver cuántas veces se ha realizado cada receta. Finalmente el usuario podrá guardar notas asociadas a las recetas que ha preparado.

*Crea las entidades y atributos que consideres necesarias y las relaciones entre ellas. No tienen porque aparecer explícitamente en el enunciado.*


```mermaid
erDiagram
    RECETA {
        int id PK
        string nombre
        string descripcion
        int tiempo_preparacion
        int tiempo_cocinado
    }
    
    INGREDIENTE {
        int id PK
        string nombre
        float calorias_gramo
    }
    
    RECETA_INGREDIENTE {
        int id_receta FK
        int id_ingrediente FK
        float cantidad
    }
    
    USUARIO {
        int id PK
        string nombre
        string email
    }
    
    REGISTRO {
        int id PK
        int id_usuario FK
        int id_receta FK
        date fecha
        string notas
    }
    
    RECETA ||--o{ RECETA_INGREDIENTE : contiene
    INGREDIENTE ||--o{ RECETA_INGREDIENTE : es_usado_en
    USUARIO ||--o{ REGISTRO : realiza
    RECETA ||--o{ REGISTRO : es_registrada

