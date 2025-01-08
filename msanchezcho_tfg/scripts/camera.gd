extends Camera2D

@export_category("Config")

@export_group("Required References")
@export var player: CharacterBody2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	global_position = player.global_position

func _ready():
	limit_left = -32  # Límite izquierdo
	limit_right = 4960
	limit_bottom = 550
