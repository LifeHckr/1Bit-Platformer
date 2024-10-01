class_name Player extends CharacterBody2D

@onready var anims : AnimationPlayer = get_node("duber/anims");
@onready var sprite : AnimatedSprite2D = get_node("duber");
@onready var ray : RayCast2D = get_node("wall_check");
@onready var one_way_check : ShapeCast2D = get_node("up_do");
@onready var audio : AudioStreamPlayer = get_node("audio");
var one_way_obj : Node2D = null;
var web_fix_cast : ShapeCast2D = null; #rapier physics currently wont let area2d intersect characters in web export, for some reason
var current_anim : String = "idle";

@onready var platty : PackedScene = preload("res://scenes/objects/plat.tscn");
@onready var d_particles : PackedScene = preload("res://scenes/small_things/death_particles.tscn");

var jumpSound : AudioStream = preload("res://sounds/jump.wav"); #done
var plattySound : AudioStream = preload("res://sounds/platty.wav"); #done
var hurtSound : AudioStream = preload("res://sounds/hurt.wav"); #done
var wallJumpSound : AudioStream = preload("res://sounds/wall_jump.wav");#done
var pickupSound : AudioStream = preload("res://sounds/pickup.wav");
var flagSound : AudioStream = preload("res://sounds/snappy.wav"); #done


var cur_platty : StaticBody2D;

const SPEED : float = 300.0
const ACCEL : float = 75.0;
const JUMP_VELOCITY : float = -400.0
var stored_velo : float = 0;
var canJump : bool = Global.canJump;
var can_platty : bool = Global.can_platty;
var left_platty : bool = Global.left_platty;
var up_platty : bool = Global.up_platty;
var down_platty : bool = Global.down_platty;
var right_platty : bool = Global.right_platty;
var can_wall_jump : bool = Global.can_wall_jump;
var platty_cooldown : int = 10;
var platty_timer : int = 0;
var direction : float = 1;
var x_direction : float = 0;
enum state {IDLE, WALK, RUN, JUMP, WALLGRAB, WALLJUMP};
var cur_state : state = state.IDLE;
var dead : bool = false;
var state_machine : Array[Player_State] = [Player_Idle.new(self), Player_Walk.new(self), Player_Run.new(self), null, Player_WallGrab.new(self), Player_WallJump.new(self)];
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready() -> void:
	anims.stop();
	if Global.controls1:
		var spritey : Area2D = load("res://scenes/fade_away_sprite.tscn").instantiate();
		spritey.position.y = self.position.y - 40;
		spritey.position.x = self.position.x;
		spritey.texture = load("res://sprites/wasd.png");
		spritey.input_based = true;
		get_tree().get_root().call_deferred("add_child", spritey);
		Global.controls1 = false;
	Global.checkpoint_pos = self.position;
	
	web_fix_cast = get_node("web_fix");

func _process(_delta: float) -> void:
	platty_timer += 1;

func _physics_process(delta : float) -> void:
	x_direction = Input.get_axis("ui_left", "ui_right");
	state_machine[cur_state]._phys(delta);
	
	if one_way_check.is_colliding():
		one_way_obj = one_way_check.get_collider(0);
		if one_way_obj != null:
			one_way_obj.set_collision_layer_value(1, false);
			one_way_obj.set_collision_mask_value(1, false);
	else:
		if one_way_obj != null:
			one_way_obj.set_collision_layer_value(1, true);
			one_way_obj.set_collision_mask_value(1, true);
	
	if !dead and web_fix_cast.is_colliding():
		var testee = web_fix_cast.get_collider(0);
		if testee is Area2D:
			testee.body_entered.emit(self);
	
	move_and_slide();

func _input(event):	
	if Global.can_wall_jump and event.is_action_pressed("wall_toggle"):
		self.can_wall_jump = !can_wall_jump;
	
	if dead || !can_platty || platty_timer <= platty_cooldown:
		return;
	if event.is_action_pressed("left") and left_platty:
		if cur_platty != null:
			cur_platty.phase();
		anims.play("p1");
		audio.stream = plattySound;
		audio.play();
		platty_timer = 0;
		cur_platty = platty.instantiate();
		cur_platty.rotation = deg_to_rad(90);
		cur_platty.position.x = self.position.x - 15.5;
		cur_platty.position.y = self.position.y + 5;
		get_tree().get_root().add_child(cur_platty);
		
	if event.is_action_pressed("right") and right_platty:
		if cur_platty != null:
			cur_platty.phase();
		anims.play("p1");
		audio.stream = plattySound;
		audio.play();
		platty_timer = 0;
		cur_platty = platty.instantiate();
		cur_platty.rotation = deg_to_rad(270);
		cur_platty.position.x = self.position.x + 15.5;
		cur_platty.position.y = self.position.y + 5;
		get_tree().get_root().add_child(cur_platty);
		
	if event.is_action_pressed("up") and up_platty:
		if cur_platty != null:
			cur_platty.phase();
		anims.play("p1");
		platty_timer = 0;
		cur_platty = platty.instantiate();
		cur_platty.rotation = deg_to_rad(180);
		cur_platty.position.x = self.position.x;
		cur_platty.position.y = self.position.y - 15;
		get_tree().get_root().add_child(cur_platty);
		
	if event.is_action_pressed("down") and down_platty:
		if cur_platty != null:
			cur_platty.phase();
		anims.play("p1");
		platty_timer = 0;
		cur_platty = platty.instantiate();
		cur_platty.position.x = self.position.x;
		cur_platty.position.y = self.position.y + 15;
		get_tree().get_root().add_child(cur_platty);
		
func no_platty() -> void:
	pass;
		
func _change_state(next_state : state) -> bool:
	state_machine[cur_state]._end_state();
	state_machine[next_state]._begin_state();
	cur_state = next_state;
	return true;

func checkTurn() -> void:
	if x_direction != 0 && x_direction != direction:
		self.scale.x *= -1;
		direction = x_direction;

func play_cur_anim() -> void:
	sprite.play(current_anim);

func flip() -> void:
	self.scale.x *= -1;
	direction *= -1;

func death() -> void:
	if dead:
		return;
	dead = true;
	audio.stream = hurtSound;
	audio.play();
	var particles : CPUParticles2D = d_particles.instantiate();
	self.velocity = Vector2.ZERO;
	particles.position = self.position;
	particles.finished.connect(respawn);
	get_tree().get_root().add_child(particles);
	particles.emitting = true;
	self.visible = false;

func respawn() -> void:
	self.position = Global.checkpoint_pos;
	self.visible = true;
	velocity = Vector2.ZERO;
	#more web fix shenanigans
	var timer1 : SceneTreeTimer = get_tree().create_timer(.1);
	await timer1.timeout;
	dead = false;
