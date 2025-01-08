extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body is MainCharacter:
		body.player_damage_control(3)
