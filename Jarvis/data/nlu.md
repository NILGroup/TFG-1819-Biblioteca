## intent:como_estas
- qué tal
- cómo estás
- qué te pasa
- qué te ocurre
- estás bien
- cómo te sientes
- hola, que tal
- hola, que tal estas hoy
- hola, como estas hoy

## intent:consulta_horario_close
- está cerrada la [Biblioteca de medicina](localizacion)
- está cerrada ahora mismo la [Zambrano](localizacion)
- cierra hoy la [Biblioteca de Matem￿áticas](localizacion)
- me puedes decir si cierra hoy la [Biblioteca de Matem￿áticas](localizacion)
- me puedes decir si est￿á cerrada la [Biblioteca de Matem￿áticas](localizacion)
- me puedes decir si est￿á cerrada hoy la [Biblioteca de Matem￿áticas](localizacion)
- me puedes decir si est￿á cerrada ahora la [Biblioteca de Matem￿áticas](localizacion)
- me podrias decir si est￿á cerrada la [Biblioteca de Matem￿áticas](localizacion)
- me podrias decir si est￿á cerrada hoy la [Biblioteca de Matem￿áticas](localizacion)
- me podrias decir si est￿á cerrada ahora la [Biblioteca de Matem￿áticas](localizacion)

## intent:consulta_horario_general
- cuándo abre la [Facultad de geología](localizacion)
- cuándo cierra la [Zambrano](localizacion)
- cuándo está abierta la [Biblioteca de Educaci￿ón](localizacion)
- cuándo está cerrada la [Biblioteca de Arquitectura](localizacion)
- a qué hora abre la [Biblioteca de informática](localizacion)
- a qué hora cierra la [Biblioteca de Filosof￿ía](localizacion)
- a que hora la [Biblioteca Zambrano](localizacion:biblioteca zambrano) abre
- a que hora la [Biblioteca Zambrano](localizacion:biblioteca zambrano) cierra
- cuál es el horario de [Zambrano](localizacion)
- me puedes decir el horario de la [Biblioteca de Geograf￿ía](localizacion)
- me podrias decir el horario de la [Biblioteca de Geograf￿ía](localizacion)
- horario de la [Zambrano](localizacion)
- a que hora abre la [biblioteca de informatica](localizacion)
- a que hora abre la [biblioteca](localizacion) [zambrano](localizacion)
- a que hora abre la [biblioteca de Psicologia](localizacion)

## intent:consulta_horario_open
- está abierta la [Biblioteca de medicina](localizacion)
- está abierta ahora mismo la [Zambrano](localizacion)
- abre hoy la [Biblioteca de Matem￿áticas](localizacion)
- me puedes decir si abre hoy la [Biblioteca de Matem￿áticas](localizacion)
- me puedes decir si est￿á abierta la [Biblioteca de Matem￿áticas](localizacion)
- me puedes decir si est￿á abierta hoy la [Biblioteca de Matem￿áticas](localizacion)
- me puedes decir si est￿á abierta ahora la [Biblioteca de Matem￿áticas](localizacion)
- me podrias decir si est￿á abierta la [Biblioteca de Matem￿áticas](localizacion)
- me podrias decir si est￿á abierta hoy la [Biblioteca de Matem￿áticas](localizacion)
- me podrias decir si est￿á abierta ahora la [Biblioteca de Matem￿áticas](localizacion)

## intent:consulta_libro
- busca un libro
- quiero un libro
- me podrías decir un libro
- dime un libro
- dame un libro
- necesito un libro
- busca una obra literaria
- me buscarías una obra literaria
- necesito una obra literaria
- libro
- quiero un libro

## intent:consulta_libro_autor
- quiero un libro escrito por [Orwell](autores)
- busca un libro del autor [Orwell](autores)
- busca un libro de la autora [J K Rowling](autores)
- busca un único libro del autor [Orwell](autores)
- busca un único libro de la autora [J K Rowling](autores)
- busca un libro escrito por [Francisco de Quevedo](autores)
- quiero un libro del autor [Pablo Neruda](autores)
- quiero un libro de la autora [Ana María Matute](autores)
- quiero un único libro del autor [Pablo Neruda](autores)
- quiero un único libro de la autora [Ana María Matute](autores)
- me podrías decir un libro del autores [Gabriel García Márquez](autores)
- me podrías decir un libro de la autora [Isabel Allende](autores)
- me podrías decir un libro escrito por [Isaac Asimov](autores)
- necesito una obra literaria del autor [Alberto Verdejo](PER)
- necesito una obra literaria del autor [Alberto Verdejo](autores)
- busca una obra literaria escrita por [Rafael Caballero](autores)
- necesito un libro del autores [Orwell](autores)
- libro escrito por [George R Martin](autores)
- libro del autores [George R Martin](autores)
- libro de la autora [George R Martin](autores)
- quiero un libro escrito por [Orwell](PER)
- busca un libro del autor [Orwell](PER)
- busca un libro de la autora [J K Rowling](PER)
- busca un único libro del autor [Orwell](PER)
- busca un único libro de la autora [J K Rowling](PER)
- busca un libro escrito por [Francisco de Quevedo](PER)
- quiero un libro del autor [Pablo Neruda](PER)
- quiero un libro de la autora [Ana María Matute](PER)
- quiero un único libro del autor [Pablo Neruda](PER)
- quiero un único libro de la autora [Ana María Matute](PER)
- me podrías decir un libro del autores [Gabriel García Márquez](PER)
- me podrías decir un libro de la autora [Isabel Allende](PER)
- me podrías decir un libro escrito por [Isaac Asimov](PER)
- necesito una obra literaria del autor [Alberto Verdejo](PER)
- necesito una obra literaria del autor [Alberto Verdejo](PER)
- busca una obra literaria escrita por [Rafael Caballero](PER)
- necesito un libro del autores [Orwell](PER)
- libro escrito por [George R Martin](PER)
- libro del autores [George R Martin](PER)
- libro de la autora [George R Martin](PER)
- /consulta_libro_autor[{"autores":"Góngora"}](autores:Góngora)
- /consulta_libro_autor[{"PER":"Góngora", "autores":"Góngora}](autores:Góngora)[{"PER":"Góngora", "autores":"Góngora}](PER:Góngora)
- /consulta_libro_autor[{"PER":"Jose Garcia"}](PER:Jose Garcia)

