////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Defines
//

/// @macro {String} Path to the GMD3D11 dynamic library. Default value is "GMD3D11.dll".
#macro GMD3D11_PATH "GMD3D11.dll"

/// @macro {Bool} Expands to `true` if GMD3D11 is supported on the current platform.
#macro GMD3D11_IS_SUPPORTED (os_type == os_windows && os_browser == browser_not_a_browser)

/// @macro {Real} An invalid/null resource ID.
#macro GMD3D11_ID_INVALID -1

/// @macro {Real} Maximum number of slots for shader resources.
#macro D3D11_COMMONSHADER_INPUT_RESOURCE_SLOT_COUNT 128

/// @macro {Real} Maximum number of simultaneous render targets.
#macro D3D11_SIMULTANEOUS_RENDER_TARGET_COUNT 8

/// @macro {Real} Maximum number of workgroup size in {@link d3d11_compute_dispatch}.
#macro D3D11_CS_DISPATCH_MAX_THREAD_GROUPS_PER_DIMENSION 65535

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Types
//

/// @macro {Real} A boolean value.
#macro D3D11_BOOL 0

/// @macro {Real} An integer value.
#macro D3D11_INT 1

/// @macro {Real} A 2D vector of integers.
#macro D3D11_INT2 2

/// @macro {Real} A 3D vector of integers.
#macro D3D11_INT3 3

/// @macro {Real} A 4D vector of integers.
#macro D3D11_INT4 4

/// @macro {Real} An unsigned integer.
#macro D3D11_UINT 5

/// @macro {Real} A 2D vector of unsigned integers.
#macro D3D11_UINT2 6

/// @macro {Real} A 3D vector of unsigned integers.
#macro D3D11_UINT3 7

/// @macro {Real} A 4D vector of unsigned integers.
#macro D3D11_UINT4 8

/// @macro {Real} A floating-point value.
#macro D3D11_FLOAT 9

/// @macro {Real} A 2D vector of floats.
#macro D3D11_FLOAT2 10

/// @macro {Real} A 3D vector of floats.
#macro D3D11_FLOAT3 11

/// @macro {Real} A 4D vector of floats.
#macro D3D11_FLOAT4 12

/// @macro {Real} A 4x4 matrix of floats.
#macro D3D11_FLOAT4X4 13

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Common structs
//

/// @func D3D11_SAMPLE_DESC()
///
/// @desc
function D3D11_SAMPLE_DESC() constructor
{
	/// @var {Real}
	Count = 0;

	/// @var {Real}
	Quality = 0;

	/// @func to_buffer(_buffer)
	///
	/// @desc
	///
	/// @param {Id.Buffer} _buffer
	static to_buffer = function (_buffer)
	{
		buffer_write(_buffer, buffer_u32, Count);
		buffer_write(_buffer, buffer_u32, Quality);
	};
}

/// @func D3D11_SUBRESOURCE_DATA()
///
/// @desc
function D3D11_SUBRESOURCE_DATA() constructor
{
	/// @var {Pointer}
	pSysMem = 0;

	/// @var {Real}
	SysMemPitch = 0;

	/// @var {Real}
	SysMemSlicePitch = 0;
}

/// @func D3D11_BUFFER_SRV()
///
/// @desc
function D3D11_BUFFER_SRV() constructor
{
#region Union 1
	/// @var {Real, Undefined}
	FirstElement = undefined;

	/// @var {Real, Undefined}
	ElementOffset = undefined;
#endregion

#region Union 2
	/// @var {Real, Undefined}
	NumElements = undefined;

	/// @var {Real, Undefined}
	ElementWidth = undefined;
#endregion

	/// @func to_buffer(_buffer)
	///
	/// @desc
	///
	/// @param {Id.Buffer} _buffer
	static to_buffer = function (_buffer)
	{
		buffer_write(_buffer, buffer_u32, (FirstElement ?? NumElements) ?? 0);
		buffer_write(_buffer, buffer_u32, (ElementOffset ?? ElementWidth) ?? 0);
	};
}

/// @func D3D11_TEX1D_SRV()
///
/// @desc
function D3D11_TEX1D_SRV() constructor
{
	/// @var {Real}
	MostDetailedMip = 0;

	/// @var {Real}
	MipLevels = 0;

	/// @func to_buffer(_buffer)
	///
	/// @desc
	///
	/// @param {Id.Buffer} _buffer
	static to_buffer = function (_buffer)
	{
		buffer_write(_buffer, buffer_u32, MostDetailedMip);
		buffer_write(_buffer, buffer_u32, MipLevels);
	};
}

