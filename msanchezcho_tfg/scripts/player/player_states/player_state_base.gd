class_name PlayerStateBase 
extends StateBase

var player:MainCharacter:
	set (value):
		controlled_node = value
	get:
		return controlled_node