## intent:consulta_libro_kw
- busca un libro de [Fuego y Sangre](libro)
- busco un único libro de [Matemática Discreta](libro)
- quiero un libro de [Harry Potter](libro)
- quiero un único libro de [Harry Potter](libro)
- busca un libro de [Historia del arte](libro)
- dame un libro de [recetas](libro)
- me podrías decir un libro de [economía](libro)
- me podrías dar un libro de [economía](libro)
- necesito un libro de [Carlos Fuentes](libro)
- busca libro de [Fuego y Sangre](libro)
- busco libro de [Matemática Discreta](libro)
- quiero libro de [Harry Potter](libro)
- busca libro de [Historia del arte](libro)
- dame libro de [recetas](libro)
- me podrías libro de [economía](libro)
- me podrías dar libro de [economía](libro)
- necesito un libro de [Carlos Fuentes](libro)
- busca una obra literaria de [medicina](libro)
- necesito una obra literaria de [Lo que el viento se llevó](libro)
- libro de [Juego de Tronos](libro)
- busca un libro de [Fuego y Sangre](MISC)
- busco un único libro de [Matemática Discreta](MISC)
- quiero un libro de [Harry Potter](MISC)
- quiero un único libro de [Harry Potter](MISC)
- busca un libro de [Historia del arte](MISC)
- dame un libro de [recetas](MISC)
- me podrías decir un libro de [economía](MISC)
- me podrías dar un libro de [economía](MISC)
- necesito un libro de [Carlos Fuentes](PER)
- busca libro de [Fuego y Sangre](MISC)
- busco libro de [Matemática Discreta](MISC)
- quiero libro de [Harry Potter](MISC)
- busca libro de [Historia del arte](MISC)
- dame libro de [recetas](MISC)
- me podrías libro de [economía](MISC)
- me podrías dar libro de [economía](MISC)
- necesito un libro de [Carlos Fuentes](MISC)
- busca una obra literaria de [medicina](MISC)
- necesito una obra literaria de [Lo que el viento se llevó](MISC)
- libro de [Juego de Tronos](MISC)
- /consulta_libro_kw[{"libro":"Topotamadre"}](libro:Topotamadre)
- /consulta_libro_kw[{"autores":"Benito Pérez-Galdos"}](autores:Benito Pérez-Galdos)
- /consulta_libro_kw[{"autores":"Quevedo"}](autores:Quevedo)
- /consulta_libro_kw[{"libro":"Harry Potter"}](libro:Harry Potter)
- /consulta_libro_kw[{"libro":"Matemática Discreta y Lógica"}](libro:Matemática Discreta y Lógica)
- /consulta_libro_kw[{"libro":"Campeones"}](libro:Campeones)

## intent:consulta_libro_kw_autor
- busco un libro de [El Quijote](libro) del autor [Miguel de Cervantes](autores)
- busco un libro de [Yo, Julia](libro)) escrito por [Santiago Posteguillo](autores)
- busco un libro de [El Quijote](libro) del autor [Miguel de Cervantes](autores)
- busco un libro de [Yo, Julia](libro) escrito por [Santiago Posteguillo](autores)
- quiero un libro de [El Quijote](libro) del autor [Miguel de Cervantes](autores)
- quiero un libro de [Yo, Julia](libro) escrito por [Santiago Posteguillo](autores)
- me podrías decir un libro de [Luces de bohemia](libro) escrito por [Ramón de Valle-Inclán](autores)
- me podrías decir un libro de [Luces de bohemia](libro) del autor [Ramón de Valle-Inclán](autores)
- me podrías decir un libro de [Luces de bohemia](libro) de la autora [Ramón de Valle-Inclán](autores)
- necesito una obra literaria de [Harry Potter y la cámara secreta](libro) de la autora [J K Rowling](autores)
- necesito una obra literaria de [Harry Potter y la cámara secreta](libro) del autores [J K Rowling](autores)
- necesito una obra literaria de [Harry Potter y la cámara secreta](libro) escrita por [J K Rowling](autores)
- libro de [Harry Potter y la cámara secreta](libro) escrita por [J K Rowling](autores)
- busco un libro de [El Quijote](MISC) del autor [Miguel de Cervantes](autores)
- busco un libro de [Yo, Julia](MISC)) escrito por [Santiago Posteguillo](autores)
- busco un libro de [El Quijote](MISC) del autor [Miguel de Cervantes](autores)
- busco un libro de [Yo, Julia](MISC) escrito por [Santiago Posteguillo](autores)
- quiero un libro de [El Quijote](MISC) del autor [Miguel de Cervantes](autores)
- quiero un libro de [Yo, Julia](MISC) escrito por [Santiago Posteguillo](autores)
- me podrías decir un libro de [Luces de bohemia](MISC) escrito por [Ramón de Valle-Inclán](autores)
- me podrías decir un libro de [Luces de bohemia](MISC) del autor [Ramón de Valle-Inclán](autores)
- me podrías decir un libro de [Luces de bohemia](MISC) de la autora [Ramón de Valle-Inclán](autores)
- necesito una obra literaria de [Harry Potter y la cámara secreta](MISC) de la autora [J K Rowling](autores)
- necesito una obra literaria de [Harry Potter y la cámara secreta](MISC) del autores [J K Rowling](autores)
- necesito una obra literaria de [Harry Potter y la cámara secreta](MISC) escrita por [J K Rowling](autores)
- libro de [Harry Potter y la cámara secreta](MISC) escrita por [J K Rowling](autores)
- busco un libro de [El Quijote](MISC) del autor [Miguel de Cervantes](PER)
- busco un libro de [Yo, Julia](MISC)) escrito por [Santiago Posteguillo](PER)
- busco un libro de [El Quijote](MISC) del autor [Miguel de Cervantes](PER)
- busco un libro de [Yo, Julia](MISC) escrito por [Santiago Posteguillo](PER)
- quiero un libro de [El Quijote](MISC) del autor [Miguel de Cervantes](PER)
- quiero un libro de [Yo, Julia](MISC) escrito por [Santiago Posteguillo](PER)
- me podrías decir un libro de [Luces de bohemia](MISC) escrito por [Ramón de Valle-Inclán](PER)
- me podrías decir un libro de [Luces de bohemia](MISC) del autor [Ramón de Valle-Inclán](PER)
- me podrías decir un libro de [Luces de bohemia](MISC) de la autora [Ramón de Valle-Inclán](PER)
- necesito una obra literaria de [Harry Potter y la cámara secreta](MISC) de la autora [J K Rowling](PER)
- necesito una obra literaria de [Harry Potter y la cámara secreta](MISC) del autores [J K Rowling](PER)
- necesito una obra literaria de [Harry Potter y la cámara secreta](MISC) escrita por [J K Rowling](PER)
- libro de [Harry Potter y la cámara secreta](MISC) escrita por [J K Rowling](PER)
- /consulta_libro_kw_autor[{"libro":"RSA, de lo mejor lo superior", "autores":"Programador experto"}](libro:RSA, de lo mejor lo superior)[{"libro":"RSA, de lo mejor lo superior", "autores":"Programador experto"}](autores:Programador experto)
- /consulta_libro_kw_autor[{"MISC":"RSA de lo mejor lo superior", "autores":"Programador experto"}](MISC:RSA de lo mejor lo superior)[{"libro":"RSA de lo mejor lo superior", "autores":"Programador experto"}](autores:Programador experto)

