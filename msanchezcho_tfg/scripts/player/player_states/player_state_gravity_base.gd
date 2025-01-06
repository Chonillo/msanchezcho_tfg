class_name PlayerStateGravityBase 
extends PlayerStateBase

var gravity:float = ProjectSettings.get_setting("physics/2d/default_gravity")

func handle_gravity(delta):
	controlled_node.velocity.y += gravity * delta

#region Funciones que controlan la friccion y aceleracion en diferentes puntos
func handle_acceleration(input_axis, delta):
	if input_axis !=0:
		player.velocity.x = move_toward(player.velocity.x, player.movement_stats.move_speed * input_axis, player.movement_stats.acceleration_speed * delta)

func apply_friction_on_floor(input_axis, delta):
	if input_axis == 0 and player.is_on_floor():
		player.velocity.x = move_toward(player.velocity.x, 0, player.movement_stats.friction_speed * delta)

func handle_acceleration_jump(input_axis, delta):
	if input_axis != 0:
		player.velocity.x = move_toward(player.velocity.x, player.movement_stats.move_speed * input_axis, player.movement_stats.acceleration_jump * delta)

func apply_friction_jump(input_axis, delta):
	if input_axis == 0 and not player.is_on_floor():
		player.velocity.x = move_toward(player.velocity.x, 0, player.movement_stats.friction_jump * delta)

#endregion
