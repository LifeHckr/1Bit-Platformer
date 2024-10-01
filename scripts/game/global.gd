extends Node
var text_scene_text : String = "Climb the Tower";
var text_scene_next_scene : String = "res://scenes/starter.tscn";
var canJump : bool = false;
var can_platty : bool = false;
var left_platty : bool = true;
var up_platty : bool = false;
var down_platty : bool = false;
var right_platty : bool = true;
var can_wall_jump : bool = false;
var checkpoint_pos : Vector2 = Vector2.ZERO;
var transition_coords : Vector2 = Vector2.ZERO;

#Progress flags
var second_floors : bool = false;
var controls1 : bool = true;
var constrols2 : bool = true;
var finished_questionmark : bool = false;