## intent:consulta_libro_titulo
- quiero un libro llamado [El Quijote](libro)
- quiero un único libro llamado [El Quijote](libro)
- busco un libro llamado [Narnia](libro)
- busco un único libro llamado [Narnia](libro)
- quiero un libro titulado [Yo, Julia](libro)
- quiero un libro llamado [Narnia la travesía del viajero del alba](libro)
- me podrías decir un libro llamado [Luces de bohemia](libro)
- dime libro titulado [Mortadelo y Filemón](libro)
- dime un libro titulado [Mortadelo y Filemón](libro)
- dime un libro llamado [Mortadelo y Filemón](libro)
- necesito una obra literaria llamada [Lo que el viento se llevó](libro)
- busca una obra literaria llamada [1984](libro))
- necesito un libro titulado [Preludio a la fundación](libro)
- libro llamado [Juego de Tronos](libro)
- libro titulado [Juego de Tronos](libro)
- buscame un libro llamado [El amor en tiempos de colera](libro)
- quiero un libro llamado [El Quijote](MISC)
- quiero un único libro llamado [El Quijote](MISC)
- busco un libro llamado [Narnia](MISC)
- busco un único libro llamado [Narnia](MISC)
- quiero un libro titulado [Yo, Julia](MISC)
- quiero un libro llamado [Narnia la travesía del viajero del alba](MISC)
- me podrías decir un libro llamado [Luces de bohemia](MISC)
- dime libro titulado [Mortadelo y Filemón](MISC)
- dime un libro titulado [Mortadelo y Filemón](MISC)
- dime un libro llamado [Mortadelo y Filemón](MISC)
- necesito una obra literaria llamada [Lo que el viento se llevó](MISC)
- busca una obra literaria llamada [1984](MISC))
- necesito un libro titulado [Preludio a la fundación](MISC)
- libro llamado [Juego de Tronos](MISC)
- libro titulado [Juego de Tronos](MISC)
- quiero un libro llamado [Harry Potter](MISC)[](libro:harry potter)
- /consulta_libro_titulo[{"libro":"Luces de Bohemia"}](libro:Luces de Bohemia)
- /consulta_libro_titulo[{"MISC":"Luces de Bohemia"}](MISC:Luces de Bohemia)

