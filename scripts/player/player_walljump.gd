class_name Player_WallJump extends Player_State

func _phys(_delta : float) -> void:
	player.velocity.y += player.gravity * _delta;
	
	if Input.is_action_just_pressed("ui_accept") and player.is_on_wall() and player.canJump:
		player.velocity.y = player.JUMP_VELOCITY
			
	if not player.is_on_wall_only():
		if player.x_direction == -1 * player.direction:
			player.velocity.x = player.SPEED / 2 * player.direction;
			player._change_state(player.state.WALK);
		else:
			player._change_state(player.state.IDLE);
	elif player.is_on_wall_only() and player.velocity.y > 0:
		player._change_state(player.state.WALLGRAB);
	
func _end_state() -> void:
	pass;

func _begin_state() -> void:
	player.sprite.play("idle");
	player.current_anim = "idle";
	if player.x_direction == player.direction:
		player.velocity.x = player.SPEED / 2 * player.x_direction;
		player.audio.stream = player.wallJumpSound;
		player.audio.play();
	else:
		player.audio.stream = player.jumpSound;
		player.audio.play();
