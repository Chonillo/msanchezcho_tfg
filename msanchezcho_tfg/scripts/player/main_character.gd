class_name MainCharacter
extends CharacterBody2D

@onready var characters: Array[Sprite2D] = [$SpriteGroup2D/Edward, $SpriteGroup2D/Miguel, $SpriteGroup2D/Paolo]
@onready var animation_names = ["AnimationEdward", "AnimationMiguel", "AnimationPaolo"]
@onready var anim: AnimationPlayer = characters[current_character].get_node(animation_names[current_character])
@onready var sprite: Sprite2D
@onready var effects: AnimatedSprite2D = $effects
@onready var ray_cast_box: RayCast2D = $SpriteGroup2D/detectBox#$detectBox
#region SOUNDS
@onready var jump_sound: AudioStreamPlayer2D = $jump
@onready var double_jump_sound: AudioStreamPlayer2D = $doubleJump
@onready var walk_sound: AudioStreamPlayer2D = $walk
@onready var hit_dmg_sound: AudioStreamPlayer2D = $Hitdmg
@onready var game_over: AudioStreamPlayer2D = $gameOver
@onready var fall_sound: AudioStreamPlayer2D = $fall
@onready var swtich_character: AudioStreamPlayer2D = $swtichCharacter

#endregion
## exports
#@export var projectile_scene: PackedScene ##shot
@export var movement_stats:CharacterMovementStats
## Referencia al cuerpo principal y animaciones
@onready var body: Node2D = $SpriteGroup2D
@export var hud: CanvasLayer
#@export var dialogo_gui: CanvasLayer

##variables
var projectile_scene: PackedScene = preload("res://scenes/stone_bullet.tscn")##shot
var dialogo_gui: PackedScene = preload("res://scenes/dialogo_gui.tscn")
var salir_gui: PackedScene = load("res://scenes/salir_end.tscn")
var player_health = 3
var current_character: int = 0
var states:PlayerStateNames = PlayerStateNames.new()
var colider_direction: int = 0
var can_move = true
var is_next_level = false
var next_level: PackedScene


#region codigo despues de state machine
# Métodos auxiliares para direcciones y animaciones
func set_facing_direction(x:float) -> void:
	if abs(x) > 0:
		body.scale.x = -1 if (x < 0) else 1

func _ready() -> void:
	$StateMachine.change_to(states.SwitchCharacter)
	effects.play("changeCharacter")

func _process(_delta):
	set_facing_direction(velocity.x)
	$Label.text = str(current_character)

func play_animation(animation_name: String):
	anim = characters[current_character].get_node(animation_names[current_character])
	anim.play(animation_name)

func player_damage_control(damage: int):
	
	if damage == 3:
		# Si el daño es 3, cambia directamente al estado de muerte
		player_health = 0
		hud.update_life(3)
		hud.game_over()
		$StateMachine.change_to(states.Death)
		return

	# Reducir la salud del jugador
	player_health -= damage
	if $StateMachine.current_state.name != states.Death:
		hud.update_life(player_health)
		if player_health > 0:
			$StateMachine.change_to(states.Hurt)
		else:
			hud.game_over()
			$StateMachine.change_to(states.Death)

func change_level(chapter: PackedScene):
	#get_tree().change_scene_to_packed(chapter_2)
	is_next_level = true
	next_level = chapter
	GLOBAL.game_data["dialogue_number"] = 4
	run_dialogue_scene()
	#get_tree().call_deferred("change_scene_to_packed", chapter)
	#pass
	
func end_game():
	if GLOBAL.final_bueno:
		GLOBAL.game_data["dialogue_number"] = 5
	else:
		GLOBAL.game_data["dialogue_number"] = 6
	var dialogo_instance = dialogo_gui.instantiate()
	add_sibling(dialogo_instance)
	dialogo_instance.connect("dialogue_finished", _on_dialogue_finished)
		
#endregion

#region dialogue

func manage_dialogue(nombre_area: String):
	if GLOBAL.is_entered_dialogue_area.size() == 0:
		pass
	else:
		for r in GLOBAL.is_entered_dialogue_area:
			if r == nombre_area:
				#print("Registro encontrado:", r)
				return

	# Instanciar el diálogo
	if GLOBAL.game_data["dialogue_number"] == 1:
		run_dialogue_scene()
		GLOBAL.game_data["dialogue_number"] += 1
		GLOBAL.is_entered_dialogue_area.append(nombre_area)
	elif GLOBAL.game_data["dialogue_number"] == 2 :
		run_dialogue_scene()
		GLOBAL.game_data["dialogue_number"] += 1
		GLOBAL.is_entered_dialogue_area.append(nombre_area)
	elif GLOBAL.game_data["dialogue_number"] == 3 :
		run_dialogue_scene()
		GLOBAL.game_data["dialogue_number"] += 1
		GLOBAL.is_entered_dialogue_area.append(nombre_area)
	#elif GLOBAL.game_data["dialogue_number"] == 4 :
		#run_dialogue_scene()
		#GLOBAL.game_data["dialogue_number"] += 1
		#GLOBAL.is_entered_dialogue_area.append(nombre_area)
	
func run_dialogue_scene():
	# Pausar el juego
	get_tree().paused = true
	var dialogo_instance = dialogo_gui.instantiate()
	add_sibling(dialogo_instance)
	#dialogo_instance.fade_in_canvas(hud)
	# Conectar señal para gestionar el final del diálogo
	dialogo_instance.connect("dialogue_finished", _on_dialogue_finished)

func _on_dialogue_finished():
	# Reanudar el juego
	print(GLOBAL.game_data["dialogue_number"])
	if GLOBAL.game_data["dialogue_number"] == 5 or GLOBAL.game_data["dialogue_number"] == 6:
		print("adas")
		get_tree().call_deferred("change_scene_to_packed", salir_gui)
	get_tree().paused = false
	if is_next_level:
		get_tree().call_deferred("change_scene_to_packed", next_level)
	

#endregion
