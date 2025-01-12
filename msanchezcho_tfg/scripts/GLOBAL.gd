extends Node

## GUARDADO
var save_path = "user://save_game.dat"

var game_data: Dictionary = {
	"player_health": 3,
	"score": 0,
	"dialogue_number": 0
}
var final_bueno: bool = false

#region dialogos
## 0 Edward 
## 1 Miguel 
## 2 Paolo
var dialogues = [
	[
		{"speaker": 1, "text": "Miguel: ¿Qué pasa, cracks? ¿Cómo ha ido el día?"},
		{"speaker": 2, "text": "Paolo: Bah, regular... En el trabajo no me siento valorado. Pero ya sabes, tengo demasiadas deudas como para largarme."},
		{"speaker": 0, "text": "Edward: Buah, tío, eso es una movida. Seguro que Agripina me daría un consejo sobre esto..."},
		{"speaker": 1, "text": "Miguel: ¿Otra vez con lo de tu ex? Tío, en serio, algún día te darás cuenta de que hay vida más allá de Agripina... ¡jajaja! En fin..."},
		{"speaker": 0, "text": "Edward: Buah, tío, ¿pero tú no tienes sentimientos o qué? Pareces una tortuga con una coraza..."},
		{"speaker": 1, "text": "Miguel: ¡Jajajaja! Qué animal eres..."},
		{"speaker": 2, "text": "Paolo: Bueno, ¿entonces qué? Necesito desconectarme de la realidad. Dejar de pensar en mi vida un rato."},
		{"speaker": 0, "text": "Edward: Tío, hace un montón que no hacemos algo divertido. ¿Qué os parece si vamos a por la sustancia C?"},
		{"speaker": 1, "text": "Miguel: ¿Eh? No sé... ya sabéis cómo está el barrio últimamente. Igual no es buena idea."},
		{"speaker": 2, "text": "Paolo: Bah, seguro que no es para tanto. Venga, anímate, ¡vamos a por la sustancia C!"},
		{"speaker": 0, "text": "Edward: ¡Va, venga!"},
		{"speaker": 1, "text": "Miguel: Buf... Está bien, vamos a desconectarnos de la realidad."},
	],
	[
		{"speaker": 1, "text": "Miguel: Eh... ¿quién ha puesto esto aquí? ¡Está demasiado alto!"},
		{"speaker": 0, "text": "Edward: Ya sabes... el gobierno. Supongo que quieren justificar sus mordidas de alguna forma, jaja."},
		{"speaker": 2, "text": "Paolo: Oye, Edward, ¿tú no ibas a clase de bachata con tu ex? Igual puedes aplicar un paso y superamos esto, jajaja."},
		{"speaker": 0, "text": "Edward: ¿¡Qué tiene que ver bailar con esto!?... En fin, puedo intentarlo. De pequeño era un crack saltando la valla para hacer pirola."},
		{"speaker": 1, "text": "Miguel: Pues piensa que estamos escapándonos de clase para ver a Agripina... igual superamos esto."}
	],
	[
		{"speaker": 1, "text": "Miguel: Jodo... pues el barrio está fatal. Nunca había visto tantas ratas juntas."},
		{"speaker": 0, "text": "Edward: Buah, parecen peligrosas. Seguro que si las tocamos lo mínimo que pillamos es el zika..."},
		{"speaker": 2, "text": "Paolo: ¿El zika? Suena a nombre de discoteca moderna. Oye, Miguel, ¿tú no jugabas al béisbol? Igual puedes darles un buen susto con tu derecha."},
		{"speaker": 1, "text": "Miguel: ¿Tío, en serio? ¿Cuándo he jugado al béisbol? Jajaja... en fin, puedo probar a dispararles. Era un crack en el Counter 1.6 cuando tenía 10 años."},
		{"speaker": 0, "text": "Edward: ¿Qué? Jajaja, venga, prueba, a ver si les das."}
	],
	[
		{"speaker": 1, "text": "¿Otra vez? ¿Qué es esta caja gigante? Esto parece un juego de mal gusto..."},
		{"speaker": 0, "text": "Edward: Supongo que está ahí para los que hacen parkour, pero claramente ese no es nuestro caso. Oye, Paolo, tú que le das a los hierros, ¿crees que puedes moverla? Igual nos sirve para llegar a la sustancia C."},
		{"speaker": 2, "text": "Paolo: Bueno, puedo intentarlo. El otro día hice mi récord personal con 10 kilos en press... estoy hecho un toro."},
		{"speaker": 1, "text": "Miguel: Jajaja, venga, Hulk, dale caña."},
	],
	[
		{"speaker": 0, "text": "Edward: ¡Por fin! Después de escalar, empujar cajas, y casi morir con esas ratas, ¡la sustancia C está aquí!"},
		{"speaker": 1, "text": "Miguel: Madre mía... espero que valga la pena. Esto ha sido peor que las pruebas físicas del instituto."},
		{"speaker": 2, "text": "Paolo: Jajaja, sí, y yo que pensé que mover esa caja iba a ser lo más difícil... Si supieran que mi PR son 10 kilos."},
		{"speaker": 2, "text": "(Todos se miran, asienten y consumen la sustancia C.)"},
		{"speaker": 0, "text": "Edward: ¡Ufff! ¿Esto es normal? Porque siento como si mi lengua tuviera WiFi..."},
		{"speaker": 1, "text": "Miguel: ¡Jajaja! ¡Cállate! Aunque ahora que lo dices, creo que mi brazo izquierdo acaba de enviar un mensaje de texto."},
		{"speaker": 2, "text": "Paolo: ¡Tíos, esto es increíble! Creo que puedo escuchar los pensamientos de la caja que moví. Dice que se sintió muy utilizada."},
		{"speaker": 0, "text": "Edward: ¡Jajaja! Bueno, pues dile a la caja que se relaje... aunque creo que mis pies están planeando una rebelión contra mí."},
		{"speaker": 1, "text": "Miguel: Esperad... ¿veis eso? ¡Hay un conejo gigante con gafas de sol bailando bachata!"},
		{"speaker": 2, "text": "Paolo: Jajajaja, seguro que es el profesor de Edward. Oye, Edward, ¿le das una clase o qué?"},
		{"speaker": 0, "text": "Edward: ¡Buah, tío, no puedo más! Esto es como si la realidad y un videojuego hubieran tenido un hijo y le hubieran dado café del 17."}
	],
	[
		{"speaker": 1, "text": "Miguel: ¡Jajaja! Tíos, esto ha sido una locura. ¿Quién iba a decir que desconectarse de la realidad podría ser tan divertido?"},
		{"speaker": 2, "text": "Paolo: Jajaja, ese monstruo volador de allí me parece gracioso... ¿tiene alas? ¿O son sombreros?"},
		{"speaker": 0, "text": "Edward: Ja ja... ¡jajaja! Desconectarse de la realidad a veces no está tan mal... aunque ojalá estuviera Agripina."},
		{"speaker": 2, "text": "Paolo: Sí... chicos, gracias por esta aventura. Esto ha sido increíble. ¡Sigamos!"},
		{"speaker": 1, "text": "Miguel: ¡JAJAJA! Dale, crack. ¡A por más desconexión de la realidad!"}
	],
	[
		{"speaker": 1, "text": "Miguel: Tíos... algo no va bien. ¿Por qué todo se mueve como si estuviéramos dentro de un caleidoscopio? Y ese dragon !!!"},
		{"speaker": 0, "text": "Edward: ¡No sé! Pero estoy empezando a pensar que las ratas nos miraban raro porque sabían lo que venía..."},
		{"speaker": 2, "text": "Paolo: ¡Cállate, Edward! No puedo concentrarme... siento que mi cerebro está intentando escaparse de mi cabeza."},
		{"speaker": 1, "text": "Miguel: ¿Qué? ¡Esto no es normal! Me siento fatal."},
		{"speaker": 0, "text": "Edward: ¡Ay, madre! Creo que estoy viendo a Agripina... pero tiene cara de rata gigante."},
		{"speaker": 2, "text": "Paolo: ¡Basta ya, Edward! ¡Esto no es gracioso! ¡Sácame de aquí!"},
		{"speaker": 1, "text": "Miguel: ¡No puedo más! ¿Por qué nos metimos en esto? ¡Nunca más! ¡Desconectarse de la realidad no esta bien.!"},
		{"speaker": 0, "text": "Edward: ¡Es un mal viaje, tíos! ¡Un mal viaje!"},
		{"speaker": 2, "text": "Paolo: ¡HAGAN QUE PARE! ¡AAAAAHHHH!"}
	]
]
#endregion dialogos

var is_entered_dialogue_area: Array[String] = []

func save_game():
	var save_file = FileAccess.open(save_path, FileAccess.WRITE)
	
	save_file.store_var(game_data)
	save_file = null##cuierra el fichero

func load_game():
	if FileAccess.file_exists(save_path):
		var save_file = FileAccess.open(save_path, FileAccess.READ)
		
		game_data = save_file.get_var()
		save_file = null
