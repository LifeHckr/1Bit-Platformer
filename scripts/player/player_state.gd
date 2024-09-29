class_name Player_State extends RefCounted

var player : Player;

func _init(owner : Node2D):
	player = owner;

func _phys(_delta : float) -> void:
	pass;
	
func _end_state() -> void:
	pass

func _begin_state() -> void:
	pass;
