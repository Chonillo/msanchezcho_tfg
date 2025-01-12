extends Control

var dialogo_gui: PackedScene = preload("res://scenes/dialogo_gui.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$VBoxContainer/Jugar.grab_focus()

func _on_jugar_pressed() -> void:
	#get_tree().paused = true
	visible = false
	var dialogo_instance = dialogo_gui.instantiate()
	add_sibling(dialogo_instance)
	# Conectar señal para gestionar el final del diálogo
	dialogo_instance.connect("dialogue_finished", _on_dialogue_finished)
	

func _on_dialogue_finished():
	GLOBAL.game_data["dialogue_number"] = 1
	#get_tree().paused = false
	$VBoxContainer/Jugar.disabled = true
	$VBoxContainer/Salir.disabled = true
	#$AudioStreamPlayer.stop()
	get_tree().change_scene_to_file("res://scenes/chapter_1.tscn")

func _on_salir_pressed() -> void:
	get_tree().quit()