/// @func D3D11_TEX1D_ARRAY_SRV()
///
/// @desc
function D3D11_TEX1D_ARRAY_SRV() constructor
{
	/// @var {Real}
	MostDetailedMip = 0;

	/// @var {Real}
	MipLevels = 0;

	/// @var {Real}
	FirstArraySlice = 0;

	/// @var {Real}
	ArraySize = 0;

	/// @func to_buffer(_buffer)
	///
	/// @desc
	///
	/// @param {Id.Buffer} _buffer
	static to_buffer = function (_buffer)
	{
		buffer_write(_buffer, buffer_u32, MostDetailedMip);
		buffer_write(_buffer, buffer_u32, MipLevels);
		buffer_write(_buffer, buffer_u32, FirstArraySlice);
		buffer_write(_buffer, buffer_u32, ArraySize);
	};
}

/// @func D3D11_TEX2D_SRV()
///
/// @desc
function D3D11_TEX2D_SRV() constructor
{
	/// @var {Real}
	MostDetailedMip = 0;

	/// @var {Real}
	MipLevels = 0;

	/// @func to_buffer(_buffer)
	///
	/// @desc
	///
	/// @param {Id.Buffer} _buffer
	static to_buffer = function (_buffer)
	{
		buffer_write(_buffer, buffer_u32, MostDetailedMip);
		buffer_write(_buffer, buffer_u32, MipLevels);
	};
}

/// @func D3D11_TEX2D_ARRAY_SRV()
///
/// @desc
function D3D11_TEX2D_ARRAY_SRV() constructor
{
	/// @var {Real}
	MostDetailedMip = 0;

	/// @var {Real}
	MipLevels = 0;

	/// @var {Real}
	FirstArraySlice = 0;

	/// @var {Real}
	ArraySize = 0;

	/// @func to_buffer(_buffer)
	///
	/// @desc
	///
	/// @param {Id.Buffer} _buffer
	static to_buffer = function (_buffer)
	{
		buffer_write(_buffer, buffer_u32, MostDetailedMip);
		buffer_write(_buffer, buffer_u32, MipLevels);
		buffer_write(_buffer, buffer_u32, FirstArraySlice);
		buffer_write(_buffer, buffer_u32, ArraySize);
	};
}

/// @func D3D11_TEX2DMS_SRV()
///
/// @desc
function D3D11_TEX2DMS_SRV() constructor
{
	/// @func to_buffer(_buffer)
	///
	/// @desc
	///
	/// @param {Id.Buffer} _buffer
	static to_buffer = function (_buffer)
	{
	};
}

/// @func D3D11_TEX2DMS_ARRAY_SRV()
///
/// @desc
function D3D11_TEX2DMS_ARRAY_SRV() constructor
{
	/// @var {Real}
	FirstArraySlice = 0;

	/// @var {Real}
	ArraySize = 0;

	/// @func to_buffer(_buffer)
	///
	/// @desc
	///
	/// @param {Id.Buffer} _buffer
	static to_buffer = function (_buffer)
	{
		buffer_write(_buffer, buffer_u32, FirstArraySlice);
		buffer_write(_buffer, buffer_u32, ArraySize);
	};
}

/// @func D3D11_TEX3D_SRV()
///
/// @desc
function D3D11_TEX3D_SRV() constructor
{
	/// @var {Real}
	MostDetailedMip = 0;

	/// @var {Real}
	MipLevels = 0;

	/// @func to_buffer(_buffer)
	///
	/// @desc
	///
	/// @param {Id.Buffer} _buffer
	static to_buffer = function (_buffer)
	{
		buffer_write(_buffer, buffer_u32, MostDetailedMip);
		buffer_write(_buffer, buffer_u32, MipLevels);
	};
}

/// @func D3D11_TEXCUBE_SRV()
///
/// @desc
function D3D11_TEXCUBE_SRV() constructor
{
	/// @var {Real}
	MostDetailedMip = 0;

	/// @var {Real}
	MipLevels = 0;

	/// @func to_buffer(_buffer)
	///
	/// @desc
	///
	/// @param {Id.Buffer} _buffer
	static to_buffer = function (_buffer)
	{
		buffer_write(_buffer, buffer_u32, MostDetailedMip);
		buffer_write(_buffer, buffer_u32, MipLevels);
	};
}

/// @func D3D11_TEXCUBE_ARRAY_SRV()
///
/// @desc
function D3D11_TEXCUBE_ARRAY_SRV() constructor
{
	/// @var {Real}
	MostDetailedMip = 0;

	/// @var {Real}
	MipLevels = 0;

	/// @var {Real}
	First2DArrayFace = 0;

	/// @var {Real}
	NumCubes = 0;

	/// @func to_buffer(_buffer)
	///
	/// @desc
	///
	/// @param {Id.Buffer} _buffer
	static to_buffer = function (_buffer)
	{
		buffer_write(_buffer, buffer_u32, MostDetailedMip);
		buffer_write(_buffer, buffer_u32, MipLevels);
		buffer_write(_buffer, buffer_u32, First2DArrayFace);
		buffer_write(_buffer, buffer_u32, NumCubes);
	};
}

