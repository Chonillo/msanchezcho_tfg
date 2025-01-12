extends Node


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == $mainCharacter2D:
		$mainCharacter2D.can_move = false
		$plataforma1/AnimationPlayer.play("platform")
