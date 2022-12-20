/// @func decode_float_vec3(_x, _y, _z)
///
/// @param {Real} _x
/// @param {Real} _y
/// @param {Real} _z
///
/// @return {Real}
function decode_float_vec3(_x, _y, _z)
{
	gml_pragma("forceinline");
	return (_x + (_y / 255) + (_z / 65025));
}