/// @func D3D11_BUFFEREX_SRV()
///
/// @desc
function D3D11_BUFFEREX_SRV() constructor
{
	/// @var {Real}
	FirstElement = 0;

	/// @var {Real}
	NumElements = 0;

	/// @var {Real}
	Flags = 0;

	/// @func to_buffer(_buffer)
	///
	/// @desc
	///
	/// @param {Id.Buffer} _buffer
	static to_buffer = function (_buffer)
	{
		buffer_write(_buffer, buffer_u32, FirstElement);
		buffer_write(_buffer, buffer_u32, NumElements);
		buffer_write(_buffer, buffer_u32, Flags);
	};
}

/// @func D3D11_SHADER_RESOURCE_VIEW_DESC()
///
/// @desc
function D3D11_SHADER_RESOURCE_VIEW_DESC() constructor
{
	/// @var {Real}
	Format = DXGI_FORMAT_UNKNOWN;

	/// @var {Real}
	ViewDimension = D3D_SRV_DIMENSION_UNKNOWN;

	/// @var {Struct.D3D11_BUFFER_SRV, Undefined}
	Buffer = undefined;

	/// @var {Struct.D3D11_TEX1D_SRV, Undefined}
	Texture1D = undefined;

	/// @var {Struct.D3D11_TEX1D_ARRAY_SRV, Undefined}
	Texture1DArray = undefined;

	/// @var {Struct.D3D11_TEX2D_SRV, Undefined}
	Texture2D = undefined;

	/// @var {Struct.D3D11_TEX2D_ARRAY_SRV, Undefined}
	Texture2DArray = undefined;

	/// @var {Struct.D3D11_TEX2DMS_SRV, Undefined}
	Texture2DMS = undefined;

	/// @var {Struct.D3D11_TEX2DMS_ARRAY_SRV, Undefined}
	Texture2DMSArray = undefined;

	/// @var {Struct.D3D11_TEX3D_SRV, Undefined}
	Texture3D = undefined;

	/// @var {Struct.D3D11_TEXCUBE_SRV, Undefined}
	TextureCube = undefined;

	/// @var {Struct.D3D11_TEXCUBE_ARRAY_SRV, Undefined}
	TextureCubeArray = undefined;

	/// @var {Struct.D3D11_BUFFEREX_SRV, Undefined}
	BufferEx = undefined;

	/// @func to_buffer(_buffer)
	///
	/// @desc
	///
	/// @param {Id.Buffer} _buffer
	static to_buffer = function (_buffer)
	{
		buffer_write(_buffer, buffer_u32, Format);
		buffer_write(_buffer, buffer_u32, ViewDimension);

		switch (ViewDimension)
		{
			case D3D_SRV_DIMENSION_UNKNOWN:
				break;

			case D3D_SRV_DIMENSION_BUFFER:
				Buffer.to_buffer(_buffer);
				break;

			case D3D_SRV_DIMENSION_TEXTURE1D:
				Texture1D.to_buffer(_buffer);
				break;

			case D3D_SRV_DIMENSION_TEXTURE1DARRAY:
				Texture1DArray.to_buffer(_buffer);
				break;

			case D3D_SRV_DIMENSION_TEXTURE2D:
				Texture2D.to_buffer(_buffer);
				break;

			case D3D_SRV_DIMENSION_TEXTURE2DARRAY:
				Texture2DArray.to_buffer(_buffer);
				break;

			case D3D_SRV_DIMENSION_TEXTURE2DMS:
				Texture2DMS.to_buffer(_buffer);
				break;

			case D3D_SRV_DIMENSION_TEXTURE2DMSARRAY:
				Texture2DMSArray.to_buffer(_buffer);
				break;

			case D3D_SRV_DIMENSION_TEXTURE3D:
				Texture3D.to_buffer(_buffer);
				break;

			case D3D_SRV_DIMENSION_TEXTURECUBE:
				TextureCube.to_buffer(_buffer);
				break;

			case D3D_SRV_DIMENSION_TEXTURECUBEARRAY:
				TextureCubeArray.to_buffer(_buffer);
				break;

			case D3D_SRV_DIMENSION_BUFFEREX:
				BufferEx.to_buffer(_buffer);
				break;

			default:
				show_error("Invalid ViewDimension!", true);
				break;
		}
	};
}

/// @func D3D11_BUFFER_UAV()
///
/// @desc
function D3D11_BUFFER_UAV() constructor
{
	/// @var {Real}
	FirstElement = 0;

	/// @var {Real}
	NumElements = 0;

	/// @var {Real}
	Flags = 0;

	/// @func to_buffer(_buffer)
	///
	/// @desc
	///
	/// @param {Id.Buffer} _buffer
	static to_buffer = function (_buffer)
	{
		buffer_write(_buffer, buffer_u32, FirstElement);
		buffer_write(_buffer, buffer_u32, NumElements);
		buffer_write(_buffer, buffer_u32, Flags);
	};
}

