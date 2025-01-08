class_name MainCharacter
extends CharacterBody2D

@onready var characters: Array[Sprite2D] = [$SpriteGroup2D/Edward, $SpriteGroup2D/Miguel, $SpriteGroup2D/Paolo]
@onready var animation_names = ["AnimationEdward", "AnimationMiguel", "AnimationPaolo"]
@onready var anim: AnimationPlayer = characters[current_character].get_node(animation_names[current_character])
@onready var sprite: Sprite2D
@onready var effects: AnimatedSprite2D = $effects
@onready var ray_cast_box: RayCast2D = $SpriteGroup2D/detectBox#$detectBox
## exports
@export var projectile_scene: PackedScene ##shot
@export var movement_stats:CharacterMovementStats
## Referencia al cuerpo principal y animaciones
@onready var body: Node2D = $SpriteGroup2D
@export var hud: CanvasLayer

##variables
var player_health = 3
var current_character: int = 0
var states:PlayerStateNames = PlayerStateNames.new()


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
		hud.game_over()
		$StateMachine.change_to(states.Death)
		return

	if player_health > 0:
		player_health -= damage
		hud.update_life(player_health)
		if player_health > 0:
			$StateMachine.change_to(states.Hurt)
		else:
			hud.game_over()
			$StateMachine.change_to(states.Death)
	elif $StateMachine.current_state.name != states.Death:
		hud.game_over()
		$StateMachine.change_to(states.Death)
		
#endregion
