class_name StateBase 
extends Node

## referencia al nodo que se controla
@onready var controlled_node:Node = self.owner

## referencia a la maquina de estados
var state_machine:StateMachine

#region metodos comunes

## metodo que se ejecuta al entrar en el estado
func start():
	pass

func end():
	pass
	
#endregion
