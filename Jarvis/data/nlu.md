## intent:busca_mas
- Quiero más
- Busca más
- Muestrame más
- Enseñame más ejemplares
- Busca más

## intent:como_estas
- Qué tal
- Cómo estás
- Qué te pasa
- Qué te ocurre
- Estás bien
- Cómo te sientes

## intent:consulta_articulo
- Busca un artículo
- Quiero un artículo
- Me podrías decir un artículo
- Dime un artículo
- Dame un artículo
- Necesito un artículo
- Artículo

## intent:consulta_articulo_kw
- Busca un artículo de [biología](articulo)
- Quiero un artículo de [música](articulo)
- Necesito un artículo de [medicina](articulo)
- Podrías buscar un artículo de [historia](articulo)
- Dame un artículo de [historia](articulo)
- Artículo de [historia](articulo)

## intent:consulta_articulos
- Busca artículos
- Quiero artículos
- Me podrías decir algún artículos
- Dime artículos
- Dame artículos
- Necesito artículos
- Artículos

## intent:consulta_articulos_kw
- Busca artículos de [biología](articulo)
- Quiero artículos de [música](articulo)
- Necesito artículos de [medicina](articulo)
- Podrías buscar artículos de [historia](articulo)
- Dame artículos de [historia](articulo)
- Artículos de [historia](articulo)

## intent:consulta_horario_close
- A qué hora cierra la [Zambrano](localizacion)
- Cuándo cierra la [Zambrano](localizacion)
- Está cerrada la [Zambrano](localizacion)
- Cierre de la [Zambrano](localizacion)
- /consulta_horario_close[{"localizacion":"Geologia"}](localizacion:Geologia)
- /consulta_horario_close[{"localizacion":"veterinaria"}](localizacion:veterinaria)

## intent:consulta_horario_general
- Cuál es el horario de [Zambrano](localizacion)
- Horario de la [Zambrano](localizacion)
- /consulta_horario_general[{"localizacion":"periodismo"}](localizacion:periodismo)
- /consulta_horario_general[{"localizacion":"Zambrano"}](localizacion:Zambrano)

## intent:consulta_horario_open
- Está abierta la [Biblioteca de medicina](localizacion)
- A qué hora abre la [Biblioteca de informática](localizacion)
- Cuándo abre la [Facultad de geología](localizacion)
- Apertura de la [Zambrano](localizacion)
- Cuándo está abierta la [Zambrano](localizacion)
- /consulta_horario_open[{"localizacion":"Psicologia"}](localizacion:Psicologia)

## intent:consulta_juego
- Busca un juego
- Quiero un juego
- Me podrías decir un juego
- Dime un juego
- Dame un juego
- Necesito un juego
- Juego

## intent:consulta_juego_kw
- Busca un juego llamado [Far Cry](juego)
- Busca un juego de [God of War](juego)
- Necesito un juego llamado [Far Cry](juego)
- Necesito un juego de [God of War](juego)
- Quiero un juego llamado [Far Cry](juego)
- Quiero un juego de [God of War](juego)
- Podrías un buscar juego llamado [Far Cry](juego)
- Prodrías un buscar juego de [God of War](juego)
- Dame un juego llamado [Far Cry](juego)
- Dame un juego de [God of War](juego)
- Juego de [God of War](juego)
- Juego de [Juego de Tronos](juego)

## intent:consulta_juegos
- Busca juegos
- Quiero juegos
- Me podrías decir algún juegos
- Dime juegos
- Dame juegos
- Necesito juegos
- Juegos

## intent:consulta_juegos_kw
- Busca juegos llamados [Far Cry](juego)
- Busca juegos de [God of War](juego)
- Necesito juegos llamados [Far Cry](juego)
- Necesito juegos de [God of War](juego)
- Quiero juegos llamados [Far Cry](juego)
- Quiero juegos de [God of War](juego)
- Podrías buscar juegos llamados [Far Cry](juego)
- Prodrías buscar juegos de [God of War](juego)
- Dame juegos llamados [Far Cry](juego)
- Dame juegos de [God of War](juego)
- Juegos de [God of War](juego)
- Juegos de [Juego de Tronos](juego)

