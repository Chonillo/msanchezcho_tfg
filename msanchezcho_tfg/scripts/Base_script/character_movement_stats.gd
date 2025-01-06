extends Resource
class_name CharacterMovementStats

@export var move_speed: float = 200
@export var acceleration_speed: float = 400
@export var friction_speed: float = 400
@export var jump_speed: float = 400
@export var acceleration_jump: float = 400
@export var friction_jump: float = 400
#@export var is_started_play: bool = false

@export var projectile_scene: PackedScene  # Arrastra aquí la escena "res://scenes/basicBullet.tscn"
@export var projectile_speed: float = 300.0  # Velocidad del proyectil

#const HIGH_JUMP_VELOCITY = -550.0  # Velocidad de salto mayor
#const PUSH_FORCE = 350
#const MAX_VELOCITY_PUSH = 150