/// @func D3D11_TEX1D_UAV()
///
/// @desc
function D3D11_TEX1D_UAV() constructor
{
	/// @var {Real}
	MipSlice = 0;

	/// @func to_buffer(_buffer)
	///
	/// @desc
	///
	/// @param {Id.Buffer} _buffer
	static to_buffer = function (_buffer)
	{
		buffer_write(_buffer, buffer_u32, MipSlice);
	};
}

/// @func D3D11_TEX1D_ARRAY_UAV()
///
/// @desc
function D3D11_TEX1D_ARRAY_UAV() constructor
{
	/// @var {Real}
	MipSlice = 0;

	/// @var {Real}
	FirstArraySlice = 0;

	/// @var {Real}
	ArraySize = 0;

	/// @func to_buffer(_buffer)
	///
	/// @desc
	///
	/// @param {Id.Buffer} _buffer
	static to_buffer = function (_buffer)
	{
		buffer_write(_buffer, buffer_u32, MipSlice);
		buffer_write(_buffer, buffer_u32, FirstArraySlice);
		buffer_write(_buffer, buffer_u32, ArraySize);
	};
}

/// @func D3D11_TEX2D_UAV()
///
/// @desc
function D3D11_TEX2D_UAV() constructor
{
	/// @var {Real}
	MipSlice = 0;

	/// @func to_buffer(_buffer)
	///
	/// @desc
	///
	/// @param {Id.Buffer} _buffer
	static to_buffer = function (_buffer)
	{
		buffer_write(_buffer, buffer_u32, MipSlice);
	};
}

/// @func D3D11_TEX2D_ARRAY_UAV()
///
/// @desc
function D3D11_TEX2D_ARRAY_UAV() constructor
{
	/// @var {Real}
	MipSlice = 0;

	/// @var {Real}
	FirstArraySlice = 0;

	/// @var {Real}
	ArraySize = 0;

	/// @func to_buffer(_buffer)
	///
	/// @desc
	///
	/// @param {Id.Buffer} _buffer
	static to_buffer = function (_buffer)
	{
		buffer_write(_buffer, buffer_u32, MipSlice);
		buffer_write(_buffer, buffer_u32, FirstArraySlice);
		buffer_write(_buffer, buffer_u32, ArraySize);
	};
}

/// @func D3D11_TEX3D_UAV()
///
/// @desc
function D3D11_TEX3D_UAV() constructor
{
	/// @var {Real}
	MipSlice = 0;

	/// @var {Real}
	FirstWSlice = 0;

	/// @var {Real}
	WSize = 0;

	/// @func to_buffer(_buffer)
	///
	/// @desc
	///
	/// @param {Id.Buffer} _buffer
	static to_buffer = function (_buffer)
	{
		buffer_write(_buffer, buffer_u32, MipSlice);
		buffer_write(_buffer, buffer_u32, FirstWSlice);
		buffer_write(_buffer, buffer_u32, WSize);
	};
}

/// @func D3D11_UNORDERED_ACCESS_VIEW_DESC()
///
/// @desc
function D3D11_UNORDERED_ACCESS_VIEW_DESC() constructor
{
	/// @var {Real}
	Format = DXGI_FORMAT_UNKNOWN;

	/// @var {Real}
	ViewDimension = D3D11_UAV_DIMENSION_UNKNOWN;

	/// @var {Struct.D3D11_BUFFER_UAV, Undefined}
	Buffer = undefined;

	/// @var {Struct.D3D11_TEX1D_UAV, Undefined}
	Texture1D = undefined;

	/// @var {Struct.D3D11_TEX1D_ARRAY_UAV, Undefined}
	Texture1DArray = undefined;

	/// @var {Struct.D3D11_TEX2D_UAV, Undefined}
	Texture2D = undefined;

	/// @var {Struct.D3D11_TEX2D_ARRAY_UAV, Undefined}
	Texture2DArray = undefined;

	/// @var {Struct.D3D11_TEX3D_UAV, Undefined}
	Texture3D = undefined;

	/// @func to_buffer(_buffer)
	///
	/// @desc
	///
	/// @param {Id.Buffer} _buffer
	static to_buffer = function (_buffer)
	{
		buffer_write(_buffer, buffer_u32, Format);
		buffer_write(_buffer, buffer_u32, ViewDimension);

		switch (ViewDimension)
		{
			case D3D11_UAV_DIMENSION_UNKNOWN:
				break;

			case D3D11_UAV_DIMENSION_BUFFER:
				Buffer.to_buffer(_buffer);
				break;

			case D3D11_UAV_DIMENSION_TEXTURE1D:
				Texture1D.to_buffer(_buffer);
				break;

			case D3D11_UAV_DIMENSION_TEXTURE1DARRAY:
				Texture1DArray.to_buffer(_buffer);
				break;

			case D3D11_UAV_DIMENSION_TEXTURE2D:
				Texture2D.to_buffer(_buffer);
				break;

			case D3D11_UAV_DIMENSION_TEXTURE2DARRAY:
				Texture2DArray.to_buffer(_buffer);
				break;

			case D3D11_UAV_DIMENSION_TEXTURE3D:
				Texture3D.to_buffer(_buffer);
				break;

			default:
				show_error("Invalid ViewDimension!", true);
				break;
		}
	};
}

