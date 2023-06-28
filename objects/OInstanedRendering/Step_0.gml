var _mouseX = window_mouse_get_x();
var _mouseY = window_mouse_get_y();

if (mouse_check_button(mb_any))
{
	direction += mouseLastX - _mouseX;
	directionUp += mouseLastY - _mouseY;
	directionUp = clamp(directionUp, -89, 89);
}

mouseLastX = _mouseX;
mouseLastY = _mouseY;

var _forward = keyboard_check(ord("W")) - keyboard_check(ord("S"));
var _right = keyboard_check(ord("D")) - keyboard_check(ord("A"));
var _up = keyboard_check(ord("E")) - keyboard_check(ord("Q"));
var _speed = keyboard_check(vk_shift) ? 20 : 10;

x += lengthdir_x(1, direction) * _forward * _speed;
y += lengthdir_y(1, direction) * _forward * _speed;

x += lengthdir_x(1, direction - 90) * _right * _speed;
y += lengthdir_y(1, direction - 90) * _right * _speed;

z += _up * _speed;

camera_set_view_mat(camera, matrix_build_lookat(
	x, y, z,
	x + dcos(direction),
	y - dsin(direction),
	z + dtan(directionUp),
	0, 0, 1));
