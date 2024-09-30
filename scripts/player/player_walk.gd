class_name Player_Walk extends Player_State

func _phys(_delta : float) -> void:
	checkTurn();
	player.velocity.y += player.gravity * _delta

	if Input.is_action_just_pressed("ui_accept") and player.is_on_floor() and player.canJump:
		player.velocity.y = player.JUMP_VELOCITY

	if abs(player.velocity.x) >= player.SPEED:
		player._change_state(player.state.RUN);

	if player.is_on_wall_only() and player.can_wall_jump:
		player._change_state(player.state.WALLGRAB);
	elif player.x_direction != 0:
		player.velocity.x = move_toward(player.velocity.x, player.x_direction * player.SPEED, player.ACCEL / 10);
	else:
		player._change_state(player.state.IDLE);
	
func _end_state() -> void:
	pass

func _begin_state() -> void:
	player.sprite.play("walk");
	player.current_anim = "walk";
	
func checkTurn() -> void:
	if player.x_direction != 0 && player.x_direction != player.direction:
		player.scale.x *= -1;
		player.direction = player.x_direction;
		player.velocity.x = (abs(player.velocity.x * .9)) * player.x_direction;