## intent:consulta_libro
- Busca un libro
- Quiero un libro
- Me podrías decir un libro
- Dime un libro
- Dame un libro
- Necesito un libro
- Busca una obra literaria
- Me buscarías una obra literaria
- Necesito una obra literaria
- Libro
- Quiero un libro

## intent:consulta_libro_autor
- Quiero un libro escrito por [Orwell](autores)
- Busca un libro del autor [Orwell](autores)
- Busca un libro de la autora [J K Rowling](autores)
- [Busca](LOC)  un libro del autor [Orwell](autores)
- [Busca](LOC)  un libro de la autora [J K Rowling](autores)
- Busca un libro escrito por [Francisco de Quevedo](autores)
- Busca un libro escrito por [Francisco de Quevedo](PER)
- Quiero un libro del autores [Pablo Neruda](autores)
- Quiero un libro de la autora [Ana María Matute](autores)
- Me podrías decir un libro del autores [Gabriel García Márquez](autores)
- Me podrías decir un libro de la autora [Isabel Allende](autores)
- Me podrías decir un libro escrito por [Isaac Asimov](autores)
- Necesito una obra literaria del autores [Alberto Verdejo](PER)
- Necesito una obra literaria del autores [Alberto Verdejo](autores)
- Busca una obra literaria escrita por [Rafael Caballero](autores)
- Necesito un libro del autores [Orwell](autores)
- Libro escrito por [George R Martin](autores)
- Libro del autores [George R Martin](autores)
- Libro de la autora [George R Martin](autores)
- /consulta_libro_autor[{"autores":"Góngora"}](autores:Góngora)
- /consulta_libro_autor[{"PER":"Góngora", "autores":"Góngora}](autores:Góngora)[{"PER":"Góngora", "autores":"Góngora}](PER:Góngora)
- /consulta_libro_autor[{"LOC":"Busca","PER":"Jose Garcia"}](LOC:Busca)[{"LOC":"Busca","PER":"Jose Garcia"}](PER:Jose Garcia)
- /consulta_libro_autor[{"PER":"Jose Garcia"}](PER:Jose Garcia)

## intent:consulta_libro_kw
- Busca un libro de [Fuego y Sangre](libro)
- Busco un único libro de [Matemática Discreta](libro)
- Quiero un libro de [Harry Potter](libro)
- Busca un libro de [Historia del arte](libro)
- Dame un libro de [recetas](libro)
- Me podrías decir un libro de [economía](libro)
- Me podrías dar un libro de [economía](libro)
- Necesito un libro de [Carlos Fuentes](libro)
- Busca libro de [Fuego y Sangre](libro)
- Busco libro de [Matemática Discreta](libro)
- Quiero libro de [Harry Potter](libro)
- Busca libro de [Historia del arte](libro)
- Dame libro de [recetas](libro)
- Me podrías libro de [economía](libro)
- Me podrías dar libro de [economía](libro)
- Necesito un libro de [Carlos Fuentes](libro)
- Busca una obra literaria de [medicina](libro)
- Necesito una obra literaria de [Lo que el viento se llevó](libro)
- Libro de [Juego de Tronos](libro)
- [Harry Potter](libro)
- /consulta_libro_kw[{"libro":"Topotamadre"}](libro:Topotamadre)
- /consulta_libro_kw[{"autores":"Benito Pérez-Galdos"}](autores:Benito Pérez-Galdos)
- /consulta_libro_kw[{"autores":"Quevedo"}](autores:Quevedo)
- /consulta_libro_kw[{"libro":"Harry Potter"}](libro:Harry Potter)
- /consulta_libro_kw[{"libro":"Matemática Discreta y Lógica"}](libro:Matemática Discreta y Lógica)
- /consulta_libro_kw[{"libro":"Campeones"}](libro:Campeones)

