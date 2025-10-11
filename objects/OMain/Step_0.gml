if (keyboard_check_pressed(vk_space) || room == RmInit)
{
	if (room == room_last)
	{
		room_goto(room_first);
	}
	else
	{
		room_goto_next();
	}
}

if (keyboard_check_pressed(vk_f1))
{
	debug = !debug;
	show_debug_overlay(debug);
}
