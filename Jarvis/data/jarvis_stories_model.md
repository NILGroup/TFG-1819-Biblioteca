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

## Generated Story 3005191058733942635
* consulta_libro
    - utter_especifica_libro
* consulta_libro_kw{"libro": "Harry Potter"}
    - slot{"libro": "Harry Potter"}
    - utter_libro_kw
* despedidas
    - utter_despedida

## Generated Story 3005191058733942636
* consulta_libro_kw{"libro": "Harry Potter"}
    - slot{"libro": "Harry Potter"}
    - utter_libro_kw

## Generated Story 3005191058733942637
* consulta_libros_kw{"libro": "Harry Potter"}
    - slot{"libro": "Harry Potter"}
    - utter_libros_kw

## Generated Story -3161024289020967059
* saludos
    - utter_saludo
* me_llamo{"persona": "Mauri"}
    - slot{"persona": "Mauri"}
    - utter_saludo_nombre
* quien_soy
    - utter_quien_soy
* despedidas
    - utter_despedida


## Generated Story 6991514439844087412
* saludos
    - utter_saludo
* consulta_libro_titulo_autor{"PER": "Ken Follet", "MISC": "Los Pilares de la Tierra", "autores": "ken follet"}
    - slot{"libro": "Los Pilares de la Tierra"}
    - slot{"autores": "ken follet"}
    - utter_libro_autor
* gracias
    - utter_gracias
* consulta_libros_autor{"autores": "Cervantes"}
    - slot{"autores": "Cervantes"}
    - utter_libros_autor
* despedidas
    - utter_despedida

## Generated Story -7529718647739239012
* consulta_localizacion{"localizacion": "biblioteca de ciencias pol\u00edticas"}
    - slot{"localizacion": "biblioteca de ciencias pol\u00edticas"}
    - utter_consulta_localizacion
* consulta_libros_kw{"libro": "matem\u00e1tica discreta"}
    - slot{"libro": "matem\u00e1tica discreta"}
    - utter_libros_kw
* mas_info_primero
    - utter_info_primero
* despedidas
    - utter_despedida

## Generated Story -6590527528298194299
* consulta_libros_kw{"PER": "Venancio Tomeo", "libro": "venancio tomeo"}
    - slot{"libro": "venancio tomeo"}
    - utter_libros_kw
* busca_mas
    - action_busca_mas