## intent:consulta_libro_kw_autor
- [Busco](LOC) un libro de [El Quijote](libro) del autores [Miguel de Cervantes](autores)
- [Busco](LOC) un libro de [Yo, Julia](libro) escrito por [Santiago Posteguillo](autores)
- Busco un libro de [El Quijote](libro) del autores [Miguel de Cervantes](autores)
- Busco un libro de [Yo, Julia](libro) escrito por [Santiago Posteguillo](autores)
- Quiero un libro de [El Quijote](libro) del autores [Miguel de Cervantes](autores)
- Quiero un libro de [Yo, Julia](libro) escrito por [Santiago Posteguillo](autores)
- Me podrías decir un libro de [Luces de bohemia](libro) escrito por [Ramón de Valle-Inclán](autores)
- Me podrías decir un libro de [Luces de bohemia](libro) del autores [Ramón de Valle-Inclán](autores)
- Me podrías decir un libro de [Luces de bohemia](libro) de la autora [Ramón de Valle-Inclán](autores)
- Me podrías decir un libro de [Luces de bohemia](libro) del autores [Ramón de Valle-Inclán](PER)
- Me podrías decir un libro de [Luces de bohemia](MISC) de la autora [Ramón de Valle-Inclán](autores)
- Me podrías decir un libro de [Luces de bohemia](MISC) de la autora [Ramón de Valle-Inclán](PER)
- Necesito una obra literaria de [Harry Potter y la cámara secreta](libro) de la autora [J K Rowling](autores)
- Necesito una obra literaria de [Harry Potter y la cámara secreta](libro) del autores [J K Rowling](autores)
- Necesito una obra literaria de [Harry Potter y la cámara secreta](libro)  escrita por [J K Rowling](autores)
- Libro de [Harry Potter y la cámara secreta](libro)  escritas por [J K Rowling](autores)
- /consulta_libro_kw_autor[{"libro":"RSA, de lo mejor lo superior", "autores":"Programador experto"}](libro:RSA, de lo mejor lo superior)[{"libro":"RSA, de lo mejor lo superior", "autores":"Programador experto"}](autores:Programador experto)
- /consulta_libro_kw_autor[{"MISC":"RSA de lo mejor lo superior", "autores":"Programador experto"}](MISC:RSA de lo mejor lo superior)[{"libro":"RSA de lo mejor lo superior", "autores":"Programador experto"}](autores:Programador experto)

## intent:consulta_libro_titulo
- Quiero un libro llamado [El Quijote](libro)
- Busco un libro llamado [Narnia](libro)
- [Busco](LOC) un libro llamado [Narnia](libro)
- Quiero un libro titulado [Yo, Julia](libro)
- Quiero un libro llamado [Narnia la travesía del viajero del alba](libro)
- Me podrías decir un libro llamado [Luces de bohemia](libro)
- Dime libro titulado [Mortadelo y Filemón](libro)
- Dime un libro titulado [Mortadelo y Filemón](libro)
- Dime un libro llamado [Mortadelo y Filemón](libro)
- Necesito una obra literaria llamada [Lo que el viento se llevó](libro)
- Busca una obras literaria llamada [1984](libro)
- Necesito un libro titulado [Preludio a la fundación](libro)
- Libro llamado [Juego de Tronos](libro)
- Libro titulado [Juego de Tronos](libro)
- Buscame un libro llamado [El amor en tiempos de colera](MISC)
- /consulta_libro_titulo[{"libro":"Luces de Bohemia"}](libro:Luces de Bohemia)
- /consulta_libro_titulo[{"MISC":"Luces de Bohemia"}](MISC:Luces de Bohemia)

