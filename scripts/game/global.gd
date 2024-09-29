extends Node
var text_scene_text : String = "Climb the Tower";
var text_scene_next_scene : String = "res://scenes/starter.tscn";
var canJump : bool = false;
var can_platty : bool = false;
var left_platty : bool = false;
var up_platty : bool = false;
var down_platty : bool = false;
var right_platty : bool = false;
var can_wall_jump : bool = false;
var controls1 : bool = true;
var checkpoint_pos : Vector2 = Vector2.ZERO;
