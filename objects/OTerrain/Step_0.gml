var _mouseX = window_mouse_get_x();
var _mouseY = window_mouse_get_y();

if (!keyboard_check(vk_space)
	&& mouse_check_button(mb_left))
{
	direction += (mouseLastX - _mouseX);
	directionUp = clamp(directionUp + (mouseLastY - _mouseY), -89, 89);
}

mouseLastX = _mouseX;
mouseLastY = _mouseY;

var _speed = keyboard_check(vk_shift) ? 2 : 1;

if (keyboard_check(ord("W")))
{
	x += lengthdir_x(_speed, direction);
	y += lengthdir_y(_speed, direction);
}
else if (keyboard_check(ord("S")))
{
	x -= lengthdir_x(_speed, direction);
	y -= lengthdir_y(_speed, direction);
}

if (keyboard_check(ord("A")))
{
	x += lengthdir_x(_speed, direction + 90);
	y += lengthdir_y(_speed, direction + 90);
}
else if (keyboard_check(ord("D")))
{
	x += lengthdir_x(_speed, direction - 90);
	y += lengthdir_y(_speed, direction - 90);
}

z += (keyboard_check(ord("E")) - keyboard_check(ord("Q"))) * _speed;

camera_set_view_mat(camera, matrix_build_lookat(
	x, y, z,
	x + dcos(direction),
	y - dsin(direction),
	z + dtan(directionUp),
	0, 0, 1));
