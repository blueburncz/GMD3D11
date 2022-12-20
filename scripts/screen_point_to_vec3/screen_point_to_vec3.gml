/// @func screen_point_to_vec3(_viewMat, _fov, _aspect, _x, _y)
///
/// @param {Array} _viewMat
/// @param {Real} _fov
/// @param {Real} _aspect
/// @param {Real} _x
/// @param {Real} _y
function screen_point_to_vec3(_viewMat, _fov, _aspect, _x, _y)
{
	var _rightX = _viewMat[0];
	var _rightY = _viewMat[4];
	var _rightZ = _viewMat[8];

	var _upX = _viewMat[1]
	var _upY = _viewMat[5];
	var _upZ = _viewMat[9];

	var _forwardX = _viewMat[2]
	var _forwardY = _viewMat[6];
	var _forwardZ = _viewMat[10];

	var _tFov = dtan(_fov * 0.5);

	_upX *= _tFov;
	_upY *= _tFov;
	_upZ *= _tFov;

	_rightX *= _tFov * _aspect;
	_rightY *= _tFov * _aspect;
	_rightZ *= _tFov * _aspect;

	var _screenWidth = window_get_width();
	var _screenHeight = window_get_height();

	return [
		_forwardX + (_upX * (1 - 2 * (_y / _screenHeight))) + (_rightX * (2 * (_x / _screenWidth) - 1)),
		_forwardY + (_upY * (1 - 2 * (_y / _screenHeight))) + (_rightY * (2 * (_x / _screenWidth) - 1)),
		_forwardZ + (_upZ * (1 - 2 * (_y / _screenHeight))) + (_rightZ * (2 * (_x / _screenWidth) - 1)),
	];
}