## intent:consulta_libro_titulo_autor
- busca un libro llamado [El Quijote](libro) del autor [Miguel de Cervantes](autores)
- busca un libro llamado [Yo, Julia](libro) escrito por [Santiago Posteguillo](autores)
- busca un libro llamado [El Quijote](libro) del autor [Miguel de Cervantes](autores)
- busca un libro llamado [Yo, Julia](libro) escrito por [Santiago Posteguillo](autores)
- quiero un libro llamado [El Quijote](libro) del autores [Miguel de Cervantes](autores)
- quiero un libro llamado [Yo, Julia](libro) escrito por [Santiago Posteguillo](autores)
- me podrías decir un libro llamado [Luces de bohemia](libro) escrito por [Ramón de Valle-Inclán](autores)
- me podrías decir un libro llamado [Luces de bohemia](libro) del autor [Ramón de Valle-Inclán](autores)
- me podrías decir un libro llamado [Luces de bohemia](libro) de la autora [Ramón de Valle-Inclán](autores)
- necesito una obra literaria llamada [Harry Potter y la cámara secreta](libro) de la autora [J K Rowling](autores)
- necesito una obra literaria llamada [Harry Potter y la cámara secreta](libro) del autor [J K Rowling](autores)
- necesito una obra literaria llamada [Harry Potter y la cámara secreta](libro) escrita por [J K Rowling](autores)
- libros llamado [Harry Potter y la cámara secreta](libro) escritas por [J K Rowling](autores)
- serías tan amable de buscarme un único libro llamado [Los Pilares de la Tierra](libro) del autor [Ken Follet](autores)
- busca un libro llamado [El Quijote](libro) del autor [Miguel de Cervantes](PER)
- busca un libro llamado [Yo, Julia](libro) escrito por [Santiago Posteguillo](PER)
- busca un libro llamado [El Quijote](libro) del autor [Miguel de Cervantes](PER)
- busca un libro llamado [Yo, Julia](libro) escrito por [Santiago Posteguillo](PER)
- quiero un libro llamado [El Quijote](libro) del autores [Miguel de Cervantes](PER)
- quiero un libro llamado [Yo, Julia](libro) escrito por [Santiago Posteguillo](PER)
- me podrías decir un libro llamado [Luces de bohemia](libro) escrito por [Ramón de Valle-Inclán](PER)
- me podrías decir un libro llamado [Luces de bohemia](libro) del autor [Ramón de Valle-Inclán](PER)
- me podrías decir un libro llamado [Luces de bohemia](libro) de la autora [Ramón de Valle-Inclán](PER)
- necesito una obra literaria llamada [Harry Potter y la cámara secreta](libro) de la autora [J K Rowling](PER)
- necesito una obra literaria llamada [Harry Potter y la cámara secreta](libro) del autor [J K Rowling](PER)
- necesito una obra literaria llamada [Harry Potter y la cámara secreta](libro) escrita por [J K Rowling](PER)
- libros llamado [Harry Potter y la cámara secreta](libro) escritas por [J K Rowling](PER)
- serías tan amable de buscarme un único libro llamado [Los Pilares de la Tierra](libro) del autor [Ken Follet](PER)
- busca un libro llamado [El Quijote](MISC) del autor [Miguel de Cervantes](PER)
- busca un libro llamado [Yo, Julia](MISC) escrito por [Santiago Posteguillo](PER)
- busca un libro llamado [El Quijote](MISC) del autor [Miguel de Cervantes](PER)
- busca un libro llamado [Yo, Julia](MISC) escrito por [Santiago Posteguillo](PER)
- quiero un libro llamado [El Quijote](MISC) del autores [Miguel de Cervantes](PER)
- quiero un libro llamado [Yo, Julia](MISC) escrito por [Santiago Posteguillo](PER)
- me podrías decir un libro llamado [Luces de bohemia](MISC) escrito por [Ramón de Valle-Inclán](PER)
- me podrías decir un libro llamado [Luces de bohemia](MISC) del autor [Ramón de Valle-Inclán](PER)
- me podrías decir un libro llamado [Luces de bohemia](MISC) de la autora [Ramón de Valle-Inclán](PER)
- necesito una obra literaria llamada [Harry Potter y la cámara secreta](MISC) de la autora [J K Rowling](PER)
- necesito una obra literaria llamada [Harry Potter y la cámara secreta](MISC) del autor [J K Rowling](PER)
- necesito una obra literaria llamada [Harry Potter y la cámara secreta](MISC) escrita por [J K Rowling](PER)
- libros llamado [Harry Potter y la cámara secreta](MISC) escritas por [J K Rowling](PER)
- serías tan amable de buscarme un único libro llamado [Los Pilares de la Tierra](MISC) del autor [Ken Follet](PER)
- /consulta_libro_titulo_autor[{"libro":"Don Quijote de la Mancha","autores":"Miguel de Cervantes"}](libro:Don Quijote de la Mancha)[{"libro":"Don Quijote de la Mancha","autores":"Miguel de Cervantes"}](autores:Miguel de Cervantes)
- /consulta_libro_titulo_autor[{"MISC":"Don Quijote de la Mancha","autores":"Miguel de Cervantes"}](MISC:Don Quijote de la Mancha)[{"libro":"Don Quijote de la Mancha","autores":"Miguel de Cervantes"}](autores:Miguel de Cervantes)

## intent:consulta_libros_autor
- quiero libros escritos por [Orwell](autores)
- busca libros del autor [Orwell](autores)
- busca libros de la autora [J K Rowling](autores)
- busca libros del autor [Orwell](autores)
- busca libros de la autora [J K Rowling](autores)
- busca libros escritos por [Francisco de Quevedo](autores)
- quiero libros del autor [Pablo Neruda](autores)
- quiero libros de la autora [Ana María Matute](autores)
- quiero libros del autor [Pablo Neruda](autores)
- quiero libros de la autora [Ana María Matute](autores)
- me podrías decir algún libro del autor [Gabriel García Márquez](autores)
- me podrías decir algún libro de la autora [Isabel Allende](autores)
- me podrías decir algún libro escrito por [Isaac Asimov](autores)
- necesito obras literarias del autor [Alberto Verdejo](autores)
- busca obras literarias escritas por [Rafael Caballero](autores)
- necesito libros del autor [Orwell](autores)
- libros escritos por [George R Martin](autores)
- libros del autor [George R Martin](autores)
- libros de la autora [George R Martin](autores)
- ahora quiero libros del autor [Cervantes](autores)
- quiero libros escritos por [Orwell](PER)
- busca libros del autor [Orwell](PER)
- busca libros de la autora [J K Rowling](PER)
- busca libros del autor [Orwell](PER)
- busca libros de la autora [J K Rowling](PER)
- busca libros escritos por [Francisco de Quevedo](PER)
- quiero libros del autor [Pablo Neruda](PER)
- quiero libros de la autora [Ana María Matute](PER)
- quiero libros del autor [Pablo Neruda](PER)
- quiero libros de la autora [Ana María Matute](PER)
- me podrías decir algún libro del autor [Gabriel García Márquez](PER)
- me podrías decir algún libro de la autora [Isabel Allende](PER)
- me podrías decir algún libro escrito por [Isaac Asimov](PER)
- necesito obras literarias del autor [Alberto Verdejo](PER)
- busca obras literarias escritas por [Rafael Caballero](PER)
- necesito libros del autor [Orwell](PER)
- libros escritos por [George R Martin](PER)
- libros del autor [George R Martin](PER)
- libros de la autora [George R Martin](PER)
- ahora quiero libros del autor [Cervantes](PER)
- /consulta_libros_autor[{"autores":"Patrick Rothfuss"}](autores:Patrick Rothfuss)
- /consulta_libros_autor[{"PER":"Jose Garcia"}](PER:Jose Garcia)

