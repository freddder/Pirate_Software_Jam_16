extends Node
class_name State

signal ChangeState
var is_active = true

func update(delta : float):
	if !is_active:
		return

func physic_update(delta : float):
	if !is_active:
		return

func enter():
	is_active = true

func exit():
	is_active = false