## intent:consulta_libro_titulo_autor
- Busca un libro llamado [El Quijote](libro) del autores [Miguel de Cervantes](autores)
- Busca un libro llamado [Yo, Julia](libro) escrito por [Santiago Posteguillo](autores)
- [Busca](LOC) un libro llamado [El Quijote](libro) del autores [Miguel de Cervantes](autores)
- [Busca](LOC) un libro llamado [Yo, Julia](libro) escrito por [Santiago Posteguillo](autores)
- Quiero un libro llamado [El Quijote](libro) del autores [Miguel de Cervantes](autores)
- Quiero un libro llamado [Yo, Julia](libro) escrito por [Santiago Posteguillo](autores)
- Me podrías decir un libro llamado [Luces de bohemia](libro) escrito por [Ramón de Valle-Inclán](autores)
- Me podrías decir un libro llamado [Luces de bohemia](MISC) escrito por [Ramón de Valle-Inclán](autores)
- Me podrías decir un libro llamado [Luces de bohemia](libro) del autores [Ramón de Valle-Inclán](autores)
- Me podrías decir un libro llamado [Luces de bohemia](libro) de la autora [Ramón de Valle-Inclán](autores)
- Necesito una obra literaria llamada [Harry Potter y la cámara secreta](libro) de la autora [J K Rowling](autores)
- Necesito una obra literaria llamada [Harry Potter y la cámara secreta](libro) del autores [J K Rowling](autores)
- Necesito una obra literaria llamada [Harry Potter y la cámara secreta](libro)  escrita por [J K Rowling](autores)
- Libros llamado [Harry Potter y la cámara secreta](libro)  escritas por [J K Rowling](autores)
- Serías tan amable de buscarme un único libro llamado [Los Pilares de la Tierra](libro)[](libro:Los Pilares de la Tierra) del autor [Ken Follet](PER)[](autores:Ken Follet)
- /consulta_libro_titulo_autor[{"libro":"Don Quijote de la Mancha","autores":"Miguel de Cervantes"}](libro:Don Quijote de la Mancha)[{"libro":"Don Quijote de la Mancha","autores":"Miguel de Cervantes"}](autores:Miguel de Cervantes)
- /consulta_libro_titulo_autor[{"MISC":"Don Quijote de la Mancha","autores":"Miguel de Cervantes"}](MISC:Don Quijote de la Mancha)[{"libro":"Don Quijote de la Mancha","autores":"Miguel de Cervantes"}](autores:Miguel de Cervantes)

## intent:consulta_libros
- Busca libros
- [Busca](LOC) libros
- Quiero libros
- Me podrías decir algún libro
- Dime libros
- Dame libros
- Necesito libros
- Busca obras literarias
- Me buscarías obras literarias
- Necesito obras literarias
- Libros

## intent:consulta_libros_autor
- Quiero libros escritos por [Orwell](autores)
- Busca libros del autor [Orwell](autores)
- Busca libros de la autora [J K Rowling](autores)
- [Busca](LOC) libros del autor [Orwell](autores)
- [Busca](LOC) libros de la autora [J K Rowling](autores)
- Busca libros escritos por [Francisco de Quevedo](autores)
- Quiero libros del autor [Pablo Neruda](autores)
- Quiero libros de la autora [Ana María Matute](autores)
- Quiero libros del autor [Pablo Neruda](PER)
- Quiero libros de la autora [Ana María Matute](PER)
- Me podrías decir algún libro del autor [Gabriel García Márquez](autores)
- Me podrías decir algún libro de la autora [Isabel Allende](autores)
- Me podrías decir algún libro escrito por [Isaac Asimov](autores)
- Necesito obras literarias del autor [Alberto Verdejo](autores)
- Busca obras literarias escritas por [Rafael Caballero](autores)
- Necesito libros del autor [Orwell](autores)
- Libros escritos por [George R Martin](autores)
- Libros del autor [George R Martin](autores)
- Libros de la autora [George R Martin](autores)
- Ahora quiero libros del autor [Cervantes](autores)
- /consulta_libros_autor[{"autores":"Patrick Rothfuss"}](autores:Patrick Rothfuss)
- /consulta_libros_autor[{"LOC":"Busca","PER":"Jose Garcia"}](LOC:Busca)[{"LOC":"Busca","PER":"Jose Garcia"}](PER:Jose Garcia)
- /consulta_libros_autor[{"PER":"Jose Garcia"}](PER:Jose Garcia)