/// @func D3D11_BUFFER_RTV()
///
/// @desc
function D3D11_BUFFER_RTV() constructor
{
#region Union 1
	/// @var {Real, Undefined}
	FirstElement = undefined;

	/// @var {Real, Undefined}
	ElementOffset = undefined;
#endregion

#region Union 2
	/// @var {Real, Undefined}
	NumElements = undefined;

	/// @var {Real, Undefined}
	ElementWidth = undefined;
#endregion

	/// @func to_buffer(_buffer)
	///
	/// @desc
	///
	/// @param {Id.Buffer} _buffer
	static to_buffer = function (_buffer)
	{
		buffer_write(_buffer, buffer_u32, (FirstElement ?? NumElements) ?? 0);
		buffer_write(_buffer, buffer_u32, (ElementOffset ?? ElementWidth) ?? 0);
	};
}

/// @func D3D11_TEX1D_RTV()
///
/// @desc
function D3D11_TEX1D_RTV() constructor
{
	/// @var {Real}
	MipSlice = 0;

	/// @func to_buffer(_buffer)
	///
	/// @desc
	///
	/// @param {Id.Buffer} _buffer
	static to_buffer = function (_buffer)
	{
		buffer_write(_buffer, buffer_u32, MipSlice);
	};
}

/// @func D3D11_TEX1D_ARRAY_RTV()
///
/// @desc
function D3D11_TEX1D_ARRAY_RTV() constructor
{
	/// @var {Real}
	MipSlice = 0;

	/// @var {Real}
	FirstArraySlice = 0;

	/// @var {Real}
	ArraySize = 0;

	/// @func to_buffer(_buffer)
	///
	/// @desc
	///
	/// @param {Id.Buffer} _buffer
	static to_buffer = function (_buffer)
	{
		buffer_write(_buffer, buffer_u32, MipSlice);
		buffer_write(_buffer, buffer_u32, FirstArraySlice);
		buffer_write(_buffer, buffer_u32, ArraySize);
	};
}

/// @func D3D11_TEX2D_RTV()
///
/// @desc
function D3D11_TEX2D_RTV() constructor
{
	/// @var {Real}
	MipSlice = 0;

	/// @func to_buffer(_buffer)
	///
	/// @desc
	///
	/// @param {Id.Buffer} _buffer
	static to_buffer = function (_buffer)
	{
		buffer_write(_buffer, buffer_u32, MipSlice);
	};
}

/// @func D3D11_TEX2D_ARRAY_RTV()
///
/// @desc
function D3D11_TEX2D_ARRAY_RTV() constructor
{
	/// @var {Real}
	MipSlice = 0;

	/// @var {Real}
	FirstArraySlice = 0;

	/// @var {Real}
	ArraySize = 0;

	/// @func to_buffer(_buffer)
	///
	/// @desc
	///
	/// @param {Id.Buffer} _buffer
	static to_buffer = function (_buffer)
	{
		buffer_write(_buffer, buffer_u32, MipSlice);
		buffer_write(_buffer, buffer_u32, FirstArraySlice);
		buffer_write(_buffer, buffer_u32, ArraySize);
	};
}

/// @func D3D11_TEX2DMS_RTV()
///
/// @desc
function D3D11_TEX2DMS_RTV() constructor
{
	/// @func to_buffer(_buffer)
	///
	/// @desc
	///
	/// @param {Id.Buffer} _buffer
	static to_buffer = function (_buffer)
	{
	};
}

/// @func D3D11_TEX2DMS_ARRAY_RTV()
///
/// @desc
function D3D11_TEX2DMS_ARRAY_RTV() constructor
{
	/// @var {Real}
	FirstArraySlice = 0;

	/// @var {Real}
	ArraySize = 0;

	/// @func to_buffer(_buffer)
	///
	/// @desc
	///
	/// @param {Id.Buffer} _buffer
	static to_buffer = function (_buffer)
	{
		buffer_write(_buffer, buffer_u32, FirstArraySlice);
		buffer_write(_buffer, buffer_u32, ArraySize);
	};
}

