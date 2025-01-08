extends CanvasLayer
class_name Hud

var max_life: int = 3  # Número máximo de vidas
var current_life: int = max_life  # Vidas actuales
var gems_collected: int = 0  # Contador de gemas recolectadas

func _ready() -> void:
	$GemsContainer/GemsText.text = str(gems_collected)
	$AnimationPlayer.play("heart_ani")


# Función para actualizar el contador
func update_gems(count: int) -> void:
	gems_collected += count
	$GemsContainer/GemsText.text = str(gems_collected)

func update_life(heart_number: int) -> void:
	# Generar el nombre de la animación correspondiente al corazón
	var animation_name = "disappear_heart_%d" % heart_number  # Ejemplo: disappear_heart_1, disappear_heart_2, etc.
	var last_anim_name = "disappear_heart_%d" % (heart_number + 1)
	print($AnimationPlayer.current_animation)
	print(last_anim_name)
	if $AnimationPlayer.is_playing() and $AnimationPlayer.current_animation == last_anim_name:
		get_node("Heart%d" % (heart_number + 1)).visible = false
	# Verifica si la animación existe en el AnimationPlayer
	if $AnimationPlayer.has_animation(animation_name):
		$AnimationPlayer.play(animation_name)  # Reproduce la animación
		# Opcional: Usa una señal para ocultar el corazón después de la animación
		#get_node("Heart%d" % heart_number).visible = false
	else:
		print("No existe una animación llamada:", animation_name)

func game_over():
	#get_tree().paused = true
	#$ColorRect/VBoxContainer/HBoxContainer/bExit.grab_focus()
	
	var tween: Tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	tween.tween_property($GameOver, "modulate", Color(1,1,1,0.8), 1.0)
	
	##sonido gameover

func _on_b_reiniciar_pressed() -> void:
	get_tree().reload_current_scene()
	
func _on_b_exit_pressed() -> void:
	get_tree().quit()

	
