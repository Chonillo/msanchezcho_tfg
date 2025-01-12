extends Area2D
class_name DialogoArea

func _on_body_entered(body: Node2D) -> void:
	if body is MainCharacter:
		body.manage_dialogue(self.name)