/// @func D3D11_TEX3D_RTV()
///
/// @desc
function D3D11_TEX3D_RTV() constructor
{
	/// @var {Real}
	MipSlice = 0;

	/// @var {Real}
	FirstWSlice = 0;

	/// @var {Real}
	WSize = 0;

	/// @func to_buffer(_buffer)
	///
	/// @desc
	///
	/// @param {Id.Buffer} _buffer
	static to_buffer = function (_buffer)
	{
		buffer_write(_buffer, buffer_u32, MostDetailedMip);
		buffer_write(_buffer, buffer_u32, FirstWSlice);
		buffer_write(_buffer, buffer_u32, WSize);
	};
}

/// @func D3D11_RENDER_TARGET_VIEW_DESC()
///
/// @desc
function D3D11_RENDER_TARGET_VIEW_DESC() constructor
{
	/// @var {Real}
	Format = DXGI_FORMAT_UNKNOWN;

	/// @var {Real}
	ViewDimension = D3D11_RTV_DIMENSION_UNKNOWN;

	/// @var {Struct.D3D11_BUFFER_RTV, Undefined}
	Buffer = undefined;

	/// @var {Struct.D3D11_TEX1D_RTV, Undefined}
	Texture1D = undefined;

	/// @var {Struct.D3D11_TEX1D_ARRAY_RTV, Undefined}
	Texture1DArray = undefined;

	/// @var {Struct.D3D11_TEX2D_RTV, Undefined}
	Texture2D = undefined;

	/// @var {Struct.D3D11_TEX2D_ARRAY_RTV, Undefined}
	Texture2DArray = undefined;

	/// @var {Struct.D3D11_TEX2DMS_RTV, Undefined}
	Texture2DMS = undefined;

	/// @var {Struct.D3D11_TEX2DMS_ARRAY_RTV, Undefined}
	Texture2DMSArray = undefined;

	/// @var {Struct.D3D11_TEX3D_RTV, Undefined}
	Texture3D = undefined;

	/// @func to_buffer(_buffer)
	///
	/// @desc
	///
	/// @param {Id.Buffer} _buffer
	static to_buffer = function (_buffer)
	{
		buffer_write(_buffer, buffer_u32, Format);
		buffer_write(_buffer, buffer_u32, ViewDimension);

		switch (ViewDimension)
		{
			case D3D11_RTV_DIMENSION_UNKNOWN:
				break;

			case D3D11_RTV_DIMENSION_BUFFER:
				Buffer.to_buffer(_buffer);
				break;

			case D3D11_RTV_DIMENSION_TEXTURE1D:
				Texture1D.to_buffer(_buffer);
				break;

			case D3D11_RTV_DIMENSION_TEXTURE1DARRAY:
				Texture1DArray.to_buffer(_buffer);
				break;

			case D3D11_RTV_DIMENSION_TEXTURE2D:
				Texture2D.to_buffer(_buffer);
				break;

			case D3D11_RTV_DIMENSION_TEXTURE2DARRAY:
				Texture2DArray.to_buffer(_buffer);
				break;

			case D3D11_RTV_DIMENSION_TEXTURE2DMS:
				Texture2DMS.to_buffer(_buffer);
				break;

			case D3D11_RTV_DIMENSION_TEXTURE2DMSARRAY:
				Texture2DMSArray.to_buffer(_buffer);
				break;

			case D3D11_RTV_DIMENSION_TEXTURE3D:
				Texture3D.to_buffer(_buffer);
				break;

			default:
				show_error("Invalid ViewDimension!", true);
				break;
		}
	};
}

/// @func D3D11_TEX1D_DSV()
///
/// @desc
function D3D11_TEX1D_DSV() constructor
{
	/// @var {Real}
	MipSlice = 0;

	/// @func to_buffer(_buffer)
	///
	/// @desc
	///
	/// @param {Id.Buffer} _buffer
	static to_buffer = function (_buffer)
	{
		buffer_write(_buffer, buffer_u32, MipSlice);
	};
}

/// @func D3D11_TEX1D_ARRAY_DSV()
///
/// @desc
function D3D11_TEX1D_ARRAY_DSV() constructor
{
	/// @var {Real}
	MipSlice = 0;

	/// @var {Real}
	FirstArraySlice = 0;

	/// @var {Real}
	ArraySize = 0;

	/// @func to_buffer(_buffer)
	///
	/// @desc
	///
	/// @param {Id.Buffer} _buffer
	static to_buffer = function (_buffer)
	{
		buffer_write(_buffer, buffer_u32, MipSlice);
		buffer_write(_buffer, buffer_u32, FirstArraySlice);
		buffer_write(_buffer, buffer_u32, ArraySize);
	};
}

/// @func D3D11_TEX2D_DSV()
///
/// @desc
function D3D11_TEX2D_DSV() constructor
{
	/// @var {Real}
	MipSlice = 0;

	/// @func to_buffer(_buffer)
	///
	/// @desc
	///
	/// @param {Id.Buffer} _buffer
	static to_buffer = function (_buffer)
	{
		buffer_write(_buffer, buffer_u32, MipSlice);
	};
}

