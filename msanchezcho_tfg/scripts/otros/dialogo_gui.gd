extends CanvasLayer

var dialogues = []
var speaker_names = ["Edward", "Miguel", "Paolo"]
var current_index: int = 0
signal dialogue_finished

@onready var visual_text: RichTextLabel = $Control/RichTextLabel
@onready var characters = {
	"Edward": $Control/spriteEdward,
	"Miguel": $Control/spriteMiguel,
	"Paolo": $Control/spritePaolo
}
@onready var positions = {
	"speaker": Vector2(134, 100),
	#"speakerEdward": Vector2(159, 189),
	"listener_1": Vector2(367, 100),
	"listener_2": Vector2(445, 100),
}

func _ready():
	# Obtener el número de diálogo desde GLOBAL
	var dialogue_number = GLOBAL.game_data["dialogue_number"]
	# Cargar el diálogo correspondiente
	dialogues = GLOBAL.dialogues[dialogue_number]
	update_text()  # Asegura que el texto inicial se muestra
	update_characters()

func update_text():
	visual_text.text = dialogues[current_index]["text"]  # Asigna el texto actual
	visual_text.visible_ratio = 0  # Reinicia el efecto de escritura
	show_text()

func show_text():
	var tween = create_tween()
	tween.tween_property(visual_text, "visible_ratio", 1, 0.1)  # Anima la visibilidad del texto

func update_characters():
	var speaker = speaker_names[dialogues[current_index]["speaker"]]

	# Resetea la posición y opacidad de todos los personajes
	var listeners = []
	for character_name in characters.keys():
		var sprite = characters[character_name]
		if character_name == speaker:
			sprite.position = positions["speaker"]
			#sprite.modulate = Color(1, 1, 1, 1)  # Totalmente opaco
			sprite.flip_h = false
		else:
			listeners.append(character_name)
			#sprite.modulate = Color(1, 1, 1, 0.5)  # Semi-transparente

	# Ajusta la posición de los oyentes
	if listeners.size() >= 1:
		characters[listeners[0]].position = positions["listener_1"]
		characters[listeners[0]].flip_h = true
	if listeners.size() >= 2:
		characters[listeners[1]].position = positions["listener_2"]
		characters[listeners[1]].flip_h = true

func next_text():
	if current_index < dialogues.size() - 1:
		current_index += 1
		update_text()
		update_characters()
	else:
		dialogue_finished.emit()# Emitir la señal al terminar el diálogo
		queue_free()  # Eliminar el diálogo

func _input(event):
	if event.is_action_pressed("ui_accept") or Input.is_action_just_pressed("ui_special_skill") or Input.is_action_just_pressed("ui_select"):
		next_text()


# Animar la aparición del CanvasLayer
func fade_in_canvas(canvas_layer: CanvasLayer):
	var tween = create_tween()
	canvas_layer.visible = true 
	tween.tween_property(canvas_layer, "modulate:a", 1, 0.5)  # Aumenta la opacidad

# Animar la desaparición del CanvasLayer
func fade_out_canvas(canvas_layer: CanvasLayer):
	var tween = create_tween()
	tween.tween_property(canvas_layer, "modulate:a", 0, 0.5)  # Reduce la opacidad
	tween.tween_callback(Callable(self, "_on_fade_out_complete").bind(canvas_layer))  # Llama al callback con el CanvasLayer

# Callback para manejar la visibilidad
func _on_fade_out_complete(canvas_layer: CanvasLayer):
	canvas_layer.visible = false  # Ocúltalo después de la animación
