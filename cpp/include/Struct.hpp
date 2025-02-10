#pragma once 

#include <common.hpp>

#include <Trackable.hpp>

#include <vector>

enum class StructMemberType : uint32_t
{
    Bool = 0,
    Int,
    Int2,
    Int3,
    Int4,
    Uint,
    Uint2,
    Uint3,
    Uint4,
    Float,
    Float2,
    Float3,
    Float4,
    Float4x4,
    SIZE
};

struct StructMember
{
    StructMemberType Type;
    size_t Offset;
    size_t Offset16;
    size_t Size;
    size_t Size16;
};

class Struct final : public Trackable<Struct>
{
public:
    bool AddMember(StructMemberType type);

    size_t GetMemberCount() const { return Members.size(); }

    StructMemberType GetMemberType(size_t index) const { return Members.at(index).Type; }

    size_t GetMemberOffset(size_t index) const { return Members.at(index).Offset; }

    size_t GetMemberOffset16(size_t index) const { return Members.at(index).Offset16; }

    size_t GetMemberSize(size_t index) const { return Members.at(index).Size; }

    size_t GetMemberSize16(size_t index) const { return Members.at(index).Size16; }

    size_t GetSize() const { return Size; }

    size_t GetSize16() const { return Size16; }

private:
    std::vector<StructMember> Members;
    size_t Size = 0;
    size_t Size16 = 0;
};
