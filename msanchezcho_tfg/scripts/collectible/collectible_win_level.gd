extends Area2D

var chapter_2 = load("res://scenes/chapter_2.tscn")

func _on_body_entered(body: Node2D) -> void:
	
	if body is MainCharacter:
		#$AudioStreamPlayer2D.play()
		#body.change_level(chapter_2)
		$AudioStreamPlayer2D.play()
		# Conecta la señal finished del AudioStreamPlayer al método _on_audio_finished
		$AudioStreamPlayer2D.connect("finished", Callable(self, "_on_audio_finished").bind(body))
	pass # Replace with function body.


func _on_audio_finished(body: Node):
	# Cambia el nivel después de que el sonido termine
	body.change_level(chapter_2)
