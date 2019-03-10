## Conversacion simple
* saludos
    - utter_saludo
* me_llamo{"persona":"Susana"}
    -utter_saludo_nombre
* despedidas
    - utter_despedida
    
## Solo hola
* saludos
    - utter_saludo
* me_llamo{"persona":"Susana"}
    -utter_saludo_nombre
    
## Conversacion estandar catálogo libros
* saludos
    - utter_saludo
* me_llamo{"persona":"Susana"}
    -utter_saludo_nombre
* quien_soy
    - utter_quien_soy
* consulta_catalogo_libros
    - utter_consulta_catalogo_libros
* despedidas
    - utter_despedida
* busca_libro
    - action_busca_libro
    ##- slot{"libros":[{"titulo":"asadasdasd"}]}
    
## Conversacion estandar localización
* saludos
    - utter_saludo
* me_llamo{"persona":"Susana"}
    -utter_saludo_nombre
* quien_soy
    - utter_quien_soy
* consulta_localizacion
    ##- slot{"localizacion":[{"lugar":"Zambrano"}]}
    - utter_consulta_localizacion
* despedidas
    - utter_despedida

## Conversacion estandar teléfono
* saludos
    - utter_saludo
* me_llamo{"persona":"Susana"}
    -utter_saludo_nombre
* consulta_telefono
    - slot{"localizacion":"Zambrano"}
    - utter_consulta_telefono
* despedidas
    - utter_despedida


## Conversacion estandar horarios abiertas
* saludos
    - utter_saludo
* me_llamo{"persona":"Susana"}
    -utter_saludo_nombre
* consulta_horario_open
    - slot{"localizacion":"Zambrano"}
    - utter_consulta_horario_abierto
* despedidas
    - utter_despedida

## Conversacion estandar horarios cerradas
* saludos
    - utter_saludo
* me_llamo{"persona":"Susana"}
    -utter_saludo_nombre
* consulta_horario_close
    - slot{"localizacion":"Zambrano"}
    - utter_consulta_horario_cerrado
* despedidas
    - utter_despedida