var _x = 8;
var _y = debug ? 24 : 8;
var _text = $"Room: {room_get_name(room)} [SPACE]\n"
	+ $"DebugOverlay: {debug ? "true" : "false"} [F1]\n";

draw_text_color(_x + 1, _y + 1, _text, c_black, c_black, c_black, c_black, 1.0);
draw_text_color(_x, _y, _text, c_yellow, c_yellow, c_yellow, c_yellow, 1.0);
