function PlayerMovement(){
	var input_left = keyboard_check(ord("A"));
	var input_right = keyboard_check(ord("D"));
	var input_jump_p = keyboard_check_pressed(vk_space);
	var input_jump_r = keyboard_check_released(vk_space);
	grounded = place_meeting(x, y+1, ObjBlock);

	horizontalDirection = input_right - input_left;

	xSpeed = moveSpeed * horizontalDirection;
	ySpeed += grav;

	// Jump schematics
	if grounded {coyoteTime = coyoteTimeSet}
	else if coyoteTime > 0 {coyoteTime--;}
	
	if (input_jump_p && coyoteTime > 0)
	{
	    ySpeed = jumpSpeed
		jumped = true;
		coyoteTime = 0;
	} else if (grounded || ySpeed > 0) {
		jumped = false;
	}
	if (input_jump_r && jumped)
	{
		ySpeed /= -jumpSpeed;
		jumped = false;
	}
}

function PlayerCollision(){
	// X Collision
	if place_meeting(x + xSpeed, y, ObjBlock)
	{
		var _pixelCheck = sign(xSpeed);
		while !place_meeting(x+_pixelCheck, y, ObjBlock)
		{
			x += _pixelCheck;
		}
	
		xSpeed = 0;
	}
	// Y Collision
	if place_meeting(x + xSpeed, y + ySpeed, ObjBlock)
	{
		var _pixelCheck = sign(ySpeed);
		while !place_meeting(x+xSpeed, y+_pixelCheck, ObjBlock)
		{
			y += _pixelCheck;
		}
	
		ySpeed = 0;
	}
}

function PlayerDrawing(){
	if horizontalDirection != 0 {facing = horizontalDirection;}
	if !grounded {sprite_index = SprFishEggsJump}
	else {
		if horizontalDirection != 0 {sprite_index = SprFishEggsRun;}
		else {sprite_index = SprFishEggsIdle;}
	}
}