## intent:consulta_libros_kw
- Busca libros de [Fuego y Sangre](libro)
- Busco libros de [Matemática Discreta](libro)
- [Busca](LOC) libros de [Matemática Discreta](libro)
- Quiero libros de [Harry Potter](libro)
- Busca libros de [Historia del arte](libro)
- Dame libros de [recetas](libro)
- Me podrías decir algún libro de [economía](libro)
- Me podrías dar algún libro de [economía](libro)
- Necesito libros de [Carlos Fuentes](libro)
- Busca obras literarias de [medicina](libro)
- Necesito obras literarias de [Lo que el viento se llevó](libro)
- Libro de [Juego de Tronos](libro)
- Quiero libros de [matemática discreta](libro)
- Quiero libros de [Venancio Tomeo](PER)[Venancio Tomeo](libro:venancio tomeo)
- Necesito que busques libros de [estructuras de datos y algoritmos](libro)
- Quiero libros de [historia del arte](libro)
- Busca varios libros de [Fuego y Sangre](libro)
- Busco varios libros de [Matemática Discreta](libro)
- [Busca](LOC) varios libros de [Matemática Discreta](libro)
- Quiero varios libros de [Harry Potter](libro)
- Busca varios libros de [Historia del arte](libro)
- Dame varios libros de [recetas](libro)
- Me podrías decir algún libro de [economía](libro)
- Me podrías dar algún libro de [economía](libro)
- Necesito varios libros de [Carlos Fuentes](libro)
- Busca obras literarias de [medicina](libro)
- Necesito obras literarias de [Lo que el viento se llevó](libro)
- Libro de [Juego de Tronos](libro)
- Quiero varios libros de [matemática discreta](libro)
- Quiero varios libros de [Venancio Tomeo](PER)[Venancio Tomeo](libro:venancio tomeo)
- Necesito que busques varios libros de [estructuras de datos y algoritmos](libro)
- Quiero varios libros de [historia del arte](libro)
- /consulta_libros_kw[{"libro":"Pedro Sánchez"}](libro:Pedro Sánchez)
- /consulta_libros_kw[{"LOC":"Busca","libro":"1984"}](LOC:Busca)[{"LOC":"Busca","libro":"1984"}](libro:1984)
- [Busca](LOC) libros de [matemática discreta](libro)

## intent:consulta_libros_kw_autor
- Quiero libros de [El Quijote](libro) del autor [Miguel de Cervantes](autores)
- Quiero libros de [Yo, Julia](libro) escritos por [Santiago Posteguillo](autores)
- Quiero libros de [Narnia](libro) escritos por [Francisco de Quevedo](autores)
- Me podrías decir algún libro de [Luces de bohemia](libro) escrito por [Ramón de Valle-Inclán](autores)
- Me podrías decir algún libro de [Luces de bohemia](libro) del autores [Ramón de Valle-Inclán](autores)
- Me podrías decir algún libro de [Luces de bohemia](libro) de la autora [Ramón de Valle-Inclán](autores)
- Necesito obras literarias de [Harry Potter y la cámara secreta](libro) de la autora [J K Rowling](autores)
- Necesito obras literarias de [Harry Potter y la cámara secreta](libro) del autor [J K Rowling](autores)
- Necesito obras literarias de [Harry Potter y la cámara secreta](libro)  escritas por [J K Rowling](autores)
- Libros de [Harry Potter y la cámara secreta](libro)  escritas por [J K Rowling](autores)
- /consulta_libros_kw_autor[{"libro":"Como aprender a programar en 5 minutos","autores":"Rodolfo Rodríguez"}](libro:Como aprender a programar en 5 minutos)[{"libro":"Como aprender a programar en 5 minutos","autores":"Rodolfo Rodríguez"}](autores:Rodolfo Rodríguez)