## intent:consulta_libros_kw
- busca libros de [Fuego y Sangre](libro)
- busco libros de [Matemática Discreta](libro)
- busca libros de [Matemática Discreta](libro)
- quiero libros de [Harry Potter](libro)
- busca libros de [Historia del arte](libro)
- dame libros de [recetas](libro)
- me podrías decir algún libro de [economía](libro)
- me podrías dar algún libro de [economía](libro)
- necesito libros de [Carlos Fuentes](libro)
- busca obras literarias de [medicina](libro)
- necesito obras literarias de [Lo que el viento se llevó](libro)
- libro de [Juego de Tronos](libro)
- quiero libros de [matemática discreta](libro)
- necesito que busques libros de [estructuras de datos y algoritmos](libro)
- quiero libros de [historia del arte](libro)
- busca varios libros de [Fuego y Sangre](libro)
- busco varios libros de [Matemática Discreta](libro)
- quiero varios libros de [Harry Potter](libro)
- dame varios libros de [recetas](libro)
- me podrías decir algún libro de [economía](libro)
- me podrías dar algún libro de [economía](libro)
- necesito varios libros de [Carlos Fuentes](libro)
- busca obras literarias de [medicina](libro)
- necesito obras literarias de [Lo que el viento se llevó](libro)
- libros de [Juego de Tronos](libro)
- quiero varios libros de [matemática discreta](libro)
- necesito que busques varios libros de [estructuras de datos y algoritmos](libro)
- quiero varios libros de [historia del arte](libro)
- /consulta_libros_kw[{"libro":"Pedro Sánchez"}](libro:Pedro Sánchez)
- busca libros de [matemática discreta](libro)
- quiero libros de [Federico Garcia Lorca](PER)
- necesito libros de [Tolkien](PER)
- dame libros de [Pedro Sanchez](PER)
- quiero libros de [Quevedo](PER)
- dame libros de [Derecho Legal Civil](libro)
- quiero libros de [Matemática Discreta](libro)

## intent:consulta_libros_kw_autor
- quiero libros de [El Quijote](libro) del autor [Miguel de Cervantes](autores)
- quiero libros de [Yo, Julia](libro) escritos por [Santiago Posteguillo](autores)
- quiero libros de [Narnia](libro) escritos por [Francisco de Quevedo](autores)
- me podrías decir algún libro de [Luces de bohemia](libro) escrito por [Ramón de Valle-Inclán](autores)
- me podrías decir algún libro de [Luces de bohemia](libro) del autores [Ramón de Valle-Inclán](autores)
- me podrías decir algún libro de [Luces de bohemia](libro) de la autora [Ramón de Valle-Inclán](autores)
- necesito obras literarias de [Harry Potter y la cámara secreta](libro) de la autora [J K Rowling](autores)[J K Rowling](PER)
- necesito obras literarias de [Harry Potter y la cámara secreta](libro) del autor [J K Rowling](autores)
- necesito obras literarias de [Harry Potter y la cámara secreta](libro) escritas por [J K Rowling](autores)
- libros de [Harry Potter y la cámara secreta](libro) escritas por [J K Rowling](autores)
- quiero libros de [El Quijote](MISC) del autor [Miguel de Cervantes](autores)
- quiero libros de [Yo, Julia](MISC) escritos por [Santiago Posteguillo](autores)
- quiero libros de [Narnia](MISC) escritos por [Francisco de Quevedo](autores)
- me podrías decir algún libro de [Luces de bohemia](MISC) escrito por [Ramón de Valle-Inclán](autores)
- me podrías decir algún libro de [Luces de bohemia](MISC) del autores [Ramón de Valle-Inclán](autores)
- me podrías decir algún libro de [Luces de bohemia](MISC) de la autora [Ramón de Valle-Inclán](autores)
- necesito obras literarias de [Harry Potter y la cámara secreta](MISC) de la autora [J K Rowling](autores)[J K Rowling](PER)
- necesito obras literarias de [Harry Potter y la cámara secreta](MISC) del autor [J K Rowling](autores)
- necesito obras literarias de [Harry Potter y la cámara secreta](MISC) escritas por [J K Rowling](autores)
- libros de [Harry Potter y la cámara secreta](MISC) escritas por [J K Rowling](autores)
- quiero libros de [El Quijote](libro) del autor [Miguel de Cervantes](PER)
- quiero libros de [Yo, Julia](libro) escritos por [Santiago Posteguillo](PER)
- quiero libros de [Narnia](libro) escritos por [Francisco de Quevedo](PER)
- me podrías decir algún libro de [Luces de bohemia](libro) escrito por [Ramón de Valle-Inclán](PER)
- me podrías decir algún libro de [Luces de bohemia](libro) del autores [Ramón de Valle-Inclán](PER)
- me podrías decir algún libro de [Luces de bohemia](libro) de la autora [Ramón de Valle-Inclán](PER)
- necesito obras literarias de [Harry Potter y la cámara secreta](libro) de la autora [J K Rowling](PER)[J K Rowling](PER)
- necesito obras literarias de [Harry Potter y la cámara secreta](libro) del autor [J K Rowling](PER)
- necesito obras literarias de [Harry Potter y la cámara secreta](libro) escritas por [J K Rowling](PER)
- libros de [Harry Potter y la cámara secreta](libro) escritas por [J K Rowling](PER)
- quiero libros de [El Quijote](MISC) del autor [Miguel de Cervantes](PER)
- quiero libros de [Yo, Julia](MISC) escritos por [Santiago Posteguillo](PER)
- quiero libros de [Narnia](MISC) escritos por [Francisco de Quevedo](PER)
- me podrías decir algún libro de [Luces de bohemia](MISC) escrito por [Ramón de Valle-Inclán](PER)
- me podrías decir algún libro de [Luces de bohemia](MISC) del autores [Ramón de Valle-Inclán](PER)
- me podrías decir algún libro de [Luces de bohemia](MISC) de la autora [Ramón de Valle-Inclán](PER)
- necesito obras literarias de [Harry Potter y la cámara secreta](MISC) de la autora [J K Rowling](PER)[J K Rowling](PER)
- necesito obras literarias de [Harry Potter y la cámara secreta](MISC) del autor [J K Rowling](PER)
- necesito obras literarias de [Harry Potter y la cámara secreta](MISC) escritas por [J K Rowling](PER)
- libros de [Harry Potter y la cámara secreta](MISC) escritas por [J K Rowling](PER)
- /consulta_libros_kw_autor[{"libro":"Como aprender a programar en 5 minutos","autores":"Rodolfo Rodríguez"}](libro:Como aprender a programar en 5 minutos)[{"libro":"Como aprender a programar en 5 minutos","autores":"Rodolfo Rodríguez"}](autores:Rodolfo Rodríguez)

