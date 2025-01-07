class_name MainCharacter
extends CharacterBody2D


@onready var characters: Array[Sprite2D] = [$SpriteGroup2D/Edward, $SpriteGroup2D/Miguel, $SpriteGroup2D/Paolo]
@onready var animation_names = ["AnimationEdward", "AnimationMiguel", "AnimationPaolo"]
@onready var anim: AnimationPlayer = characters[current_character].get_node(animation_names[current_character])
@onready var sprite: Sprite2D

#shot
#@export var projectile_scene: PackedScene  # Arrastra aquí la escena "res://scenes/basicBullet.tscn"
@export var projectile_speed: float = 300.0  # Velocidad del proyectil
@export var projectile_scene: PackedScene


@export var movement_stats:CharacterMovementStats
# Referencia al cuerpo principal y animaciones
@onready var body: Node2D = $SpriteGroup2D
#@onready var animation_player = $AnimationPlayer

var current_character: int = 0
var states:PlayerStateNames = PlayerStateNames.new()

#region nuevo codigo
# Métodos auxiliares para direcciones y animaciones
func set_facing_direction(x:float) -> void:
	if abs(x) > 0:
		body.scale.x = -1 if (x < 0) else 1

#func is_facing_right() -> bool:
	#return body.scale.x > 0

func _process(_delta):
	set_facing_direction(velocity.x)
	$Label.text = str(current_character)

func play_animation(animation_name: String):
	anim = characters[current_character].get_node(animation_names[current_character])
	anim.play(animation_name)

func player_damage_control(_damage: int):
	$StateMachine.change_to(states.Hurt)

#endregion