## intent:consulta_libros_titulo
- Quiero libros llamados [El Quijote](libro)
- Busco libros llamados [Narnia](libro)
- Quiero libros titulado [Yo, Julia](libro)
- Quiero libros llamados [Narnia la travesía del viajero del alba](libro)
- Me podrías decir algún libro llamado [Luces de bohemia](libro)
- Dime libros titulados [Mortadelo y Filemón](libro)
- Dime algún libro titulado [Mortadelo y Filemón](libro)
- Dime algún libro llamado [Mortadelo y Filemón](libro)
- Necesito obras literarias llamadas [Lo que el viento se llevó](libro)
- Busca obras literarias llamadas [1984](libro)
- Necesito libros titulados [Preludio a la fundación](libro)
- Libros llamados [Juego de Tronos](libro)
- Libros titulados [Juego de Tronos](libro)
- /consulta_libros_titulo[{"libro":"Narnia"}](libro:Narnia)

## intent:consulta_libros_titulo_autor
- Quiero libros llamados [El Quijote](libro) del autor [Miguel de Cervantes](autores)
- Quiero libros llamados [Yo, Julia](libro) escritos por [Santiago Posteguillo](autores)
- Quiero libros llamados [Narnia](libro) escritos por [Francisco de Quevedo](autores)
- Me podrías decir algún libro llamado [Luces de bohemia](libro) escrito por [Ramón de Valle-Inclán](autores)
- Me podrías decir algún libro llamado [Luces de bohemia](libro) del autores [Ramón de Valle-Inclán](autores)
- Me podrías decir algún libro llamado [Luces de bohemia](libro) de la autora [Ramón de Valle-Inclán](autores)
- Necesito obras literarias llamadas [Harry Potter y la cámara secreta](libro) de la autora [J K Rowling](autores)
- Necesito obras literarias llamadas [Harry Potter y la cámara secreta](libro) del autor [J K Rowling](autores)
- Necesito obras literarias llamadas [Harry Potter y la cámara secreta](libro)  escritas por [J K Rowling](autores)
- Libros llamados [Harry Potter y la cámara secreta](libro)  escritas por [J K Rowling](autores)
- /consulta_libros_titulo_autor[{"libro":"Alatriste","autores":"Arturo Pérez-Reverte"}](libro:Alatriste)[{"libro":"Alatriste","autores":"Arturo Pérez-Reverte"}](autores:Arturo Pérez-Reverte)
- /consulta_libros_titulo_autor[{"libro":"Mi Españita", "autores":"Miguel Muñoz"}](libro:Mi Españita)[{"libro":"Mi Españita", "autores":"Miguel Muñoz"}](autores:Miguel Muñoz)

## intent:consulta_localizacion
- Busca la ubicación de la [Biblioteca de odontología](localizacion)
- Necesito ir a la [Biblioteca de derecho](localizacion)
- Necesito desplazarme a la [Biblioteca de ciencias políticas](localizacion)
- Necesito dirigirme a la [Biblioteca de enfermería](localizacion)
- [Necesito](PER) desplazarme a la [Biblioteca de ciencias políticas](localizacion)
- [Necesito](PER) dirigirme a la [Biblioteca de enfermería](localizacion)
- Busca la posición de la [Biblioteca de geología](localizacion)
- [Dónde](PER) está la [Facultad de informática](localizacion)
- [Dónde](PER) se encuentra la [Facultad de informática](localizacion)
- Dónde está la [Facultad de informática](localizacion)
- Dónde se encuentra la [Facultad de informática](localizacion)
- Ubicación de la [Zambrano](localizacion)
- Donde está la [biblioteca de ciencias políticas](localizacion)
- Quiero ir a la [facultad de geografía e historia](localizacion)
- /consulta_localizacion[{"localizacion":"facultad de informatica"}](localizacion:facultad de informatica)

## intent:consulta_localizacion_empty
- Busca su ubicación
- Necesito ir
- Necesito desplazarme allí
- Dónde está
- Dónde se encuentra
- Dónde está
- [Dónde](PER) está
- /consulta_localizacion_empty

## intent:consulta_musica
- Busca un CD
- Quiero un CD
- Necesito un CD
- Necesito una partitura
- Música