/// @func D3D11_TEX2D_ARRAY_DSV()
///
/// @desc
function D3D11_TEX2D_ARRAY_DSV() constructor
{
	/// @var {Real}
	MipSlice = 0;

	/// @var {Real}
	FirstArraySlice = 0;

	/// @var {Real}
	ArraySize = 0;

	/// @func to_buffer(_buffer)
	///
	/// @desc
	///
	/// @param {Id.Buffer} _buffer
	static to_buffer = function (_buffer)
	{
		buffer_write(_buffer, buffer_u32, MipSlice);
		buffer_write(_buffer, buffer_u32, FirstArraySlice);
		buffer_write(_buffer, buffer_u32, ArraySize);
	};
}

/// @func D3D11_TEX2DMS_DSV()
///
/// @desc
function D3D11_TEX2DMS_DSV() constructor
{
	/// @func to_buffer(_buffer)
	///
	/// @desc
	///
	/// @param {Id.Buffer} _buffer
	static to_buffer = function (_buffer)
	{
	};
}

/// @func D3D11_TEX2DMS_ARRAY_DSV()
///
/// @desc
function D3D11_TEX2DMS_ARRAY_DSV() constructor
{
	/// @var {Real}
	FirstArraySlice = 0;

	/// @var {Real}
	ArraySize = 0;

	/// @func to_buffer(_buffer)
	///
	/// @desc
	///
	/// @param {Id.Buffer} _buffer
	static to_buffer = function (_buffer)
	{
		buffer_write(_buffer, buffer_u32, FirstArraySlice);
		buffer_write(_buffer, buffer_u32, ArraySize);
	};
}

/// @func D3D11_DEPTH_STENCIL_VIEW_DESC()
///
/// @desc
function D3D11_DEPTH_STENCIL_VIEW_DESC() constructor
{
	/// @var {Real}
	Format = DXGI_FORMAT_UNKNOWN;

	/// @var {Real}
	ViewDimension = D3D11_RTV_DIMENSION_UNKNOWN;

	/// @var {Real}
	Flags = 0;

	/// @var {Struct.D3D11_TEX1D_DSV, Undefined}
	Texture1D = undefined;

	/// @var {Struct.D3D11_TEX1D_ARRAY_DSV, Undefined}
	Texture1DArray = undefined;

	/// @var {Struct.D3D11_TEX2D_DSV, Undefined}
	Texture2D = undefined;

	/// @var {Struct.D3D11_TEX2D_ARRAY_DSV, Undefined}
	Texture2DArray = undefined;

	/// @var {Struct.D3D11_TEX2DMS_DSV, Undefined}
	Texture2DMS = undefined;

	/// @var {Struct.D3D11_TEX2DMS_ARRAY_DSV, Undefined}
	Texture2DMSArray = undefined;

	/// @func to_buffer(_buffer)
	///
	/// @desc
	///
	/// @param {Id.Buffer} _buffer
	static to_buffer = function (_buffer)
	{
		buffer_write(_buffer, buffer_u32, Format);
		buffer_write(_buffer, buffer_u32, ViewDimension);
		buffer_write(_buffer, buffer_u32, Flags);

		switch (ViewDimension)
		{
			case D3D11_DSV_DIMENSION_UNKNOWN:
				break;

			case D3D11_DSV_DIMENSION_TEXTURE1D:
				Texture1D.to_buffer(_buffer);
				break;

			case D3D11_DSV_DIMENSION_TEXTURE1DARRAY:
				Texture1DArray.to_buffer(_buffer);
				break;

			case D3D11_DSV_DIMENSION_TEXTURE2D:
				Texture2D.to_buffer(_buffer);
				break;

			case D3D11_DSV_DIMENSION_TEXTURE2DARRAY:
				Texture2DArray.to_buffer(_buffer);
				break;

			case D3D11_DSV_DIMENSION_TEXTURE2DMS:
				Texture2DMS.to_buffer(_buffer);
				break;

			case D3D11_DSV_DIMENSION_TEXTURE2DMSARRAY:
				Texture2DMSArray.to_buffer(_buffer);
				break;

			default:
				show_error("Invalid ViewDimension!", true);
				break;
		}
	};
}

/// @func D3D11_VIEWPORT()
///
/// @desc
function D3D11_VIEWPORT() constructor
{
	/// @var {Real}
	TopLeftX = 0.0;

	/// @var {Real}
	TopLeftY = 0.0;

	/// @var {Real}
	Width = 0.0;

	/// @var {Real}
	Height = 0.0;

	/// @var {Real}
	MinDepth = 0.0;

	/// @var {Real}
	MaxDepth = 0.0;

	/// @func to_buffer(_buffer)
	///
	/// @desc
	///
	/// @param {Id.Buffer} _buffer
	static to_buffer = function (_buffer)
	{
		buffer_write(_buffer, buffer_f32, TopLeftX);
		buffer_write(_buffer, buffer_f32, TopLeftY);
		buffer_write(_buffer, buffer_f32, Width);
		buffer_write(_buffer, buffer_f32, Height);
		buffer_write(_buffer, buffer_f32, MinDepth);
		buffer_write(_buffer, buffer_f32, MaxDepth);
	};
}

