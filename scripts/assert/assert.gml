/// @func assert(_expr[, _error])
///
/// @desc Shows an error if expression is false.
///
/// @param {Bool} _expr The expression to test.
/// @param {String} [_error] The error message to show. Defaults to "Assertion failed!".
function assert(_expr, _error = "Assertion failed!")
{
	gml_pragma("forceinline");
	if (!_expr)
	{
		show_error(_error, true);
	}
}
