extends Node

## GUARDADO
var save_path = "user://save_game.dat"

var game_data: Dictionary = {
	"player_health": 3,
	"score": 0
}

func save_game():
	var save_file = FileAccess.open(save_path, FileAccess.WRITE)
	
	save_file.store_var(game_data)
	save_file = null##cuierra el fichero

func load_game():
	if FileAccess.file_exists(save_path):
		var save_file = FileAccess.open(save_path, FileAccess.READ)
		
		game_data = save_file.get_var()
		save_file = null