/// @func D3D11_SAMPLER_DESC()
///
/// @desc
function D3D11_SAMPLER_DESC() constructor
{
	/// @var {Real}
	Filter = D3D11_FILTER_MIN_MAG_MIP_POINT;

	/// @var {Real}
	AddressU = D3D11_TEXTURE_ADDRESS_WRAP;

	/// @var {Real}
	AddressV = D3D11_TEXTURE_ADDRESS_WRAP;

	/// @var {Real}
	AddressW = D3D11_TEXTURE_ADDRESS_WRAP;

	/// @var {Real}
	MipLODBias = 0.0;

	/// @var {Real}
	MaxAnisotropy = 0;

	/// @var {Real}
	ComparisonFunc = D3D11_COMPARISON_NEVER;

	/// @var {Array<Real>}
	BorderColor[0] = array_create(4, 0);

	/// @var {Real}
	MinLOD = 0.0;

	/// @var {Real}
	MaxLOD = 0.0;

	/// @func to_buffer(_buffer)
	///
	/// @desc
	///
	/// @param {Id.Buffer} _buffer
	static to_buffer = function (_buffer)
	{
		buffer_write(_buffer, buffer_u32, Filter);
		buffer_write(_buffer, buffer_u32, AddressU);
		buffer_write(_buffer, buffer_u32, AddressV);
		buffer_write(_buffer, buffer_u32, AddressW);
		buffer_write(_buffer, buffer_f32, MipLODBias);
		buffer_write(_buffer, buffer_u32, MaxAnisotropy);
		buffer_write(_buffer, buffer_u32, ComparisonFunc);
		buffer_write(_buffer, buffer_u32, BorderColor[0]);
		buffer_write(_buffer, buffer_u32, BorderColor[1]);
		buffer_write(_buffer, buffer_u32, BorderColor[2]);
		buffer_write(_buffer, buffer_u32, BorderColor[3]);
		buffer_write(_buffer, buffer_f32, MinLOD);
		buffer_write(_buffer, buffer_f32, MaxLOD);
	};
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Helpers
//

/// @func d3d11_get_scratch_buffer(_sizeMin)
///
/// @desc
///
/// @param {Real} _sizeMin
///
/// @return {Id.Buffer}
function d3d11_get_scratch_buffer(_sizeMin = 1)
{
	static _buffer = buffer_create(_sizeMin, buffer_grow, 1);
	var _bufferSize = buffer_get_size(_buffer);
	if (_bufferSize < _sizeMin)
	{
		buffer_resize(_buffer, _sizeMin);
	}
	buffer_seek(_buffer, buffer_seek_start, 0);
	return _buffer;
}

/// @func texture_set_stage_vs(_slot, _texture)
///
/// @desc If GMD3D11 is supported, then uses {@link d3d11_texture_set_stage_vs} to pass a texture to a vertex shader,
/// otherwise uses `texture_set_stage` (which should work on OpenGL platforms).
///
/// @param {Id.Sampler} _slot The vertex texture slot index. Must be in range 0..7.
/// @param {Pointer.Texture} _texture The texture to pass.
function texture_set_stage_vs(_slot, _texture)
{
	gml_pragma("forceinline");
	if (GMD3D11_IS_SUPPORTED)
	{
		d3d11_texture_set_stage_vs(_slot, _texture);
		return;
	}
	texture_set_stage(_slot, _texture);
}

/// @func vertex_submit_instanced(_vbuff, _prim, _texture, _count)
///
/// @desc Draws multiple instances of a vertex buffer.
///
/// @param {Id.VertexBuffer} _vbuff The vertex buffer to submit.
/// @param {Constant.PrimitiveType} _prim The primitive type.
/// @param {Pointer.Texture} _texture The texture to use.
/// @param {Real} _count The number of instances to draw.
function vertex_submit_instanced(_vbuff, _prim, _texture, _count)
{
	gml_pragma("forceinline");
	if (!d3d11_draw_instanced(_count))
	{
		return false;
	}
	vertex_submit(_vbuff, _prim, _texture);
	return true;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Initilization
//

if (GMD3D11_IS_SUPPORTED)
{
	var _init = external_define(
		GMD3D11_PATH, "d3d11_init", dll_cdecl, ty_real, 2, ty_string, ty_string);
	var _osInfo = os_get_info();
	var _device = _osInfo[? "video_d3d11_device"];
	var _context = _osInfo[? "video_d3d11_context"];
	external_call(_init, _device, _context);
}