## intent:consulta_musica_kw
- Busca un CD llamado [Bajo el yugo del tiempo](musica)
- Quiero un CD llamado [Bajo el yugo del tiempo](musica)
- Quiero un cd llamado [Ray of light](musica)
- Quiero un CD de [Florence And The Machine](musica)
- Quiero un cd de [Rosendo](musica)
- Necesito una partitura de [Bach](autores)
- Necesito una partitura llamada [Concierto para clarinete](musica)
- Necesito una partitura llamada [Concierto para clarinete](musica) del compositor
- Necesito una partitura llamada [Concierto para clarinete](musica) de la compositora

## intent:consulta_musicas
- Busca CD's
- Quiero CD's
- Quiero varios CD's
- Necesito CD's
- Necesito partituras

## intent:consulta_musicas_kw
- Busca CD's llamados [Bajo el yugo del tiempo](musica)
- Quiero CD's llamados [Bajo el yugo del tiempo](musica)
- Quiero cd's llamados [Ray of light](musica)
- Quiero varios CD's de [Florence And The Machine](musica)
- Quiero varios cd de [Rosendo](musica)
- Necesito CD's de [Eminem](musica)
- Necesito partituras de [Bach](autores)
- Necesito partituras llamadas [Concierto para clarinete](musica)
- Necesito partituras llamadas [Concierto para clarinete](musica) del compositor
- Necesito partituras llamadas [Concierto para clarinete](musica) de la compositora

## intent:consulta_pelicula_kw
- Busco un DVD llamado [Bohemian Rhapsody](pelicula)
- Busco un dvd de [Infinity War](pelicula)
- Busca una película de [Infinity War](pelicula)
- Busca una película llamada [Bohemian Rhapsody](pelicula)
- Quiero un Bluray de [El resplandor](pelicula)
- Quiero un Bluray llamado [Star Wars](pelicula)
- Necesito una película del director[Tim Burton](autores)
- Busca una grabación cinematográfica llamada [Fantasía](pelicula) de [Walt Disney](autores)
- Película de [miedo](pelicula)

## intent:consulta_peliculas
- Busco DVD's
- Busca películas
- Quiero Bluray's
- Quiero Bluray
- Necesito películas
- Busca grabaciones cinematográfica
- Películas
- Busco un DVD
- Busca una película
- Quiero un Bluray
- Necesito una película
- Busca una grabaciín cinematográfica
- Película

## intent:consulta_peliculas_kw
- Busco DVD's llamados [Bohemian Rhapsody](pelicula)
- Busco dvd's de [Infinity War](pelicula)
- Busca películas de [Infinity War](pelicula)
- Busca películas llamadas [Bohemian Rhapsody](pelicula)
- Quiero varios Bluray de [El resplandor](pelicula)
- Quiero Bluray's llamado [Star Wars](pelicula)
- Necesito películas del director [Tim Burton](autores)
- Busca grabaciones cinematográfica llamadas [Fantasía](pelicula) de [Walt Disney](autores)
- Películas de [miedo](pelicula)

## intent:consulta_telefono
- Llama a la [Facultad de matemáticas](localizacion)
- Llama a [Biblioteca de geografía](localizacion)
- Busca el teléfono de la [Zambrano](localizacion)
- Necesito el número de la [Facultad de informática](localizacion)
- Necesito el número de teléfono de la [Facultad de medicina](localizacion)
- Necesito el teléfono la [Zambrano](localizacion)
- Busca el teléfono de la [Facultad de informática](localizacion)
- Busca el número de la [Facultad de medicina](localizacion)
- Busca el número de teléfono de la [Zambrano](localizacion)
- Cuál es el número de la [Facultad de informática](localizacion)
- Cuál es el teléfono de la [Facultad de Ciencias de la Información](localizacion)
- Quiero el teléfono de la [biblioteca de veterinaria](localizacion)
- /consulta_telefono[{"localizacion":"Zambrano"}](localizacion:Zambrano)

## intent:consulta_telefono_empty
- Llámala
- Necesito su número
- Necesito el teléfono
- Busca su teléfono
- Busca el número de teléfono
- Cuál es su número
- Cuál es su teléfono
- Quiero su teléfono

## intent:despedida
- /despedida