## intent:consulta_libros_titulo
- quiero libros llamados [El Quijote](libro)
- busco libros llamados [Narnia](libro)
- quiero libros titulado [Yo, Julia](libro)
- quiero libros llamados [Narnia la travesía del viajero del alba](libro)
- me podrías decir algún libro llamado [Luces de bohemia](libro)
- dime libros titulados [Mortadelo y Filemón](libro)
- dime algún libro titulado [Mortadelo y Filemón](libro)
- dime algún libro llamado [Mortadelo y Filemón](libro)
- necesito obras literarias llamadas [Lo que el viento se llevó](libro)
- busca obras literarias llamadas [1984](libro)
- necesito libros titulados [Preludio a la fundación](libro)
- libros llamados [Juego de Tronos](libro)
- libros titulados [Juego de Tronos](libro)
- /consulta_libros_titulo[{"libro":"Narnia"}](libro:Narnia)
- quiero libros llamados [El Quijote](MISC)
- busco libros llamados [Narnia](MISC)
- quiero libros titulado [Yo, Julia](MISC)
- quiero libros llamados [Narnia la travesía del viajero del alba](MISC)
- me podrías decir algún libro llamado [Luces de bohemia](MISC)
- dime libros titulados [Mortadelo y Filemón](MISC)
- dime algún libro titulado [Mortadelo y Filemón](MISC)
- dime algún libro llamado [Mortadelo y Filemón](MISC)
- necesito obras literarias llamadas [Lo que el viento se llevó](MISC)
- busca obras literarias llamadas [1984](MISC)
- necesito libros titulados [Preludio a la fundación](MISC)
- libros llamados [Juego de Tronos](MISC)
- libros titulados [Juego de Tronos](MISC)
- quiero libros llamados [Harry Potter y el misterio del principe](MISC)[](libro:harry potter y el misterio del principe)

## intent:consulta_libros_titulo_autor
- quiero libros llamados [El Quijote](libro) del autor [Miguel de Cervantes](autores)
- quiero libros llamados [Yo, Julia](libro) escritos por [Santiago Posteguillo](autores)
- quiero libros llamados [Narnia](libro) escritos por [Francisco de Quevedo](autores)
- me podrías decir algún libro llamado [Luces de bohemia](libro) escrito por [Ramón de Valle-Inclán](autores)
- me podrías decir algún libro llamado [Luces de bohemia](libro) del autores [Ramón de Valle-Inclán](autores)
- me podrías decir algún libro llamado [Luces de bohemia](libro) de la autora [Ramón de Valle-Inclán](autores)
- necesito obras literarias llamadas [Harry Potter y la cámara secreta](libro) de la autora [J K Rowling](autores)
- necesito obras literarias llamadas [Harry Potter y la cámara secreta](libro) del autor [J K Rowling](autores)
- necesito obras literarias llamadas [Harry Potter y la cámara secreta](libro)  escritas por [J K Rowling](autores)
- libros llamados [Harry Potter y la cámara secreta](libro) escritas por [J K Rowling](autores)
- quiero libros llamados [El Quijote](MISC) del autor [Miguel de Cervantes](autores)
- quiero libros llamados [Yo, Julia](MISC) escritos por [Santiago Posteguillo](autores)
- quiero libros llamados [Narnia](MISC) escritos por [Francisco de Quevedo](autores)
- me podrías decir algún libro llamado [Luces de bohemia](MISC) escrito por [Ramón de Valle-Inclán](autores)
- me podrías decir algún libro llamado [Luces de bohemia](MISC) del autores [Ramón de Valle-Inclán](autores)
- me podrías decir algún libro llamado [Luces de bohemia](MISC) de la autora [Ramón de Valle-Inclán](autores)
- necesito obras literarias llamadas [Harry Potter y la cámara secreta](MISC) de la autora [J K Rowling](autores)
- necesito obras literarias llamadas [Harry Potter y la cámara secreta](MISC) del autor [J K Rowling](autores)
- necesito obras literarias llamadas [Harry Potter y la cámara secreta](MISC)  escritas por [J K Rowling](autores)
- libros llamados [Harry Potter y la cámara secreta](MISC) escritas por [J K Rowling](autores)
- quiero libros llamados [El Quijote](MISC) del autor [Miguel de Cervantes](PER)
- quiero libros llamados [Yo, Julia](MISC) escritos por [Santiago Posteguillo](PER)
- quiero libros llamados [Narnia](MISC) escritos por [Francisco de Quevedo](PER)
- me podrías decir algún libro llamado [Luces de bohemia](MISC) escrito por [Ramón de Valle-Inclán](PER)
- me podrías decir algún libro llamado [Luces de bohemia](MISC) del autores [Ramón de Valle-Inclán](PER)
- me podrías decir algún libro llamado [Luces de bohemia](MISC) de la autora [Ramón de Valle-Inclán](PER)
- necesito obras literarias llamadas [Harry Potter y la cámara secreta](MISC) de la autora [J K Rowling](PER)
- necesito obras literarias llamadas [Harry Potter y la cámara secreta](MISC) del autor [J K Rowling](PER)
- necesito obras literarias llamadas [Harry Potter y la cámara secreta](MISC)  escritas por [J K Rowling](PER)
- libros llamados [Harry Potter y la cámara secreta](MISC) escritas por [J K Rowling](PER)
- /consulta_libros_titulo_autor[{"libro":"Alatriste","autores":"Arturo Pérez-Reverte"}](libro:Alatriste)[{"libro":"Alatriste","autores":"Arturo Pérez-Reverte"}](autores:Arturo Pérez-Reverte)
- /consulta_libros_titulo_autor[{"libro":"Mi Españita", "autores":"Miguel Muñoz"}](libro:Mi Españita)[{"libro":"Mi Españita", "autores":"Miguel Muñoz"}](autores:Miguel Muñoz)

