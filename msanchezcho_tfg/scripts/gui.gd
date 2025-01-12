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
	GLOBAL.game_data["score"] = gems_collected
	$GemsContainer/GemsText.text = str(gems_collected)

func update_life(heart_number: int) -> void:
	print (heart_number)
	## si el daño es 3 quita todos los corazones
	if heart_number == 3:
		$Heart1.visible = false
		$Heart2.visible = false
		$Heart3.visible = false
		return

	# Generar el nombre de la animación correspondiente al corazón
	var animation_name = "disappear_heart_%d" % (heart_number + 1)  # Ejemplo: disappear_heart_1, disappear_heart_2, etc.
	var last_anim_name = "disappear_heart_%d" % (heart_number + 2)
	if $AnimationPlayer.is_playing() and $AnimationPlayer.current_animation == last_anim_name:
		get_node("Heart%d" % (heart_number + 2)).visible = false
	# Verifica si la animación existe en el AnimationPlayer
	if $AnimationPlayer.has_animation(animation_name):
		$AnimationPlayer.play(animation_name)  # Reproduce la animación
	else:
		print("No existe una animación llamada:", animation_name)

func game_over():
	#get_tree().paused = true
	$GameOver/bReiniciar.grab_focus()
	
	var tween: Tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	tween.tween_property($GameOver, "modulate", Color(1,1,1,0.8), 1.0)
	
	##sonido gameover

func _on_b_reiniciar_pressed() -> void:
	get_tree().reload_current_scene()
	
func _on_b_exit_pressed() -> void:
	get_tree().quit()

	
