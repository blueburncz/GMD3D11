#include <Struct.hpp>

#include <cstdint>
#include <DirectXMath.h>

static Struct* g_StructCurrent = nullptr;

static inline size_t RoundUp16(size_t value)
{
    return ((value + 15) & ~static_cast<size_t>(15));
}

bool Struct::AddMember(StructMemberType type)
{
    size_t size = 0;

    switch (type)
    {
    case StructMemberType::Bool:
        size = sizeof(bool);
        break;

    case StructMemberType::Int:
        size = sizeof(int32_t);
        break;

    case StructMemberType::Int2:
        size = sizeof(DirectX::XMINT2);
        break;

    case StructMemberType::Int3:
        size = sizeof(DirectX::XMINT3);
        break;
    
    case StructMemberType::Int4:
        size = sizeof(DirectX::XMINT4);
        break;

    case StructMemberType::Uint:
        size = sizeof(uint32_t);
        break;

    case StructMemberType::Uint2:
        size = sizeof(DirectX::XMUINT2);
        break;

    case StructMemberType::Uint3:
        size = sizeof(DirectX::XMUINT3);
        break;
    
    case StructMemberType::Uint4:
        size = sizeof(DirectX::XMUINT4);
        break;

    case StructMemberType::Float:
        size = sizeof(float);
        break;
    
    case StructMemberType::Float2:
        size = sizeof(DirectX::XMFLOAT2);
        break;

    case StructMemberType::Float3:
        size = sizeof(DirectX::XMFLOAT3);
        break;

    case StructMemberType::Float4:
        size = sizeof(DirectX::XMFLOAT4);
        break;

    case StructMemberType::Float4x4:
        size = sizeof(DirectX::XMFLOAT4X4);
        break;

    default:
        return false;
    }

    size_t offset = Size;
    size_t offset16 = Size16;

    Size += size;
    Size16 = RoundUp16(Size16 + size);

    Members.push_back({type, offset, offset16, size, RoundUp16(size)});

    return true;
}

/// @func d3d11_struct_begin()
///
/// @desc Start building a struct.
///
/// @see d3d11_struct_end
GM_EXPORT ty_real d3d11_struct_begin()
{
    if (g_StructCurrent)
    {
        return GM_FALSE;
    }
    g_StructCurrent = new Struct();
    return GM_TRUE;
}

/// @func d3d11_struct_end()
///
/// @desc Finishes building a struct.
///
/// @return {Real} The ID of the created struct or -1 on fail.
///
/// @see d3d11_struct_exists
GM_EXPORT ty_real d3d11_struct_end()
{
    if (!g_StructCurrent)
    {
        return -1.0;
    }

    size_t id = g_StructCurrent->GetID();
    g_StructCurrent = nullptr;
    return static_cast<ty_real>(id);
}

/// @func d3d11_struct_add_member(_type)
///
/// @desc Adds a member to a struct that is currently being built.
///
/// @param {Real} _type The type of the member to add.
///
/// @see d3d11_struct_begin
GM_EXPORT ty_real d3d11_struct_add_member(ty_real _type)
{
    if (_type < 0.0 || _type >= static_cast<ty_real>(StructMemberType::SIZE))
    {
        return GM_FALSE;
    }
    return g_StructCurrent->AddMember(static_cast<StructMemberType>(_type)) ? GM_TRUE : GM_FALSE;
}

/// @func d3d11_struct_exists(_struct)
///
/// @desc Checks whether a struct with given ID exists.
///
/// @return {Bool} Returns 1 if the struct exists or 0 otherwise.
GM_EXPORT ty_real d3d11_struct_exists(ty_real _struct)
{
    return (_struct >= 0.0 && Struct::Exists(static_cast<size_t>(_struct))) ? GM_TRUE : GM_FALSE;
}

/// @func d3d11_struct_destroy(_struct)
///
/// @desc Destroys a struct with given ID.
///
/// @param {Real} _struct The ID of the struct to destroy.
GM_EXPORT ty_real d3d11_struct_destroy(ty_real _struct)
{
    delete Struct::Get(static_cast<size_t>(_struct));
    return GM_TRUE;
}

/// @func d3d11_struct_get_member_count(_struct)
///
/// @desc Retrieves the number of member that a struct has.
///
/// @param {Real} _struct The ID of the struct.
///
/// @return {Real} The number of members that the struct has.
GM_EXPORT ty_real d3d11_struct_get_member_count(ty_real _struct)
{
    return static_cast<ty_real>(Struct::Get(static_cast<size_t>(_struct))->GetMemberCount());
}

