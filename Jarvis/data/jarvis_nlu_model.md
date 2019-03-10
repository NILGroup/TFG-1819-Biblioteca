## lookup:persona
data/names/hombres.csv
data/names/mujeres.csv
data/names/apellidos.csv
data/names/apellidos2.csv

## lookup:localizacion
data/libraries.csv

## lookup:libro_titulo
data/names/booksnames.csv

## intent:saludos
- Hola
- Buenas
- Buenos días
- Buenas tardes
- Buenas noches
- Saludos

## intent:como_estas
- Qué tal
- Cómo estás
- Qué te pasa

## intent:quien_soy
- Cómo te llamas
- Cuál es tu nombre
- Quién eres
- Te conozco

## intent:me_llamo
- Soy yo
- Soy [Martin](persona)
- Me llamo [Mauricio Abbati](persona)
- Mi nombre es [Susana](persona)

## intent:gracias
- Gracias
- Te lo agradezco
- Muchas gracias
- Me has ayudado mucho

## intent:despedidas
- Adiós
- Adios
- Hasta luego
- Chao
- Ciao
- Hasta nunca
- Hasta pronto
- Nos vemos

## intent:consulta_catalogo_articulos
- Busca artículos de [biología](libro)
- Quiero artículos de [música](libro)
- Necesito artículos de [medicina](libro)

## intent:consulta_catalogo_juegos
- Busca juegos llamados [Far Cry](juego)
- Busca juegos de [God of War](juego)

## intent:consulta_catalogo_libros
- Busca libros de [Fuego y Sangre](libro)
- Quiero libros llamados [El Quijote](libro_titulo) del autor [Miguel de Cervantes](persona)
- Quiero libros llamados [Yo, Julia](libro_titulo) escritos por [Santiago Posteguillo](persona)
- Busco un libro de [Matemática Discreta](libro)
- Busco un libro llamado [Narnia](libro_titulo)
- Quiero un libro de [Harry Potter](libro)
- Quiero un libro titulado [Yo, Julia](libro_titulo)
- Quiero un libro escrito por [Orwell](persona)
- Busca libros de [Historia del arte](libro)
- Busca libros del autor [Orwell](persona)
- Busca libros de la autora [J K Rowling](persona)
- Busca libros escritos por [Francisco de Quevedo](persona)
- Quiero libros llamados [Narnia la travesía del viajero del alba](libro_titulo)
- Quiero libros llamados [Narnia](libro_titulo) escritos por [Francisco de Quevedo](persona)
- Quiero libros del autor [Pablo Neruda](persona)
- Quiero libros de la autora [Ana María Matute](persona)
- Dame libros de [recetas](libro)
- Me podrías decir algún libro de [economía](libro)
- Me podrías decir algún libro llamado [Luces de bohemia](libro_titulo) escrito por [Ramón de Valle-Inclán](persona)
- Me podrías decir algún libro del autor [Gabriel García Márquez](persona)
- Me podrías decir algún libro de la autora [Isabel Allende](persona)
- Me podrías decir algún libro escrito por [Isaac Asimov](persona)
- Dime libros de [Henry Miller](libro)
- Dime libros titulados [Mortadelo y Filemón](libro_titulo)
- Necesito libros de [Carlos Fuentes](libro)
- Me buscarías obras literarias llamadas [Lo que el viento se llevó](libro_titulo)
- Necesito obras literarias llamadas [Lo que el viento se llevó](libro_titulo)
- Necesito obras literarias del autor [Alberto Verdejo](persona)
- Busca obras literarias escritas por [Rafael Caballero](persona)
- Necesito libros del autor [Orwell](persona)
- Necesito un libro titulado [Preludio a la fundación](libro_titulo)

## intent:consulta_catalogo_musica
- Quiero un cd llamado [Bajo el yugo del tiempo](musica_titulo)
- Quiero un cd llamado [Ray of light](musica_titulo)
- Quiero un cd de [Florence And The Machine](musica)
- Quiero un cd de [Rosendo](musica)
- Necesito partituras de [Bach](persona)
- Necesito partituras llamadas [Concierto para clarinete](musica_titulo)
- Necesito partituras llamadas [Concierto para clarinete](musica_titulo) del compositor
(W. A. Mozart)(persona)

## intent:consulta_catalogo_peliculas
- Busco un DVD llamado [Bohemian Rhapsody](pelicula_titulo)
- Busco un DVD de [Infinity War](pelicula)
- Quiero un Bluray de [El resplandor](pelicula)
- Quiero un Bluray llamado [Star Wars](pelicula_titulo)
- Necesito una película del director[Tim Burton](persona)
- Busca una grabación cinematográfica llamada [Fantasía](pelicula_titulo) de [Walt Disney](persona)

## intent:consulta_horario_close
- A qué hora cierra la [Zambrano](localizacion)
- Cuándo cierra la [Zambrano](localizacion)
- Está cerrada la [Zambrano](localizacion)
- Cierre de la [Zambrano](localizacion)

## intent:consulta_horario_general
- Cuál es el horario de [Zambrano](localizacion)
- Horario de la [Zambrano](localizacion)

## intent:consulta_horario_open
- Está abierta la [Biblioteca de medicina](localizacion)
- A qué hora abre la [Biblioteca de informática](localizacion)
- Cuándo abre la [Facultad de geología](localizacion)
- Apertura de la [Zambrano](localizacion)
- Cuándo está abierta la [Zambrano](localizacion)

## intent:consulta_localizacion
- Busca la ubicación de la [Biblioteca de odontología](localizacion)
- Necesito ir a la [Biblioteca de derecho](localizacion)
- Necesito desplazarme a la [Biblioteca de ciencias políticas](localizacion)
- Necesito dirigirme a la [Biblioteca de enfermería](localizacion)
- Busca la posición de la [Biblioteca de geología](localizacion)
- Dónde está la [Facultad de informática](localizacion)
- Dónde se encuentra la [Facultad de informática](localizacion)
- Ubicación de la [Zambrano](localizacion)

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