## intent:consulta_localizacion
- busca la ubicación de la [Biblioteca de odontología](localizacion)
- necesito ir a la [Biblioteca de derecho](localizacion)
- necesito desplazarme a la [Biblioteca de ciencias políticas](localizacion)
- necesito dirigirme a la [Biblioteca de enfermería](localizacion)
- necesito desplazarme a la [Biblioteca de ciencias políticas](localizacion)
- necesito dirigirme a la [Biblioteca de enfermería](localizacion)
- busca la posición de la [Biblioteca de geología](localizacion)
- dónde está la [Facultad de informática](localizacion)
- dónde se encuentra la [Facultad de informática](localizacion)
- dónde está la [Facultad de informática](localizacion)
- dónde se encuentra la [Facultad de informática](localizacion)
- ubicación de la [Zambrano](localizacion)
- donde está la [biblioteca de ciencias políticas](localizacion)
- quiero ir a la [facultad de geografía e historia](localizacion)
- /consulta_localizacion[{"localizacion":"biblioteca de educacion"}](localizacion:biblioteca de educacion)
- donde esta la [biblioteca de educacion](localizacion)

## intent:consulta_localizacion_empty
- busca su ubicación
- busca su ubicación de la biblioteca
- busca su ubicación de la facultad
- necesito ir
- necesito ir a la biblioteca
- necesito ir a la facultad
- necesito desplazarme allí
- necesito desplazarme a la biblioteca
- necesito desplazarme a la facultad
- dónde está
- dónde está la biblioteca
- dónde está la facultad
- dónde se encuentra
- dónde se encuentra la biblioteca
- dónde se encuentra la facultad
- donde esta
- llévame ahí
- llévame hasta ahí

## intent:consulta_telefono
- llama a la [Facultad de matemáticas](localizacion)
- llama a [Biblioteca de geografía](localizacion)
- busca el teléfono de la [Zambrano](localizacion)
- necesito el número de la [Facultad de informática](localizacion)
- necesito el número de teléfono de la [Facultad de medicina](localizacion)
- necesito el teléfono la [Zambrano](localizacion)
- busca el teléfono de la [Facultad de informática](localizacion)
- busca el número de la [Facultad de medicina](localizacion)
- busca el número de teléfono de la [Zambrano](localizacion)
- cuál es el número de la [Facultad de informática](localizacion)
- cuál es el teléfono de la [Facultad de Ciencias de la Información](localizacion)
- me puedes decir el n￿úmero de la [Biblioteca de Enfermer￿ia](localizacion)
- quiero el teléfono de la [biblioteca de veterinaria](localizacion)
- [Llama](PER) a la [facultad de informatica](localizacion)
- busca el numero de telefono de la [facultad de medicina](localizacion)

## intent:consulta_telefono_empty
- llámala
- llama a
- llama la a
- llama a la biblioteca
- llama a la facultad
- necesito su número
- necesito el número
- necesito su número de teléfono
- necesito el teléfono de teléfono
- busca su teléfono
- busca el teléfono
- busca el número de teléfono
- cuál es su número
- cuál es su teléfono
- quiero su teléfono
- quiero el teléfono de la biblioteca
- quiero el teléfono de la facultad
- llámala

## intent:despedidas
- adiós
- adios
- hasta luego
- chao
- ciao
- hasta nunca
- hasta pronto
- nos vemos
- te veo luego
- mañana hablamos
- luego hablamos
- bye
- bye bye
- adios
- adiós
- hasta pronto
- adiós
- adiós
- hasta pronto
- hasta mañana
- hasta nunca

## intent:gracias
- gracias
- te lo agradezco
- muchas gracias
- muchisimas gracias
- me has ayudado mucho
- mil gracias
- muy amable

## intent:insultos
- hijo de puta
- hija de puta
- eres tonta
- eres tonto
- me caes fatal
- zorra
- cabrón
- eres gilipollas
- vete a la mierda
- desgraciada
- maleducada
- asquerosa
- idiota
- me caes mal
- tonta
- tonto
- gilipollas
- subnormal
- fea
- retrasada