/// @func d3d11_struct_get_member_type(_struct, _index)
///
/// @desc Retrieves the type of a struct member with given index.
///
/// @param {Real} _struct The ID of the struct.
/// @param {Real} _index The index of the struct member.
///
/// @return {Real} The type of the member on success of -1 on fail.
GM_EXPORT ty_real d3d11_struct_get_member_type(ty_real _struct, ty_real _index)
{
    if (_index < 0)
    {
        return -1.0;
    }

    Struct* pStruct = Struct::Get(static_cast<size_t>(_struct));
    size_t count = pStruct->GetMemberCount();

    if (static_cast<size_t>(_index) >= count)
    {
        return -1.0;
    }

    return static_cast<ty_real>(pStruct->GetMemberType(static_cast<size_t>(_index)));
}

/// @func d3d11_struct_get_member_offset(_struct, _index)
///
/// @desc Retrieves an offset of a member with given index within a struct.
///
/// @param {Real} _struct The ID of the struct.
/// @param {Real} _index The index of the member. Use values in range 0..{@link d3d11_struct_get_member_count}-1.
///
/// @return {Real} The member's offset or -1 if given struct does not have a member with given index.
GM_EXPORT ty_real d3d11_struct_get_member_offset(ty_real _struct, ty_real _index)
{
    if (_index < 0)
    {
        return -1.0;
    }

    Struct* pStruct = Struct::Get(static_cast<size_t>(_struct));
    size_t count = pStruct->GetMemberCount();

    if (static_cast<size_t>(_index) >= count)
    {
        return -1.0;
    }

    return static_cast<ty_real>(pStruct->GetMemberOffset(static_cast<size_t>(_index)));
}

/// @func d3d11_struct_get_member_offset16(_struct, _index)
///
/// @desc Retrieves 16 byte-aligned offset of a member with given index within a struct.
///
/// @param {Real} _struct The ID of the struct.
/// @param {Real} _index The index of the member. Use values in range 0..{@link d3d11_struct_get_member_count}-1.
///
/// @return {Real} The member's offset aligned to 16 bytes or -1 if given struct does not have a member with given index.
GM_EXPORT ty_real d3d11_struct_get_member_offset16(ty_real _struct, ty_real _index)
{
    if (_index < 0)
    {
        return -1.0;
    }

    Struct* pStruct = Struct::Get(static_cast<size_t>(_struct));
    size_t count = pStruct->GetMemberCount();

    if (static_cast<size_t>(_index) >= count)
    {
        return -1.0;
    }

    return static_cast<ty_real>(pStruct->GetMemberOffset16(static_cast<size_t>(_index)));
}

/// @func d3d11_struct_get_member_size(_struct, _index)
///
/// @desc Retrieves size (in bytes) of a member with given index within a struct.
///
/// @param {Real} _struct The ID of the struct.
/// @param {Real} _index The index of the member. Use values in range 0..{@link d3d11_struct_get_member_count}-1.
///
/// @return {Real} The member's size (in bytes) or -1 if given struct does not have a member with given index.
GM_EXPORT ty_real d3d11_struct_get_member_size(ty_real _struct, ty_real _index)
{
    if (_index < 0)
    {
        return -1.0;
    }

    Struct* pStruct = Struct::Get(static_cast<size_t>(_struct));
    size_t count = pStruct->GetMemberCount();

    if (static_cast<size_t>(_index) >= count)
    {
        return -1.0;
    }

    return static_cast<ty_real>(pStruct->GetMemberSize(static_cast<size_t>(_index)));
}

/// @func d3d11_struct_get_member_size(_struct, _index)
///
/// @desc Retrieves 16 byte-aligned size of a member with given index within a struct.
///
/// @param {Real} _struct The ID of the struct.
/// @param {Real} _index The index of the member. Use values in range 0..{@link d3d11_struct_get_member_count}-1.
///
/// @return {Real} The member's size aligned to 16 bytes or -1 if given struct does not have a member with given index.
GM_EXPORT ty_real d3d11_struct_get_member_size16(ty_real _struct, ty_real _index)
{
    if (_index < 0)
    {
        return -1.0;
    }

    Struct* pStruct = Struct::Get(static_cast<size_t>(_struct));
    size_t count = pStruct->GetMemberCount();

    if (static_cast<size_t>(_index) >= count)
    {
        return -1.0;
    }

    return static_cast<ty_real>(pStruct->GetMemberSize16(static_cast<size_t>(_index)));
}

/// @func d3d11_struct_get_size(_struct)
///
/// @desc Retrieves size (in bytes) of a struct.
///
/// @param {Real} _struct The ID of the struct.
///
/// @return {Real} The struct's size in bytes.
GM_EXPORT ty_real d3d11_struct_get_size(ty_real _struct)
{
    return static_cast<ty_real>(Struct::Get(static_cast<size_t>(_struct))->GetSize());
}

/// @func d3d11_struct_get_size16(_struct)
///
/// @desc Retrieves 16 byte-aligned size of a struct.
///
/// @param {Real} _struct The ID of the struct.
///
/// @return {Real} The struct's size aligned to 16 bytes.
GM_EXPORT ty_real d3d11_struct_get_size16(ty_real _struct)
{
    return static_cast<ty_real>(Struct::Get(static_cast<size_t>(_struct))->GetSize16());
}