## intent:despedidas
- Adiós
- Adios
- Hasta luego
- Chao
- Ciao
- Hasta nunca
- Hasta pronto
- Nos vemos
- Te veo luego
- Mañana hablamos
- Luego hablamos
- Bye bye
- adios
- Adiós
- Hasta pronto
- Adiós
- Adiós
- Hasta pronto
- Hasta mañana
- /despedidas
- /despedidas
- /despedidas
- /despedidas
- /despedidas

## intent:gracias
- Gracias
- Te lo agradezco
- Muchas gracias
- Me has ayudado mucho
- Mil gracias
- Gracias
- Gracias
- Gracias
- /gracias
- /gracias
- /gracias

## intent:insultos
- Hijo de puta
- Hija de puta
- Eres tonta
- Eres tonto
- Me caes fatal
- Zorra
- Cabrón
- Eres gilipollas
- Vete a la mierda
- Desgraciada
- Maleducada
- Asquerosa

## intent:mas_info_primero
- Muestrame más información del primero
- Enseñame el primero
- Quiero ver el 1
- Quiero ver el primero
- /mas_info_primero

## intent:mas_info_segundo
- Muestrame más información del segundo
- Enseñame el segundo
- Quiero ver el 2
- Quiero ver el segundo
- /mas_info_segundo

## intent:mas_info_tercero
- Muestrame más información del tercero
- Enseñame el tercero
- Quiero ver el 3
- Quiero ver el tercero
- Muestrame el tercero
- /mas_info_tercero

## intent:me_llamo
- Soy [Martin](persona)
- Soy [Elena](persona)
- Soy [Abelino](persona)
- Mi nombre es [Susana](persona)
- Mi nombre es [Manuel](persona)
- Me gustaría que me llamases [Miguel](persona)
- Me gustaría que me llamases [Luisa](persona)
- Llámame [María](persona)
- Llámame [Rosa](persona)
- A partir de ahora me llamarás [Sánchez](persona)
- A partir de ahora me llamarás [Teresa](persona)
- Me llamo [Mauri](persona)
- Me llamo [Marcos](persona)
- Me llamo [Sara](persona)
- Me llamo [Antonio](persona)
- Me llamo [Alberto](persona)
- Me llamo [Carmen](persona)
- Buenos días, me llamo [Marina](persona)
- Buenos días, me llamo [Aurelio](persona)
- [Hola](PER), me llamo [Pepe](PER)[Pepe](persona:pepe)
- /me_llamo[{"persona":"Jose Luis"}](persona:Jose Luis)
- /me_llamo[{"persona":"Pepe"}](persona:Pepe)
- /me_llamo[{"persona":"Basilio"}](persona:Basilio)
- /me_llamo[{"persona":"Eustaquio"}](persona:Eustaquio)
- /me_llamo[{"PER":"Eustaquio"}](PER)

## intent:quien_soy
- Cómo te llamas
- Cuál es tu nombre
- Quién eres
- Te conozco
- Cómo decías que te llamabas
- Podrías presentarte
- Quien eres tu
- [Buenas](LOC), soy [Amancio](LOC)[Amancio](persona:amancio)

## intent:saludos
- Hola
- Buenas
- Buenos días
- Buenas tardes
- Buenas noches
- Saludos
- Hello
- Holis
- [Hola](PER)
- Buenas
- /saludos
- /saludos[{"persona":"Jose Luis"}](persona:Jose Luis)
- /saludos[{"PER":"Jose Luis"}](PER:Jose Luis)

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
- {"LOC":"Busca","PER":"Jose Garcia"}
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
- Mauri

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
- Amancio

## synonym:marina
- Marina

## synonym:miguel
- Miguel

## synonym:pepe
- Pepe

## synonym:periodismo
- {"localizacion":"periodismo"}

## synonym:venancio tomeo
- Venancio Tomeo

## synonym:veterinaria
- {"localizacion":"veterinaria"}

## lookup:persona
  data/names/nombres.csv

## lookup:localizacion
  data/libraries.csv

## lookup:libro_titulo
  data/names/booksnames.csv