## intent:mas_info_primero
- muestrame más información del primero
- enseñame el primero
- quiero ver el 1
- quiero ver el primero
- muestrame el primero
- muetra primero
- muestra el primero
- [Muestrame](PER) el primero
- [Muestrame](PER) mas informacion del primero

## intent:mas_info_segundo
- muestrame más información del segundo
- enseñame el segundo
- quiero ver el 2
- quiero ver el segundo
- muestrame el segundo
- muetra segundo
- muestra el segundo
- [Muestrame](PER) el segundo
- [Muestrame](PER) mas informacion del segundo

## intent:mas_info_tercero
- muestrame más información del tercero
- enseñame el tercero
- quiero ver el 3
- quiero ver el tercero
- muestrame el tercero
- muetra tercero
- muestra el tercero
- [Muestrame](PER) el tercero
- [Muestrame](PER) mas informacion del tercero

## intent:me_llamo
- soy [Martin](persona)
- soy [Elena](persona)
- soy [Abelino](persona)
- mi nombre es [Susana](persona)
- mi nombre es [Manuel](persona)
- me gustaría que me llamases [Miguel](persona)
- me gustaría que me llamases [Luisa](persona)
- llámame [María](persona)
- llámame [Rosa](persona)
- a partir de ahora me llamarás [Sánchez](persona)
- a partir de ahora me llamarás [Teresa](persona)
- me llamo [Mauri](persona)
- me llamo [Marcos](persona)
- me llamo [Sara](persona)
- me llamo [Antonio](persona)
- me llamo [Alberto](persona)
- me llamo [Carmen](persona)
- buenos días, me llamo [Marina](persona)
- buenos días, me llamo [Aurelio](persona)
- hola, me llamo [Pepe](PER)[Pepe](persona:pepe)

## intent:quien_soy
- cómo te llamas
- cuál es tu nombre
- quién eres
- te conozco
- cómo decías que te llamabas
- podrías presentarte
- quién eres tú

## intent:saludos
- hola
- buenas
- buenos días
- buenas tardes
- buenas noches
- saludos
- hello
- holis
- buenas

## intent:busca_mas
- quiero más
- busca más
- muéstrame más
- enseñame más ejemplares
- busca más
- quiero más
- quiero otro
- carga más
- enseñame más ejemplares
- podrías buscar más ejemplares
- quiero mas
- muestra otro
- muestra más
- otro

## synonym:1984
- {"LOC":"Busca","libro":"1984"}

## synonym:Arturo Pérez-Reverte
- {"libro":"Alatriste","autores":"Arturo Pérez-Reverte"}

## synonym:Basilio
- {"persona":"Basilio"}

## synonym:Benito Pérez-Galdos
- {"autores":"Benito Pérez-Galdos"}

## synonym:Campeones
- {"libro":"Campeones"}

## synonym:Don Quijote de la Mancha
- {"MISC":"Don Quijote de la Mancha","autores":"Miguel de Cervantes"}

## synonym:Eustaquio
- {"persona":"Eustaquio"}

## synonym:Geologia
- {"localizacion":"Geologia"}

## synonym:Góngora
- {"autores":"Góngora"}
- {"PER":"Góngora", "autores":"Góngora}

## synonym:Harry Potter
- {"libro":"Harry Potter"}

## synonym:Jose Garcia
- {"PER":"Jose Garcia"}

## synonym:Jose Luis
- {"persona":"Jose Luis"}
- {"PER":"Jose Luis"}

## synonym:Luces de Bohemia
- {"libro":"Luces de Bohemia"}
- {"MISC":"Luces de Bohemia"}

## synonym:Matemática Discreta y Lógica
- {"libro":"Matemática Discreta y Lógica"}

## synonym:Mauricio
- mauri

## synonym:Miguel Muñoz
- {"libro":"Mi Españita", "autores":"Miguel Muñoz"}

## synonym:Miguel de Cervantes
- {"libro":"Don Quijote de la Mancha","autores":"Miguel de Cervantes"}

## synonym:Narnia
- {"libro":"Narnia"}

## synonym:Patrick Rothfuss
- {"autores":"Patrick Rothfuss"}

## synonym:Pedro Sánchez
- {"libro":"Pedro Sánchez"}
- {"autores":"Pedro Sánchez"}

## synonym:Pepe
- {"persona":"Pepe"}

## synonym:Programador experto
- {"libro":"RSA, de lo mejor lo superior", "autores":"Programador experto"}
- {"libro":"RSA de lo mejor lo superior", "autores":"Programador experto"}

## synonym:Psicologia
- {"localizacion":"Psicologia"}

## synonym:Quevedo
- {"autores":"Quevedo"}

## synonym:RSA de lo mejor lo superior
- {"MISC":"RSA de lo mejor lo superior", "autores":"Programador experto"}

## synonym:Rodolfo Rodríguez
- {"libro":"Como aprender a programar en 5 minutos","autores":"Rodolfo Rodríguez"}

## synonym:Topotamadre
- {"libro":"Topotamadre"}

## synonym:Zambrano
- {"localizacion":"Zambrano"}

## synonym:amancio
- amancio

## synonym:biblioteca de educacion
- {"localizacion":"biblioteca de educacion"}

## synonym:biblioteca zambrano
- biblioteca Zambrano

## synonym:facultad de informatica
- {"localizacion":"facultad de informatica"}

## synonym:marina
- marina

## synonym:miguel
- miguel

## synonym:pepe
- Pepe

## synonym:periodismo
- {"localizacion":"periodismo"}

## synonym:venancio tomeo
- Venancio Tomeo

## synonym:veterinaria
- {"localizacion":"veterinaria"}

## lookup:persona
  ./data/names/nombres.txt

## lookup:localizacion
  ./data/libraries.txt

## lookup:libro
  ./data/names/booksnames.txt
